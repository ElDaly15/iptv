import 'package:dio/dio.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.contentType = Headers.formUrlEncodedContentType;
    super.onRequest(options, handler);
  }
}
