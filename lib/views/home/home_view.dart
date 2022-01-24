import 'package:appwritetest/view_models/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (_, m, child) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              Text("Home page"),
              ElevatedButton(
                onPressed: () async {
                  await m.logout();
                },
                child: Text("Log out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
