import 'dart:io';
import 'utilities.dart';

void main(List<String> arguments) async {
  final server = await HttpServer.bind('127.0.0.1', 1574);
  print('Running at ${server.address.address} on port ${server.port}');

  await for (final request in server) {
    final body = await request.body;
    request.response.headers.contentType =
        ContentType('application', 'json', charset: 'utf-8');
    request.response.write({'message': 'Hello ${body['user']}!'});
    await request.response.close();
  }
}
