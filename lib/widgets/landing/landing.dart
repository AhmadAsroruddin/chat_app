import 'package:chat_app/provider/provider.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Landing extends StatelessWidget {
  Landing(
      {super.key,
      required this.userImage,
      required this.name,
      required this.userIdTarget,
      required this.contact});

  String name;
  final String userImage;
  String userIdTarget;
  bool contact = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Provider.of<UserProvider>(context, listen: false)
            .addUserId(userIdTarget);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamed(ChatScreen.routeName, arguments: {'targetName' : name} );
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          backgroundImage: NetworkImage(userImage),
        ),
        title: Text(name),
        subtitle: contact
            ? null
            : const Text("Ini berisi pesan yang terakhir kali muncul"),
      ),
    );
  }
}
