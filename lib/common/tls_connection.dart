import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

/// Retains the raw TCP socket through TLS negotiation. SecureSocket.secure()
/// detaches its input Socket, whose destroy() then cannot cancel the handshake.
Future<ConnectionTask<Socket>> startTlsConnection(
  InternetAddress address,
  int port, {
  required String host,
  SecurityContext? context,
  bool Function(X509Certificate)? onBadCertificate,
}) async {
  final tcp = await RawSocket.startConnect(address, port);
  RawSocket? raw;
  Socket? secured;
  var canceled = false;
  final result = Completer<Socket>();
  final future = () async {
    try {
      final socket = raw = await tcp.socket;
      if (canceled) throw const SocketException('Connection attempt cancelled');
      final tls = await RawSecureSocket.secure(
        socket,
        host: host,
        context: context,
        onBadCertificate: onBadCertificate,
      );
      if (canceled) {
        await tls.close();
        throw const SocketException('Connection attempt cancelled');
      }
      return secured = _TlsSocket(tls);
    } catch (_) {
      await raw?.close();
      rethrow;
    }
  }();
  unawaited(
    future.then<void>(
      (socket) {
        if (result.isCompleted) {
          socket.destroy();
        } else {
          result.complete(socket);
        }
      },
      onError: (Object error, StackTrace stack) {
        if (!result.isCompleted) result.completeError(error, stack);
      },
    ),
  );
  return ConnectionTask.fromSocket<Socket>(result.future, () {
    canceled = true;
    // RawSecureSocket closes its filter on local TCP close, but does not
    // complete a pending handshake Future. Complete our caller explicitly.
    if (!result.isCompleted) {
      result.completeError(
        const SocketException('Connection attempt cancelled'),
      );
    }
    tcp.cancel();
    if (secured case final socket?) {
      socket.destroy();
    } else {
      unawaited(raw?.close());
    }
  });
}

/// Stream/IOSink facade over public RawSecureSocket APIs for HttpClient.
/// Reading honors subscription pauses; writing waits for raw buffer space.
class _TlsSocket extends Stream<Uint8List> implements SecureSocket {
  _TlsSocket(this._raw) {
    _raw.readEventsEnabled = false;
    _raw.writeEventsEnabled = false;
    _incoming = StreamController<Uint8List>(
      sync: true,
      onListen: () => _raw.readEventsEnabled = !_destroyed,
      onPause: () => _raw.readEventsEnabled = false,
      onResume: () => _raw.readEventsEnabled = !_destroyed,
      onCancel: destroy,
    );
    _consumer = _TlsConsumer(this);
    _sink = IOSink(_consumer);
    // Errors remain observable on done; an idle sink must not emit an
    // unhandled error merely because the peer closed the transport.
    unawaited(
      _sink.done.then<void>((_) {}, onError: (Object _, StackTrace _) {}),
    );
    _raw.listen(_onEvent, onError: _onError, onDone: destroy);
  }

  final RawSecureSocket _raw;
  late final StreamController<Uint8List> _incoming;
  late final IOSink _sink;
  late final _TlsConsumer _consumer;
  Future<void>? _binding;
  Completer<void>? _writable;
  bool _destroyed = false;

  void _onEvent(RawSocketEvent event) {
    if (_destroyed) return;
    if (event == RawSocketEvent.read) {
      final bytes = _raw.read();
      if (bytes != null && !_incoming.isClosed) _incoming.add(bytes);
    } else if (event == RawSocketEvent.write) {
      _raw.writeEventsEnabled = false;
      _writable?.complete();
      _writable = null;
    } else if (event == RawSocketEvent.readClosed) {
      unawaited(_incoming.close());
    } else if (event == RawSocketEvent.closed) {
      destroy();
    }
  }

  void _onError(Object error, StackTrace stack) {
    if (!_incoming.isClosed) _incoming.addError(error, stack);
    destroy();
  }

  Future<void> _write(List<int> bytes) async {
    var offset = 0;
    while (offset < bytes.length) {
      if (_destroyed) throw const SocketException('Connection closed');
      final written = _raw.write(bytes, offset, bytes.length - offset);
      offset += written;
      if (offset < bytes.length) {
        final ready = _writable ??= Completer<void>();
        _raw.writeEventsEnabled = true;
        await ready.future;
      }
    }
  }

  @override
  void destroy() {
    if (_destroyed) return;
    _destroyed = true;
    // Wake a blocked writer; it observes _destroyed before its next write.
    _writable?.complete();
    _writable = null;
    unawaited(_raw.close());
    unawaited(_incoming.close());
    _consumer.stop();
    unawaited(_closeSinkAfterBinding());
  }

  Future<void> _closeSinkAfterBinding() async {
    try {
      await _binding;
    } catch (_) {}
    try {
      await _sink.close();
    } catch (_) {}
  }

  @override
  StreamSubscription<Uint8List> listen(
    void Function(Uint8List)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) => _incoming.stream.listen(
    onData,
    onError: onError,
    onDone: onDone,
    cancelOnError: cancelOnError,
  );

  @override
  void add(List<int> data) => _sink.add(data);
  @override
  void addError(Object error, [StackTrace? stackTrace]) =>
      throw UnsupportedError('Socket.addError');
  @override
  Future<void> addStream(Stream<List<int>> stream) =>
      _binding = _sink.addStream(stream);
  @override
  Future<void> flush() => _binding = _sink.flush();
  @override
  Future<void> close() async {
    await _sink.close();
  }

  @override
  Future<void> get done async {
    await _sink.done;
  }

  @override
  Encoding get encoding => _sink.encoding;
  @override
  set encoding(Encoding value) => _sink.encoding = value;
  @override
  void write(Object? object) => _sink.write(object);
  @override
  void writeAll(Iterable objects, [String separator = '']) =>
      _sink.writeAll(objects, separator);
  @override
  void writeCharCode(int charCode) => _sink.writeCharCode(charCode);
  @override
  void writeln([Object? object = '']) => _sink.writeln(object);
  @override
  InternetAddress get address => _raw.address;
  @override
  InternetAddress get remoteAddress => _raw.remoteAddress;
  @override
  int get port => _raw.port;
  @override
  int get remotePort => _raw.remotePort;
  @override
  bool setOption(SocketOption option, bool enabled) =>
      _raw.setOption(option, enabled);
  @override
  Uint8List getRawOption(RawSocketOption option) => _raw.getRawOption(option);
  @override
  void setRawOption(RawSocketOption option) => _raw.setRawOption(option);
  @override
  X509Certificate? get peerCertificate => _raw.peerCertificate;
  @override
  String? get selectedProtocol => _raw.selectedProtocol;
  @override
  void renegotiate({
    bool useSessionCache = true,
    bool requestClientCertificate = false,
    bool requireClientCertificate = false,
  }) {}
}

class _TlsConsumer implements StreamConsumer<List<int>> {
  _TlsConsumer(this.socket);
  final _TlsSocket socket;
  StreamIterator<List<int>>? _input;

  void stop() {
    unawaited(_input?.cancel());
  }

  @override
  Future<void> addStream(Stream<List<int>> stream) async {
    final input = _input = StreamIterator(stream);
    try {
      while (await input.moveNext()) {
        await socket._write(input.current);
      }
    } finally {
      await input.cancel();
      if (identical(_input, input)) _input = null;
    }
  }

  @override
  Future<void> close() async {
    if (!socket._destroyed) socket._raw.shutdown(SocketDirection.send);
  }
}
