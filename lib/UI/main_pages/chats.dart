part of "../../homescout_library.dart";

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    PropertiesViewModel viewModel = Provider.of<PropertiesViewModel>(context);

    List<Chat> chats = viewModel.chats;

    List<Widget> chatItems = [];

    for (var chat in chats) {
      Widget profilePic = roundedImage(
        context: context,
        imageUrl: chat.profilePicUrl!,
        width: 40,
        height: 40,
      );

      Widget chatItem = Material(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(radiusValue),
        child: ListTile(
          leading: chat.profilePicUrl != null ? profilePic : Icon(personIcon),
          title: Text(chat.chattingWith),
          subtitle: FadedText(chat.lastMessage, padding: 0),
          trailing: Text(chat.lastTimestamp),
          tileColor: context.tintedBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.all(
              Radius.circular(radiusValue),
            ),
          ),
          onTap: () async {
            await viewModel.fetchMessages(chat.chatId);
            navigate(path: chatPath, extra: ChattingWith(chattingWith: chat.chattingWith, profilePicUrl: chat.profilePicUrl));
          },
        ),
      );

      chatItems.add(chatItem);
    }

    Widget chatList = SpacedVerticalListView(listItems: chatItems);

    Widget body = chatItems.isEmpty
        ? Center(
            child: Text("Chats Will Appear Here", style: context.bodyMedium),
          )
        : chatList;

    return SafeArea(child: Scaffold(body: body));
  }
}
