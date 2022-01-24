import 'package:appwritetest/enums/auth_state.dart';
import 'package:appwritetest/services/auth/auth_service.dart';
import 'package:appwritetest/view_models/auth_handler/auth_handler_view_model.dart';
import 'package:appwritetest/views/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final AuthService authService = GetIt.I.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthHandlerViewModel>.reactive(
      viewModelBuilder: () => AuthHandlerViewModel(),
      builder: (_, m, child) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                await authService.getSessions();
              },
              icon: Icon(Icons.list),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Log in",
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
                  m.authState == AuthState.loading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            await m.login(
                              emailController.value.text,
                              pwController.value.text,
                            );
                          },
                          child: const Text("Log in"),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterView(),
                            ),
                          );
                        },
                        child: Text("Sign up instead"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
