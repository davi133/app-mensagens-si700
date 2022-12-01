import 'package:UnitalkV0_2/model/mensagem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_provider.dart';
import '../model/Conversa.dart';
import '../model/user.dart';

class ChatProvider {
  List<Conversa> _conversas = [];

  static ChatProvider helper = ChatProvider._createInstance();
  ChatProvider._createInstance();

  List<Conversa> get Conversas
  {
    return _conversas;
  }
  //retrieve all chats
  Future<String> fetchChats() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    //var chatDocs = db.collection('Conversas').where('users',arrayContains: AuthenticationProvider.helper.user.numero);
    var chatDocs = db.collection('Conversas').where('users',arrayContains: AuthenticationProvider.helper.user.numero).get();

    await chatDocs.then((value) async {
      //iterando todos os chats
      _conversas = [];
      for (var chat in value.docs) {
        User? user1_aux = await AuthenticationProvider.getUserByNumber(
            chat.data()['users'][0]);
        User user1;

        User? user2_aux = await AuthenticationProvider.getUserByNumber(
            chat.data()['users'][1]);
        User user2;

        if (user1_aux != null && user2_aux != null) {
          user1 = user1_aux;
          //print("user1 $user1");
          user2 = user2_aux;
          //print("user1 $user2");
          Conversa conv = Conversa(user1_aux, user2);

          var msgs = chat.reference.collection("Mensagens").orderBy('envio', descending: true).limit(1);
          await msgs.get().then((value) {
            //iterando todas as mensagens
            for (var msg in value.docs) {
              User emissor;
              if (msg.data()['emissor'] == user1.numero) {
                emissor = user1;
              } else {
                emissor = user2;
              }
              Timestamp t = msg.data()['envio'] as Timestamp;
              DateTime date = t.toDate();
              var mensag = Mensagem(emissor, msg.data()['texto']);
              mensag.sent = date;
              conv.addMensagem(mensag);
            }
          },
          onError: (e)=>"$e");
          //print("adding to conversas");
          _conversas.add(conv);
        }
      }
    },onError:(e)=>"$e");

    //print("lenght is ${_conversas.length}");
    //print(_conversas);
    //print("fim das conversas");
    return "";
  }

  //iniciar chat

}
