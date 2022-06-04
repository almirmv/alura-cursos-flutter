import 'package:bytebank/http/interceptors/logging_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

const String baseUrl = 'http://192.168.3.107:8080';

//para uso do http_interceptor
final http.Client client = InterceptedClient.build(interceptors: [
  LoggingInterceptor(),
]);
