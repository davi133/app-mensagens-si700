import '../model/session_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationProvider {
  SessionUser _user = SessionUser(nome: "nome", email: "email", numero: -1);

  static AuthenticationProvider helper =
      AuthenticationProvider._createInstance();
  AuthenticationProvider._createInstance();

  SessionUser get loggedSessionUser {
    return _user;
  }

  Future<SessionUser> Login(
      {required String email, required String senha}) async {
    try {
      UserCredential a = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: senha);
      String name = "";
      User? user = a.user;
      if (user != null) {
        String? aaaavomemata = user.displayName;
        if (aaaavomemata != null) {
          name = aaaavomemata;
        }
      }

      _user = SessionUser(nome: name, email: email, numero: 1);
      print(_user);
      return _user;
    } on FirebaseAuthException catch (e) {
      print("erro firebase: ");
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print(e.message);
      }
    } catch (e) {
      print("erro geral ${e.toString()}");
    }

    _user = SessionUser(nome: "a", email: ".", numero: -1);
    print(_user);
    return _user;
  }

  Future<SessionUser> SignIn(
      {required String email,
      required String nome,
      required String senha}) async {
    try {
      UserCredential a =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      User? user = a.user;
      String uid = "";
      if (user != null) {
        user.updateDisplayName(nome);
        uid = user.uid;
      }

      var cloud = FirebaseFirestore.instance;

      int lastNumber = 1000;
      var lastNumberDoc = cloud.collection("numeros").doc("last");
      lastNumberDoc
        ..get().then(
          (DocumentSnapshot doc) {
            final data = doc.data() as Map<String, dynamic>;
            print("last number is ${data["lastNumber"]}===================================");
            lastNumber = data["lastNumber"];
          },
          onError: (e) => print("Error getting document: $e"),
        );
      
      cloud.collection("numeros").doc("last").set({"lastNumber": lastNumber+1});
      
      final association = <String, dynamic>{
        "uid": uid,
        "number": lastNumber + 1,
      };


      cloud.collection("users-numbers").add(association);


      _user =
          SessionUser(nome: nome, email: email, numero: association["number"]);
      print(_user);
      return _user;
      //CATCHES ===========================================================================================================================
    } on FirebaseAuthException catch (e) {
      print("erro firebase: ");
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print(e.message);
      }
    } catch (e) {
      print("erro geral ${e.toString()}");
    }

    _user = SessionUser(nome: "name", email: ".", numero: -1);
    print(_user);
    return _user;
  }

  Future<int> Logout() async {
    await FirebaseAuth.instance.signOut();
    _user = SessionUser(nome: ".", email: ". ", numero: -1);
    return 1;
  }
}
