import 'dart:convert';

import 'package:discord_assistant/tools/simsimi/model/response_simsimi_model.dart';
import 'package:discord_assistant/tools/simsimi/simsimi_interface.dart';
import 'package:http/http.dart' as http;

class Simsimi implements SimsimiInterface {
  @override
  final String api = 'https://api.simsimi.net/v2//?text=';

  @override
  final String lang = '&lc=pt';

  @override
  Future<MessageSimsimiModel> sendMsg(String msg) async {
    final http.Response response = await http.get(Uri.parse(api + msg + lang));
    return MessageSimsimiModel.fromJson(jsonDecode(response.body));
  }
}
