import 'package:appwrite/appwrite.dart';

class Appwrite {
  String baseUrl =
      "https://1087-2a00-23c6-6882-ac01-e4bf-b690-a21c-4eea.ngrok.io/v1";

  Client client = Client();

  Future<void> init() async {
    client
        .setEndpoint(
            'https://1087-2a00-23c6-6882-ac01-e4bf-b690-a21c-4eea.ngrok.io/v1')
        .setProject('618bcd73e87b4');
  }

  Account get account => Account(client);
  Database get database => Database(client);
}
