import 'package:chat_app/Pages/chat_page.dart';
import 'package:chat_app/Pages/loginPage.dart';
import 'package:chat_app/Pages/registerPage.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        loginPage.id: (context) =>  const loginPage(),
        Registerpage.id: (context) =>  const Registerpage(),
        ChatPage.id: (context) =>  ChatPage(),
      },
      initialRoute: 'LoginPage',
    );
  }
}

/*

mga3llouss@gmail.com



*/