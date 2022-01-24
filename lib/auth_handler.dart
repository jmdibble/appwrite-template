import 'package:appwritetest/enums/auth_state.dart';
import 'package:appwritetest/view_models/auth_handler/auth_handler_view_model.dart';
import 'package:appwritetest/views/home/home_view.dart';
import 'package:appwritetest/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AuthHandler extends StatelessWidget {
  const AuthHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthHandlerViewModel>.reactive(
        viewModelBuilder: () => AuthHandlerViewModel(),
        onModelReady: (m) async => await m.setSignedIn(),
        builder: (_, m, child) {
          print(m.isSignedIn);
          if (m.authState == AuthState.initial) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return m.isSignedIn ? HomeView() : LoginView();
          }
        });
  }
}
