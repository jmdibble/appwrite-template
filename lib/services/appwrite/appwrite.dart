import 'package:appwrite/appwrite.dart';

class Appwrite {
  String baseUrl =
      "https://c9e6-2a00-23c6-6882-ac01-d586-e1aa-eb54-6903.ngrok.io";

  Client client = Client();

  Future<void> init() async {
    client.setEndpoint('$baseUrl/v1').setProject('618bcd73e87b4');
  }

  Account get account => Account(client);

  Database get database => Database(client);

  Realtime get realtime => Realtime(client);
}
