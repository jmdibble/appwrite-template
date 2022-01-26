import 'package:appwritetest/enums/auth_state.dart';
import 'package:appwritetest/services/auth/auth_service.dart';
import 'package:appwritetest/theme/colors.dart';
import 'package:appwritetest/view_models/auth_handler/auth_handler_view_model.dart';
import 'package:appwritetest/widgets/aw_button.dart';
import 'package:appwritetest/widgets/aw_text_field.dart';
import 'package:appwritetest/widgets/custom_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({Key? key, required this.m}) : super(key: key);
  AuthHandlerViewModel m;

  final AuthService authService = GetIt.I.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBG(
        appBar: true,
        appBarTitle: Text("Send password reset email"),
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 32,
          ),
          onPressed: () {
            m.goToLogin();
          },
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  AWTextField(
                    controller: m.emailController,
                    hintText: "Email",
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
                          onPressed: () async {},
                          buttonText: "Send reset email",
                        ),
                  SizedBox(height: 24),
                  // TextButton(
                  //   onPressed: () {
                  //
                  //   },
                  //   child: Text(
                  //     "Back to login",
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
