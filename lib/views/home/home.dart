import 'package:appwritetest/services/home/home_service.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final HomeService homeService = HomeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Create a new user",
                  style: TextStyle(fontSize: 24),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: "Email"),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: pwController,
                  decoration: const InputDecoration(hintText: "Password"),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    await homeService.createUser(
                      emailController.value.text,
                      pwController.value.text,
                    );
                  },
                  child: const Text("Create User"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
