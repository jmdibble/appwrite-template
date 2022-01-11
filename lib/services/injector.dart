import 'package:appwritetest/services/appwrite/appwrite.dart';
import 'package:appwritetest/services/home/home_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupInjector() async {
  // Appwrite
  getIt.registerSingleton<Appwrite>(Appwrite());
  Appwrite appwriteService = getIt.get<Appwrite>();
  await appwriteService.init();

  // Home
  getIt.registerSingleton<HomeService>(HomeService());
}
