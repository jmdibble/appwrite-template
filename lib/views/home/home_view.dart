import 'package:appwritetest/auth_handler.dart';
import 'package:appwritetest/theme/colors.dart';
import 'package:appwritetest/view_models/home/home_view_model.dart';
import 'package:appwritetest/widgets/aw_button.dart';
import 'package:appwritetest/widgets/aw_button_outline.dart';
import 'package:appwritetest/widgets/custom_bg.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (_, m, child) => Scaffold(
        extendBodyBehindAppBar: true,
        body: CustomBG(
          appBar: true,
          appBarTitle: "Welcome",
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  AWButton(
                    onPressed: () async {
                      await m.logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthHandler(),
                        ),
                      );
                    },
                    buttonText: "Log out",
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
