import 'package:flutter/material.dart';
import 'package:volunteer_app/pages/book_session_page.dart';
import 'package:volunteer_app/pages/find_tutor_page.dart';
import 'package:volunteer_app/pages/home_page.dart';
import 'package:volunteer_app/pages/resources_page.dart';
import 'package:volunteer_app/pages/sessions_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/3',
      routes: {
        '/': (context) => HomePage(),
        '/1': (context) => ResourcesPage(),
        '/2': (context) => SessionsPage(),
        '/3': (context) => FindTutorPage(),
        '/book_session': (context) => BookSessionPage(),
      },
    );
  }
}
