import 'package:appwritetest/auth_handler.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appwrite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthHandler(),
    );
  }
}
