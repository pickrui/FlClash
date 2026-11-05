import 'dart:typed_data';

const int maxIpcFrameLength = 64 * 1024 * 1024;

Uint8List encodeIpcFrame(List<int> payload) {
  final frame = Uint8List(4 + payload.length);
  ByteData.sublistView(frame).setUint32(0, payload.length, Endian.little);
  frame.setRange(4, frame.length, payload);
  return frame;
}

class IpcFrameDecoder {
  Uint8List _pending = Uint8List(0);

  List<Uint8List> add(Uint8List chunk) {
    Uint8List data;
    if (_pending.isEmpty) {
      data = chunk;
    } else {
      data = Uint8List(_pending.length + chunk.length)
        ..setRange(0, _pending.length, _pending)
        ..setRange(_pending.length, _pending.length + chunk.length, chunk);
    }
    final frames = <Uint8List>[];
    var offset = 0;
    while (data.length - offset >= 4) {
      final length = ByteData.sublistView(
        data,
        offset,
        offset + 4,
      ).getUint32(0, Endian.little);
      if (length > maxIpcFrameLength) {
        throw const FormatException('IPC frame too large');
      }
      if (data.length - offset - 4 < length) {
        break;
      }
      frames.add(
        Uint8List.fromList(data.sublist(offset + 4, offset + 4 + length)),
      );
      offset += 4 + length;
    }
    _pending = Uint8List.fromList(data.sublist(offset));
    return frames;
  }
}
