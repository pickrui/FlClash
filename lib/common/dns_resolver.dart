import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

class DnsResolver {
  static const String defaultDohServer = 'https://doh.pub/dns-query';
  static const Duration timeout = Duration(seconds: 5);
  static const Duration _cacheDuration = Duration(minutes: 5);
  
  static final Map<String, _DnsCache> _cache = {};

  static Future<List<String>> resolve(
    String hostname, {
    String? dohServer,
    bool useCache = true,
  }) async {
    if (useCache && _cache.containsKey(hostname)) {
      final cached = _cache[hostname]!;
      if (DateTime.now().difference(cached.timestamp) < _cacheDuration) {
        return cached.addresses;
      }
      _cache.remove(hostname);
    }

    final doh = dohServer ?? defaultDohServer;
    
    try {
      final query = _buildDnsQuery(hostname);
      final client = HttpClient();
      
      client.findProxy = (Uri uri) => 'DIRECT';
      client.connectionTimeout = timeout;
      
      try {
        final uri = Uri.parse(doh);
        final request = await client.postUrl(uri);
        
        request.headers.set('Content-Type', 'application/dns-message');
        request.headers.set('Accept', 'application/dns-message');
        request.contentLength = query.length;
        request.add(query);
        
        final response = await request.close().timeout(timeout);
        
        if (response.statusCode != HttpStatus.ok) {
          return [];
        }
        
        final responseData = <int>[];
        await for (final chunk in response) {
          responseData.addAll(chunk);
        }
        
        final addresses = _parseDnsResponse(Uint8List.fromList(responseData));
        
        if (addresses.isNotEmpty && useCache) {
          _cache[hostname] = _DnsCache(addresses, DateTime.now());
        }
        
        return addresses;
      } finally {
        client.close(force: true);
      }
    } catch (e) {
      return [];
    }
  }

  static void clearCache([String? hostname]) {
    if (hostname != null) {
      _cache.remove(hostname);
    } else {
      _cache.clear();
    }
  }

  static Future<void> warmupCache(List<String> hostnames) async {
    await Future.wait(
      hostnames.map((hostname) => resolve(hostname)),
      eagerError: false,
    );
  }

  static Uint8List _buildDnsQuery(String hostname) {
    final buffer = ByteData(512);
    int offset = 0;
    
    buffer.setUint16(offset, DateTime.now().millisecondsSinceEpoch & 0xFFFF, Endian.big);
    offset += 2;
    buffer.setUint16(offset, 0x0100, Endian.big);
    offset += 2;
    buffer.setUint16(offset, 1, Endian.big);
    offset += 2;
    buffer.setUint16(offset, 0, Endian.big);
    offset += 2;
    buffer.setUint16(offset, 0, Endian.big);
    offset += 2;
    buffer.setUint16(offset, 0, Endian.big);
    offset += 2;
    
    final parts = hostname.split('.');
    for (final part in parts) {
      buffer.setUint8(offset, part.length);
      offset += 1;
      for (int i = 0; i < part.length; i++) {
        buffer.setUint8(offset, part.codeUnitAt(i));
        offset += 1;
      }
    }
    buffer.setUint8(offset, 0);
    offset += 1;
    buffer.setUint16(offset, 1, Endian.big);
    offset += 2;
    buffer.setUint16(offset, 1, Endian.big);
    offset += 2;
    
    return buffer.buffer.asUint8List(0, offset);
  }

  static List<String> _parseDnsResponse(Uint8List data) {
    final addresses = <String>[];
    
    try {
      if (data.length < 12) return addresses;
      
      final flags = (data[2] << 8) | data[3];
      final rcode = flags & 0x0F;
      if (rcode != 0) return addresses;
      
      final questionCount = (data[4] << 8) | data[5];
      final answerCount = (data[6] << 8) | data[7];
      
      if (answerCount == 0) return addresses;
      
      int offset = 12;
      for (int i = 0; i < questionCount; i++) {
        while (offset < data.length && data[offset] != 0) {
          if ((data[offset] & 0xC0) == 0xC0) {
            offset += 2;
            break;
          }
          final length = data[offset];
          offset += length + 1;
        }
        if (data[offset - 1] == 0 || offset >= data.length) {
          offset += 4;
        }
      }
      
      for (int i = 0; i < answerCount && offset < data.length; i++) {
        if ((data[offset] & 0xC0) == 0xC0) {
          offset += 2;
        } else {
          while (offset < data.length && data[offset] != 0) {
            final length = data[offset];
            offset += length + 1;
          }
          offset += 1;
        }
        
        if (offset + 10 > data.length) break;
        
        final type = (data[offset] << 8) | data[offset + 1];
        offset += 2;
        offset += 2;
        offset += 4;
        
        final rdLength = (data[offset] << 8) | data[offset + 1];
        offset += 2;
        
        if (type == 1 && rdLength == 4 && offset + 4 <= data.length) {
          final ip = '${data[offset]}.${data[offset + 1]}.${data[offset + 2]}.${data[offset + 3]}';
          addresses.add(ip);
        }
        
        offset += rdLength;
      }
    } catch (e) {
      // Ignore DNS parsing errors
    }
    
    return addresses;
  }
}

class _DnsCache {
  final List<String> addresses;
  final DateTime timestamp;

  _DnsCache(this.addresses, this.timestamp);
}