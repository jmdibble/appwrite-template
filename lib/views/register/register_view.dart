import 'package:appwritetest/enums/auth_state.dart';
import 'package:appwritetest/services/auth/auth_service.dart';
import 'package:appwritetest/view_models/auth_handler/auth_handler_view_model.dart';
import 'package:appwritetest/widgets/aw_button.dart';
import 'package:appwritetest/widgets/aw_text_field.dart';
import 'package:appwritetest/widgets/custom_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key, required this.m}) : super(key: key);
  AuthHandlerViewModel m;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final AuthService authService = GetIt.I.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBG(
        appBar: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Sign up",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 32),
                  AWTextField(
                    controller: emailController,
                    hintText: "Email",
                  ),
                  SizedBox(height: 16),
                  AWTextField(
                    controller: pwController,
                    hintText: "Password",
                  ),
                  SizedBox(height: 64),
                  m.authState == AuthState.loading
                      ? CircularProgressIndicator()
                      : AWButton(
                          onPressed: () async {
                            await m.register(
                              emailController.value.text,
                              pwController.value.text,
                            );
                          },
                          buttonText: "Sign up",
                        ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          m.goToLogin();
                        },
                        child: Text(
                          "Log in instead",
                          style: TextStyle(color: Colors.white),
                        ),
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
