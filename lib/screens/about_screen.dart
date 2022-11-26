import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});
  static const routeName = '/About';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Image.asset('assets/chat_logo.jpg'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Hello Welcome To Chat App",
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: const Center(
                      child: Text("We Are only running on Android OS")),
                ),
                Container(
                  width: MediaQuery.of(context).size.height * 0.2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Image.asset('assets/android.png'),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.height * 0.2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Image.asset('assets/chat.png'),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: const Center(
                      child: Text(
                    "So what are you waiting for, we provide you to connect with your friends",
                    textAlign: TextAlign.justify,
                  )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
