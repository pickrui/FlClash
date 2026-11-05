import 'dart:async';

import 'package:dio/dio.dart';

/// Runs explicitly replayable reads. A candidate must finish receiving and
/// validating its response before returning; the first valid result wins.
/// Authentication does not change whether a read is replayable.
Future<T> raceHttpReads<T>(
  Iterable<Future<T> Function(CancelToken token)> reads, {
  required Duration timeout,
  CancelToken? cancelToken,
  bool Function(Object error)? isTerminalError,
}) async {
  final actions = reads.toList();
  if (actions.isEmpty) throw ArgumentError('No HTTP read routes');
  final cancelled = cancelToken?.cancelError;
  if (cancelled != null) throw cancelled;
  if (timeout <= Duration.zero) {
    throw TimeoutException('HTTP read timed out', timeout);
  }
  final result = Completer<T>();
  final tokens = [for (final _ in actions) CancelToken()];
  final terminal = isTerminalError ?? isTerminalHttpReadError;
  var remaining = actions.length;
  final deadline = Timer(timeout, () {
    if (!result.isCompleted) {
      result.completeError(TimeoutException('HTTP read timed out', timeout));
    }
  });
  final cancellation = cancelToken?.whenCancel.asStream().listen((error) {
    if (!result.isCompleted) result.completeError(error);
  });
  for (var index = 0; index < actions.length; index++) {
    unawaited(
      Future.sync(() => actions[index](tokens[index])).then(
        (value) {
          if (!result.isCompleted) result.complete(value);
        },
        onError: (Object error, StackTrace stack) {
          if (result.isCompleted) return;
          if (--remaining == 0 || terminal(error)) {
            result.completeError(error, stack);
          }
        },
      ),
    );
  }
  try {
    return await result.future;
  } finally {
    deadline.cancel();
    for (final token in tokens) {
      token.cancel('HTTP read finished');
    }
    await cancellation?.cancel();
  }
}

bool isTerminalHttpReadError(Object error) {
  if (error is! DioException) return false;
  final status = error.response?.statusCode;
  return error.type == DioExceptionType.cancel ||
      error.type == DioExceptionType.badCertificate ||
      status == 401 ||
      status == 403;
}

/// Public CDNs may deny one egress without rejecting an account. Callers must
/// only use this policy for requests without credentials or query tokens.
bool isTerminalPublicHttpReadError(Object error) {
  if (error is DioException && error.response?.statusCode == 403) return false;
  return isTerminalHttpReadError(error);
}
