import 'dart:io';
import 'dart:convert';

extension Body on HttpRequest {
  Future<dynamic> get body async {
    return json.decode(await cast<List<int>>().transform(utf8.decoder).join());
  }
}
