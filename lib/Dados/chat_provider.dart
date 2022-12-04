import 'package:UnitalkV0_2/View/ChatsPage/Chat.dart';
import 'package:UnitalkV0_2/model/mensagem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_provider.dart';
import '../model/Conversa.dart';
import '../model/user.dart';
import '../model/mensagem.dart';
import 'dart:async';

class ChatProvider {
  List<Conversa> _conversas = [];

  //Conversa conversaAtual = Conversa.conversaInvalida();

  static ChatProvider helper = ChatProvider._createInstance();
  ChatProvider._createInstance() {
    //listenToRecivingMessages("");
  }

  List<Conversa> get Conversas {
    return _conversas;
  }

  void _addConversaToCached(Conversa conv) {
    for (int i = 0; i < _conversas.length; i++) {
      if (_conversas[i].id == conv.id) {
        _conversas[i] = conv;
        notify("received",1,conv.id);
        return;
      }
    }
    _conversas.add(conv);
    notify("newChat",1,conv.id);
  }
  
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? subs;
  List<StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?> subsChats = [];
  //bool waitingToPrint = false;
  Future<String> fetchChats() async {
    //print("====================testRealTime====================");
    FirebaseFirestore db = FirebaseFirestore.instance;
    String errorMessage = "";
    var chatDocs = db.collection('Conversas').where('users',arrayContains: AuthenticationProvider.helper.user.numero).snapshots();

    subs?.cancel();

    subs = chatDocs.listen((event) async {
      _conversas = [];
      //print("algo mudou nas conversas ++++++++++++++++++++++++++++++++++++++");
      //print(event.size);
      for (var sub in subsChats)
      {
      sub?.cancel();
      }
      for (var chat in event.docs) {
        
        User? u1null = await AuthenticationProvider.getUserByNumber(
            chat.data()['users'][0]);
        User? u2null = await AuthenticationProvider.getUserByNumber(
            chat.data()['users'][1]);

        if (u1null != null && u2null != null) {
          Conversa conv = Conversa(u1null, u2null, id: chat.id);
          int u1ID = chat.data()['users'][0];
          int u2ID = chat.data()['users'][1];

          var thisChat = chat.reference.collection("Mensagens").orderBy('envio', descending: false).snapshots();

          var esseChatSub = thisChat.listen((event) async
          {
            conv.mensagens = [];
            if (event.size > 0)
            {
              //print("mudança de mensagens --------------------");
              for (var msg in event.docs)
              {
                //if (dat != null && msg.type == DocumentChangeType.added)
                
                  User emissor;
                  if (msg.data()['emissor'] == u1ID)
                  {
                    emissor = conv.User1;
                  }
                  else
                  {
                    emissor = conv.User2;
                  }

                  Timestamp t = msg.data()['envio'] as Timestamp;
                  DateTime date = t.toDate();
                  var mensag = Mensagem(emissor,msg.data()['texto']);
                  mensag.sent = date;
                  conv.addMensagem(mensag);
                
                
              
              }
              
            }
            _addConversaToCached(conv);
            /*await Future.delayed(const Duration(seconds: 1));
            if (!waitingToPrint)
            {
              //print("lista de test depois de MENSAGEM é: ");
              //print(conv_test);
            }*/
           
          }
          ,onError:  (e){errorMessage="$e";});
          subsChats.add(esseChatSub);
          
        }
      }
      //print("fim da mudança");
      
      //waitingToPrint = true;
      //await Future.delayed(const Duration(seconds: 3));
      //waitingToPrint = false;
      //print("lista de test é: ");
      //print(conv_test);
    }, onError: (e){errorMessage="$e";});

    return errorMessage;
  }
 
  Future<String> sendMessage(Conversa conv, Mensagem msg) async {
    //print("sending message ${msg.texto} on chatProvider");
    //print(conv.id);

    if (conv.id == "-1") {
      await iniciarConversaNoDb(conv);
    }

    FirebaseFirestore db = FirebaseFirestore.instance;
    final association = <String, dynamic>{
      "emissor": msg.from.numero,
      "envio": Timestamp.fromDate(msg.sent),
      "texto": msg.texto
    };
    //print(association);
    await db
        .collection("Conversas")
        .doc(conv.id)
        .collection("Mensagens")
        .add(association)
        .then((value) {
      //print("enviado?");
    });

    //notify("", 1, conv.id);
    return "";
  }

  Future<void> iniciarConversaNoDb(Conversa conv) async {
    conv.id = "${conv.User1.numero}-${conv.User2.numero}";
    FirebaseFirestore db = FirebaseFirestore.instance;
    final association = <String, dynamic>{
      "users": [conv.User1.numero, conv.User2.numero]
    };
    db.collection("Conversas").doc(conv.id).set(association);
    _addConversaToCached(conv);
  }

  List<Conversa> conv_test = [];
  void _addConversaToTest(Conversa conv) {
    for (int i = 0; i < conv_test.length; i++) {
      if (conv_test[i].id == conv.id) {
        conv_test[i] = conv;
        //print("mensagem adicionada");
        return;
      }
    }
    //print("conversa adicionada");
    conv_test.add(conv);
    //notificar
  }

  

  //##########
  //notificando os dependentes
  //##########

  notify(String operation, int res, String chatId) async {
    //print("chat provider is notifyng");
    if (!_controller!.isClosed) _controller?.sink.add([operation, res, chatId]);
  }

  Stream get stream {
    _controller ??= StreamController.broadcast();
    return _controller!.stream;
  }

  dispose() {

    subs?.cancel();
    for (var sub in subsChats)
    {
      sub?.cancel();
    }
    if (_controller != null) {
      if (!_controller!.hasListener) {
        //print("closgin stream===============================================================================");
        _controller!.close();
        _controller = null;
      }
    }
  }

  static StreamController? _controller;
}
