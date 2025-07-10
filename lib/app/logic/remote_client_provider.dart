import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final remoteClientProvider = Provider<Dio>((ref) {
  return Dio()
    ..options.connectTimeout = const Duration(seconds: 15)
    ..options.sendTimeout = const Duration(seconds: 15)
    ..options.receiveTimeout = const Duration(seconds: 15);
});
