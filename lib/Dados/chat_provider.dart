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

  void _addConversaToCached(Conversa conv)
  {
    for( int i =0; i< _conversas.length; i++)
    {
      if (_conversas[i].id == conv.id)
      {
        //_conversas[i].mensagens = [];
        //_conversas[i].mensagens = conv.mensagens;
        //print("conversa atualizada pelo _handler");
        //print("conversa velha ${_conversas[i]}");
        //print("conversa nova ${conv}");
        return;
      }
    }
    
    _conversas.add(conv);
    print("conversa adicionada pelo _handler");
    //print(conv);
  }

  //retrieve all chats
  Future<String> fetchChats() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String errorMessage = "";
    var chatDocs = db
        .collection('Conversas')
        .where('users',
            arrayContains: AuthenticationProvider.helper.user.numero)
        .snapshots(includeMetadataChanges: false);

    chatDocs.listen((value) async {
      //iterando todos os chats
      //print("starting to listen for all chats");
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
          //print("user2 $user2");
          Conversa conv = Conversa(user1_aux, user2, id: chat.id);
          var msgs = chat.reference
              .collection("Mensagens")
              .orderBy('envio', descending: false)
              .snapshots(includeMetadataChanges: false);

          msgs.listen((value) {
            //iterando todas as mensagens
            //print("starting to listen for mensagens");
            print("==================================================\nconversa anntes era is: $conv");
            value.docChanges[0].doc.data();
            value.docs[0].data();
            for (var msg in value.docChanges) {
              var dat = msg.doc.data();
              if (msg.type == DocumentChangeType.added && dat!=null)
              {
                User emissor;
              if (dat['emissor'] == user1.numero) {
                emissor = user1;
              } else {
                emissor = user2;
              }
              
              Timestamp t = dat['envio'] as Timestamp;
              //print("enviod é: ${msg.data()['envio']}");
              DateTime date = t.toDate();
              var mensag = Mensagem(emissor, dat['texto']);
              mensag.sent = date;
              conv.addMensagem(mensag);
              print("adding message: $mensag to ${conv.id}");
              }
              
            }
            _addConversaToCached(conv);
            print("==================================================\nfinal conversa is: $conv");
            
            
            
            notify("fetch", 1, "");
          }, onError: (e) {
            errorMessage = "$e";
          });
          //print("adding to conversas");

        }
      }
    }, onError: (e) {
      errorMessage = "$e";
    });

    return errorMessage;
  }

  Future<String> sendMessage(Conversa conv, Mensagem msg) async {
    print("sending message ${msg.texto} on chatProvider");
    print(conv.id);
    FirebaseFirestore db = FirebaseFirestore.instance;
    final association = <String, dynamic>{
      "emissor": msg.from.numero,
      "envio": Timestamp.fromDate(msg.sent),
      "texto": msg.texto
    };
    print(association);
    db
        .collection("Conversas")
        .doc(conv.id)
        .collection("Mensagens")
        .add(association)
        .then((value) {
      print("enviado?");
    }); 

    notify("send", 1, conv.id);
    return "";
  }

 

  //##########
  //notificando os dependentes
  //##########

  notify(String operation, int res, String chatId) async {
    print("chat provider is notifyng");
    if (!_controller!.isClosed) _controller?.sink.add([operation, res, chatId]);
  }

  Stream get stream {
    _controller ??= StreamController.broadcast();
    return _controller!.stream;
  }

  dispose() {
    if (_controller != null) {
      if (!_controller!.hasListener) {
        print(
            "closgin stream===============================================================================");
        _controller!.close();
        _controller = null;
      }
    }
  }

  static StreamController? _controller;
}
