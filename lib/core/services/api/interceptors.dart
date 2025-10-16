import 'package:dio/dio.dart';
import 'package:iptv/core/services/secure_storage.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler)async{
    options.contentType = Headers.formUrlEncodedContentType;
    super.onRequest(options, handler);
    var token = await getToken();
    if(token != null){
      options.headers['Authorization'] = 'Bearer $token';
    }
  }
}
