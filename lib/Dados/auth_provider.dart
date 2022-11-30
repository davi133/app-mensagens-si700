import '../model/session_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart' as Model;
class AuthenticationProvider {
  SessionUser _user = SessionUser(nome: "nome", email: "email", numero: -1);

  static AuthenticationProvider helper =
      AuthenticationProvider._createInstance();
  AuthenticationProvider._createInstance();

  SessionUser get loggedSessionUser {
    return _user;
  }

  SessionUser get user
  {
    return _user;
  }

  Future<SessionUser> Login({required String email, required String senha}) async {
    try {
      UserCredential a = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: senha);

      String name = "";
      String uid="";
      User? user = a.user;
      if (user != null) {
        uid = user.uid;
        String? aux = user.displayName;
        if (aux != null) {
          name = aux;
        }
      }
      
      var db = FirebaseFirestore.instance;
      int number =-1;
      var lastNumberDoc = db.collection("users-numbers").doc(uid);
      print("got doc ${lastNumberDoc.id}");

      await lastNumberDoc
        .get().then(
          (DocumentSnapshot doc) {
            
            final data = doc.data() as Map<String, dynamic>;
            
            number = data["number"];
          },
          onError: (e) => print("Error getting document: $e"),
        );
        print("got number");

      _user = SessionUser(nome: name, email: email, numero: number);
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

  Future<SessionUser> SignIn({required String email,required String nome,required String senha}) async {
    try {

      //creating user with firebase auth
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

      //using cloud firestore to give a Number to the user
      var cloud = FirebaseFirestore.instance;

      //first we get the number of the last account added
      int lastNumber = 0;
      var lastNumberDoc = cloud.collection("numeros").doc("last");
      await lastNumberDoc
        .get().then(
          (DocumentSnapshot doc) {
            
            final data = doc.data() as Map<String, dynamic>;
           
            lastNumber = data["lastNumber"];
          },
          onError: (e) => print("Error getting document: $e"),
        );
      
      //then we update the number os last added account in the database
      cloud.collection("numeros").doc("last").set({"lastNumber": lastNumber+1});
      
      //then we create the association user-number
      final association = <String, dynamic>{
        "uid": uid,
        "number": lastNumber + 1,
        "nome":nome
      };
      cloud.collection("users-numbers").doc(uid).set(association);


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


  Future<int> _getNumberByUID(String uid) async
  {
      return 0;
  }

  static Future<Model.User?> getUserByNumber(int number) async
  {
      FirebaseFirestore db = FirebaseFirestore.instance;
    //var chatDocs = db.collection('Conversas').where('users',arrayContains: AuthenticationProvider.helper.user.numero);
    var usersNumbers = db.collection('users-numbers').where('number',isEqualTo: number).get();
    Model.User user = Model.User("-1", -1);
    await usersNumbers.then((value) {
      var dat = value.docs[0].data();
      //print('auth data is ${value.docs[0].data()}');
      user = Model.User.fromMap(dat);
      //print(user);
    });

    return user;
    
  }
}
