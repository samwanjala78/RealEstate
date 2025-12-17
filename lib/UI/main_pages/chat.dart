part of "../../homescout_library.dart";

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    PropertiesViewModel viewModel = Provider.of<PropertiesViewModel>(context);

    var chattingWith = GoRouterState.of(context).extra as ChattingWith;

    List<Message> messages = viewModel.messages;

    List<Widget> messageBubbles = [];

    for (var message in messages) {
      Widget messageBubble = Align(
        alignment: message.sender == "Sam"
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: SizedBox(
          width: context.getMaxWidth / 2,
          child: customContainer(
            padding: EdgeInsetsGeometry.all(paddingValue),
            color: context.tintedBackgroundColor,
            borderRadius: radiusValue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    message.text,
                    style: context.bodyMedium,
                    softWrap: true,
                  ),
                ),
                FadedText(message.timestamp, style: context.bodySmall),
              ],
            ),
          ),
        ),
      );

      messageBubbles.add(messageBubble);
    }

    Widget messageList = SpacedVerticalListView(listItems: messageBubbles);

    Widget profilePic = roundedImage(
      context: context,
      imageUrl: chattingWith.profilePicUrl!,
      width: 40,
      height: 40,
    );

    return SafeArea(
      child: Scaffold(
        appBar: blurredAppBar(
          title: Row(
            spacing: spacingValue,
            children: [profilePic, Text(chattingWith.chattingWith)],
          ),
          context: context,
        ),
        body: messageList,
      ),
    );
  }
}
