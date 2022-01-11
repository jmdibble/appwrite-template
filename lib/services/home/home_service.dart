import 'dart:convert';

import 'package:appwrite/models.dart';
import 'package:appwritetest/services/appwrite/appwrite.dart';
import 'package:get_it/get_it.dart';

class HomeService {
  final Appwrite _appwrite = GetIt.instance.get<Appwrite>();

  Future<void> createUser(String email, String password) async {
    try {
      // final User userResponse = await _appwrite.account.create(
      //   userId: "unique()",
      //   email: email,
      //   password: password,
      // );
      // print("USER CREATED: ${userResponse.email}");

      // String userId = userResponse.$id;

      // Create session for user
      final Session session = await _appwrite.account
          .createSession(email: "j@1.com", password: "123123123");
      print("SESSION ACTIVE: ${session.current}");

      // Store user in DB
      final dbResponse = await addUserToDb(session.userId, email, password);
      print("USER STORED: ${dbResponse.$id}");
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Document> addUserToDb(
      String uid, String email, String password) async {
    try {
      final Document response = await _appwrite.database.createDocument(
        collectionId: "61dd74dec2e03",
        documentId: uid,
        read: ["role:all"],
        data: {'username': 'hello2'},
      );

      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
