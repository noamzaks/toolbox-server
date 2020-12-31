import 'dart:convert';
import 'dart:io';
import 'utilities.dart';

void main(List<String> arguments) async {
  final server = await HttpServer.bind('127.0.0.1', 1574);
  print('Running at ${server.address.address} on port ${server.port}');

  await for (final request in server) {
    try {
      final socket = await WebSocketTransformer.upgrade(request);
      socket.add(json.encode({'message': 'Hello World!'}));
      socket.listen((data) => handler(socket, data));
    } on WebSocketException {
      request.response.headers.contentType = ContentType.json;
      request.response
          .write({'error': 'Failed to upgrade connection to WebSocket'});
      await request.response.close();
    }
  }
}

void handler(WebSocket socket, dynamic data) {
  print(data);
  socket.add(json.encode({'message': 'received'}));
}
