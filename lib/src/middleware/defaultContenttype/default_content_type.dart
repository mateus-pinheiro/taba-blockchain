
import 'package:shelf/shelf.dart';
import 'package:taba_blockchain/src/middleware/middlewares.dart';

class DefaultContentType extends Middlewares {
  final String contentType;
  DefaultContentType(this.contentType);
  @override
  Future<Response> execute(Request request) async {
    final response = await innerhandler(request);
    return response.change(
      headers: {
        'content-type': contentType,
      },
    );
  }
}
