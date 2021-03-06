import 'package:appwritetest/enums/auth_state.dart';
import 'package:appwritetest/enums/page_state.dart';
import 'package:appwritetest/services/auth/auth_service.dart';
import 'package:appwritetest/theme/colors.dart';
import 'package:appwritetest/view_models/auth_handler/auth_handler_view_model.dart';
import 'package:appwritetest/widgets/aw_button.dart';
import 'package:appwritetest/widgets/aw_text_field.dart';
import 'package:appwritetest/widgets/custom_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key, required this.m}) : super(key: key);
  AuthHandlerViewModel m;

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
                    "Log in",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 32),
                  AWTextField(
                    controller: m.emailController,
                    hintText: "Email",
                  ),
                  SizedBox(height: 16),
                  AWTextField(
                    controller: m.pwController,
                    hintText: "Password",
                    obscureText: true,
                  ),
                  SizedBox(height: 8),
                  if (m.authState == AuthState.failed)
                    Center(
                      child: Text(
                        m.authError,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Cols.softRed,
                        ),
                      ),
                    ),
                  SizedBox(height: 56),
                  m.authState == AuthState.loading
                      ? CircularProgressIndicator()
                      : AWButton(
                          onPressed: () async {
                            await m.login(
                              m.emailController.value.text,
                              m.pwController.value.text,
                            );
                          },
                          buttonText: "Log in",
                        ),
                  SizedBox(height: 6),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        m.goToPassword();
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          m.goToSignup();
                        },
                        child: Text(
                          "Sign up instead",
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
