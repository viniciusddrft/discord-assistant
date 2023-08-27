import 'dart:io';

mixin AuthData {
  final String token =
      File('/home/viniciusddrft/estudo/dart/discord_assistant/discord.key')
          .readAsLinesSync()
          .first;
}
