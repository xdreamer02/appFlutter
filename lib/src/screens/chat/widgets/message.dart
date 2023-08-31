import 'package:flutter/material.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/src/models/chat_message_model.dart';
import 'package:planck/src/models/chat_model.dart';
import 'package:planck/src/provider/preferences_provider.dart';
import 'package:planck/src/screens/chat/widgets/text_message.dart';
import 'package:planck/src/widgets/avatar_image.dart';

class Message extends StatelessWidget {
  Message({
    Key? key,
    required this.chatModel,
    required this.message,
  }) : super(key: key);

  final ChatMessageModel message;
  final ChatModel chatModel;
  final prefs = PreferencesProvider();

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessageModel message) {
      switch (message.type) {
        case 1:
          return TextMessage(message: message);
        default:
          return const SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        mainAxisAlignment: message.isSender(prefs.user.id)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!message.isSender(prefs.user.id)) ...[
            SizedBox(
              width: 30,
              child:
                  ClipOval(child: AvatarImage(image: chatModel.toUser.image)),
            ),
            const SizedBox(width: kDefaultPadding / 2),
          ],
          messageContaint(message),
        ],
      ),
    );
  }
}
