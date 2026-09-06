import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class PendingCloudRequest {
  final RequestOptions options;
  final response = Completer<ResponseBody>();

  PendingCloudRequest(this.options);

  void respond(Object data, {int statusCode = 200}) {
    response.complete(
      ResponseBody.fromString(
        jsonEncode(data),
        statusCode,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      ),
    );
  }
}

class QueuedCloudAdapter implements HttpClientAdapter {
  final _requests = <PendingCloudRequest>[];
  int requestCount = 0;
  Completer<void>? _requestAvailable;

  Dio createClient() => Dio(
    BaseOptions(
      baseUrl: 'https://cloud.test/api/v1',
      validateStatus: (status) => status != null && status < 500,
    ),
  )..httpClientAdapter = this;

  Future<PendingCloudRequest> takeRequest() async {
    while (_requests.isEmpty) {
      final available = _requestAvailable ??= Completer<void>();
      await available.future;
    }
    return _requests.removeAt(0);
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    requestCount++;
    final request = PendingCloudRequest(options);
    _requests.add(request);
    _requestAvailable?.complete();
    _requestAvailable = null;
    return request.response.future;
  }

  @override
  void close({bool force = false}) {}
}
