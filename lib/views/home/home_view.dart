import 'package:appwritetest/auth_handler.dart';
import 'package:appwritetest/theme/styles.dart';
import 'package:appwritetest/view_models/home/home_view_model.dart';
import 'package:appwritetest/widgets/aw_button.dart';
import 'package:appwritetest/widgets/custom_bg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          appBarTitle: DateFormat("EEEE, dd MMM").format(DateTime.now()),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "This is a title",
                  style: AWStyles.title,
                ),
                SizedBox(height: 16),
                Text(
                  "This is a sub-heading",
                  style: AWStyles.subHeading,
                ),
                SizedBox(height: 16),
                Text(
                    "This is your homepage, you can do whatever you like here..."),
                SizedBox(height: 64),
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
    );
  }
}
