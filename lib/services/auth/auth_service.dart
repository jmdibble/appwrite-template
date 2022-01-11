import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwritetest/services/appwrite/appwrite.dart';
import 'package:get_it/get_it.dart';

class AuthService {
  final Appwrite _appwrite = GetIt.instance.get<Appwrite>();
  RealtimeSubscription? accountSub;

  Future<void> init() async {
    SessionList sessions = await _appwrite.account.getSessions();
    sessions.sessions.forEach((session) {
      if (session.current) {
        accountSub = _appwrite.realtime.subscribe(['account']);
      }
    });

    if (accountSub != null) {
      accountSub!.stream.listen((event) async {
        await handleSession(event);
      });
    }
  }

  Future<void> handleSession(RealtimeMessage event) async {
    if (event.event == "account.sessions.delete") {
      print("LOG OUT USER");
    }
  }

  Future<void> createUser(String email, String password) async {
    try {
      final User userResponse = await _appwrite.account.create(
        userId: "unique()",
        email: email,
        password: password,
      );
      print("USER CREATED: ${userResponse.email}");

      // Create session for user
      Session session = await createSessionAndSubscription(email, password);

      // Store user in DB
      final dbResponse = await addUserToDb(session.userId, email, password);
      print("USER STORED: ${dbResponse.$id}");
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Session> createSessionAndSubscription(
      String email, String password) async {
    try {
      final Session session = await _appwrite.account
          .createSession(email: email, password: password);
      print("SESSION ACTIVE: ${session.current} - ${session.$id}");

      return session;
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
        data: {
          "uid": uid,
          "email": email,
        },
      );

      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> getSessions() async {
    SessionList sessions = await _appwrite.account.getSessions();

    print("SESSIONS: ${sessions.sum}");

    sessions.sessions.forEach((Session session) {
      print(session.current);
    });
  }

  Future<void> deleteSession(String sessionId) async {
    final response =
        await _appwrite.account.deleteSession(sessionId: sessionId);
  }
}
