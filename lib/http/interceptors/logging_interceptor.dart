import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    // print('url ${data.baseUrl}');
    // print('headers ${data.headers}');
    // print('body ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    // print('headers ${data.headers}');
    // print('status code ${data.statusCode}');
    // print('body ${data.body}');
    // print(data);
    return data;
  }
}
