import 'package:flutter/material.dart';
import '../model/user.dart';

import '../model/mensagem.dart';


class ChatScreen extends StatelessWidget {
  ChatScreen(this.other, {super.key});
  User other = User("Felipe", 1002);

  @override
  Widget build(BuildContext context) {
    List<Mensagem> mensagens = [
      Mensagem(User("davi", 1001), User("Felipe", 1002), "olá"),
      Mensagem(User("Felipe", 1002), User("davi", 1001), "opaa"),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(other.nome)),
      body: Container(
        margin: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [MessageList(mensagens), const ChatBottom()],
        ),
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  MessageList(this.mensagens, {super.key});
  List<Mensagem> mensagens;
  final User me = User("davi", 1001);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: mensagens.length,
        itemBuilder: (BuildContext context, int index) {
          return MessageTile(mensagens[index]);
        },
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  MessageTile(this.msg, {super.key});
  final Mensagem msg;
  final User me = User("davi", 1001);//Isso precisa ser refatorado depois, 
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
