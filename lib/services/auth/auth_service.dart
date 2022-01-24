import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwritetest/services/appwrite/appwrite.dart';
import 'package:appwritetest/services/injector.dart';

class AuthService {
  final Appwrite _appwrite = getIt.get<Appwrite>();
  bool isSignedIn = false;

  Future<bool> createUser(String email, String password) async {
    try {
      final User userResponse = await _appwrite.account.create(
        userId: "unique()",
        email: email,
        password: password,
      );
      print("USER CREATED: ${userResponse.email}");

      // Create session for user
      Session? session = await createSession(email, password);

      // Store user in DB
      if (session != null) {
        final Document? dbResponse =
            await addUserToDb(session.userId, email, password);
        if (dbResponse != null) {
          print("USER STORED: ${dbResponse.$id}");
          return true;
        }
      }
      return false;
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
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Document?> addUserToDb(
      String uid, String email, String password) async {
    try {
      final Document response = await _appwrite.database.createDocument(
        collectionId: "61dd74dec2e03",
        documentId: uid,
        read: ["role:all"],
        data: {
          "uid": uid,
          "email": email,
        },
      );

      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Session?> getActiveSession() async {
    try {
      final Session? response =
          await _appwrite.account.getSession(sessionId: 'current');

      if (response != null) {
        return response;
      }
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
}
