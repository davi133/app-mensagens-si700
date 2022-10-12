import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/Conversa.dart';
import '../Dados/chatList.dart';
import '../model/mensagem.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen(this.other, {super.key});
  User other = User("Felipe", 1002);

  @override
  Widget build(BuildContext context) {
    Conversa? convNull = getChatByOthersNumber(other.numero);
    Conversa conv = Conversa.conversaInvalida();
    if (convNull != null) {
      conv = convNull;
    }

    return Scaffold(
      appBar: AppBar(title: Text(other.nome)),
      body: Container(
        margin: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [MessageList(conv), const ChatBottom()],
        ),
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  MessageList(this.conv, {super.key});
  Conversa conv;
  final User me = User("davi", 1001);

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
  MessageTile(this.msg, {super.key});
  final Mensagem msg;
  final User me = User("davi", 1001); //Isso precisa ser refatorado depois,
  //mas precisa de um jeito do tile saber
  //em qual lado da tela colocar a mensagem
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: msg.from.numero == me.numero
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color:
                  msg.from.numero == me.numero ? Colors.blue : Colors.blue[100],
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
  const ChatBottom({super.key});

  @override
  State<ChatBottom> createState() => _ChatBottomState();
}

class _ChatBottomState extends State<ChatBottom> {
  String message = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Escreva uma mensagem',
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) => {message = value},
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            height: 45,
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ))),
              onPressed: () {},
              child: const Icon(Icons.arrow_forward),
            ),
          )
        ],
      ),
    );
  }
}
