import 'package:chat_app/provider/provider.dart';
import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import './screens/chat_screen.dart';
import './screens/contact_list.dart';
import './screens/tab_screen.dart';
import './screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: UserProvider())],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: const Color.fromRGBO(51, 200, 245, 1),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  primary: Colors.blueGrey),
            ),
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.idTokenChanges(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return TabScreen();
              }
              return AuthScreen();
            }),
          ),
          routes: {
            ChatScreen.routeName: (context) => ChatScreen(),
            ContactList.routeName: (context) => const ContactList(),
            Profile.routeName: (context) => const Profile(),
          },
        ),
      ),
    );
  }
}
