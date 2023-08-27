import 'package:nyxx/nyxx.dart';

abstract interface class BotInterface {
  late final INyxxWebsocket botSocket;

  void initialize();
  void run();
  void dispose();
  void chatDm(IMessageReceivedEvent event);
  void chatGeneral(IMessageReceivedEvent event);
}
