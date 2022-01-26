import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwritetest/models/aw_user.dart';
import 'package:appwritetest/services/appwrite/appwrite.dart';
import 'package:appwritetest/services/injector.dart';

class AuthService {
  final Appwrite _appwrite = getIt.get<Appwrite>();
  bool isSignedIn = false;
  AWUser? user;

  Future<bool?> createUser(String name, String email, String password) async {
    try {
      final User userResponse = await _appwrite.account.create(
        userId: "unique()",
        email: email,
        password: password,
        name: name,
      );
      print("USER CREATED: ${userResponse.email}");

      // Create session for user
      Session? session = await createSession(email, password);

      // Store user in DB
      if (session != null) {
        final Document? dbResponse =
            await addUserToDb(session.userId, name, email, password);
        if (dbResponse != null) {
          print("USER STORED: ${dbResponse.$id}");
          return true;
        }
      }
      return false;
    } on AppwriteException catch (e) {
      print(e);
      return Future.error(e);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Session?> createSession(String email, String password) async {
    try {
      final Session session = await _appwrite.account
          .createSession(email: email, password: password);

      print("SESSION ACTIVE: ${session.current} - ${session.$id}");

      return session;
    } on AppwriteException catch (e) {
      print(e);
      return Future.error(e);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Document?> addUserToDb(
      String uid, String name, String email, String password) async {
    try {
      final Document response = await _appwrite.database.createDocument(
        collectionId: "61dd74dec2e03",
        documentId: uid,
        read: ["role:all"],
        data: {
          "uid": uid,
          "email": email,
          "name": name,
        },
      );

      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<AWUser?> getUserFromDb(String uid) async {
    try {
      final response = await _appwrite.database
          .getDocument(collectionId: "61dd74dec2e03", documentId: uid);

      user = AWUser(
        response.data['uid'],
        response.data['name'],
        response.data['email'],
      );
      print("USER FROM DB: ${user!.uid}");
      return user;
    } on AppwriteException catch (e) {
      print(e);
      return Future.error(e);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Session?> getActiveSession() async {
    print("Getting active session...");
    try {
      final Session? response =
          await _appwrite.account.getSession(sessionId: 'current');

      if (response != null) {
        await getUserFromDb(response.userId);
        return response;
      }
    } on AppwriteException catch (e) {
      print(e);
      return Future.error(e);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> getSessions() async {
    SessionList sessions = await _appwrite.account.getSessions();

    print("SESSIONS: ${sessions.sum}");

    sessions.sessions.forEach((Session session) {
      print(session.current);
    });
  }

  Future<bool> deleteSession() async {
    try {
      final Session? response = await getActiveSession();

      if (response != null) {
        await _appwrite.account.deleteSession(sessionId: response.$id);
        isSignedIn = false;
        print("LOGGED OUT SESSION - ${response.$id}");
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> sendResetEmail(String email) async {
    try {
      Future result = _appwrite.account.createRecovery(
        email: email,
        url: 'https://example.com',
      );
    } on AppwriteException catch (e) {
      print(e);
      throw e;
    } catch (e) {
      print(e);
    }
  }
}
