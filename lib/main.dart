import 'package:appwritetest/app.dart';
import 'package:appwritetest/services/injector.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupInjector();

  runApp(App());
}
