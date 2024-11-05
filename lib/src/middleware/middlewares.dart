import 'package:shelf/shelf.dart';

abstract class Middlewares {
  late Handler innerhandler;
  Handler handler(Handler innerHandler) {
    innerhandler = innerHandler;
    return execute;
  }

  Future<Response> execute(Request request);
}
