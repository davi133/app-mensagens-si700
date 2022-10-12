import 'package:flutter/material.dart';
import 'package:flutter_atividade2/Dados/global.dart';
import '../model/user.dart';
import '../model/Conversa.dart';
import '../Dados/chatList.dart';
import '../model/mensagem.dart';

void defaultFunction() {}

class ChatScreen extends StatefulWidget {
  const ChatScreen(this.other, {super.key, this.onNewMessage = defaultFunction});
  final User other;
  final Function onNewMessage;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void updateChatScreen() {
    widget.onNewMessage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Conversa? convNull = getChatByOthersNumber(widget.other.numero);
    Conversa conv = Conversa.conversaInvalida();
    if (convNull != null) {
      conv = convNull;
    }
    String nome = conv.outro.numero != -1?conv.outro.nome: widget.other.nome;

    return Scaffold(
      appBar: AppBar(title: Text(nome), elevation: 0,),
      body: Container(
        margin: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MessageList(conv),
            ChatBottom(conv, widget.other, onSend: updateChatScreen),
          ],
        ),
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  const MessageList(this.conv, {super.key});
  final Conversa conv;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: conv.mensagens.length,
        itemBuilder: (BuildContext context, int index) {
          return MessageTile(conv.mensagens[index]);
        },
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile(this.msg, {super.key});
  final Mensagem msg;
 
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: msg.from.numero == CURRENT_USER.numero
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color:
                  msg.from.numero == CURRENT_USER.numero ? Colors.blue : Colors.blue[100],
              borderRadius: const BorderRadius.all(Radius.circular(6))),
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.all(5.0),
          child: Text(msg.texto),
        ),
      ],
    );
  }
}

class ChatBottom extends StatefulWidget {
  const ChatBottom(
    this.conv,
    this.outro, {
    super.key,
    required this.onSend,
  });
  final Conversa conv;
  final Function onSend;
  final User outro;
  @override
  State<ChatBottom> createState() => _ChatBottomState();
}

class _ChatBottomState extends State<ChatBottom> {
  String message = "";
  final TextEditingController newMsgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: newMsgController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Escreva uma mensagem',
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) => {message = value},
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            height: 45,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              onPressed: () {
                //SENDING MESSAGE ======================================================================
                if (newMsgController.text.trim().isNotEmpty) {
                  //
                  Conversa convToUse = widget.conv;
                  //CHECANDO SE CONVERSA REALMENTE EXISTE ====================
                  Conversa? conversa =
                      getChatByOthersNumber(widget.outro.numero);
                  if (conversa == null) {
                    chatList.add(Conversa(CURRENT_USER, widget.outro));
                    Conversa? aux = getChatByOthersNumber(widget.outro.numero);
                    if (aux != null) {
                      convToUse = aux;
                    }
                  } //aqui já é garantido que existe uma conversa

                  User other = widget.conv.outro;
                  Mensagem msg =
                      Mensagem(other, CURRENT_USER, newMsgController.text);
                  convToUse.mensagens.add(msg);
                  widget.onSend();
                  newMsgController.text = "";
                }
              },
              child: const Icon(Icons.arrow_forward),
            ),
          )
        ],
      ),
    );
  }
}
