import 'model/response_simsimi_model.dart';

abstract interface class SimsimiInterface {
  final String api, lang;

  const SimsimiInterface(this.api, this.lang);

  Future<MessageSimsimiModel> sendMsg(String msg);
}
