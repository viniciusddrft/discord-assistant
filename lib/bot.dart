import 'package:discord_assistant/interface/bot_interface.dart';
import 'package:discord_assistant/tools/simsimi/model/response_simsimi_model.dart';
import 'package:discord_assistant/tools/tools.dart';
import 'package:nyxx/nyxx.dart';

import 'auth/auth.dart';

class Bot with AuthData, BotTools implements BotInterface {
  @override
  late final INyxxWebsocket botSocket;

  @override
  void initialize() {
    try {
      botSocket =
          NyxxFactory.createNyxxWebsocket(token, GatewayIntents.allUnprivileged)
            ..registerPlugin(Logging())
            ..connect();
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
    }
  }

  @override
  void run() {
    botSocket.eventsWs.onMessageReceived.listen(chatGeneral);
    botSocket.eventsWs.onDmReceived.listen(chatDm);
  }

  @override
  void chatGeneral(IMessageReceivedEvent event) async {
    for (Cacheable<Snowflake, IUser> element in event.message.mentions) {
      final IUser user = await element.getOrDownload();

      if (user.username == 'viniciusddrft') {
        event.message.channel.sendMessage(
          MessageBuilder.content("Eu irei avisar o vini sobre isso."),
        );
        (await user.dmChannel).sendMessage(event.message.toBuilder());
      }
    }
  }

  @override
  void chatDm(IMessageReceivedEvent event) async {
    if (event.message.content != lastMsg && !event.message.author.bot) {
      simsimi
          .sendMsg(event.message.content)
          .then((MessageSimsimiModel response) {
        lastMsg = event.message.content;
        if (response.success.contains('simsimi')) {
          event.message.channel.sendMessage(
            MessageBuilder.content(
              response.success
                  .replaceAll(RegExp('simsimi'), 'Assistente do vini'),
            ),
          );
        } else if (response.success.contains('Simsimi')) {
          event.message.channel.sendMessage(
            MessageBuilder.content(
              response.success
                  .replaceAll(RegExp('Simsimi'), 'Assistente do vini'),
            ),
          );
        } else {
          event.message.channel.sendMessage(
            MessageBuilder.content(response.success),
          );
        }
      });
    }
  }

  @override
  void dispose() => botSocket.dispose();
}
