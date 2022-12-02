import 'package:UnitalkV0_2/Blocs/Chats/chat_bloc.dart';
import 'package:UnitalkV0_2/Blocs/Chats/chat_event.dart';
import 'package:UnitalkV0_2/Blocs/Chats/chat_state.dart';
import 'package:UnitalkV0_2/Dados/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Dados/contactList.dart';
import '../../model/contato.dart';
import '../../model/user.dart';
import '../../model/Conversa.dart';

import '../../model/mensagem.dart';

class ChatWith extends StatelessWidget {
  const ChatWith(this.conversa, {super.key});
  final Conversa conversa;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(ChatLoadedState()),
      child: ChatScreen(conversa),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen(this.conversa, {super.key});
  final Conversa conversa;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void updateChatScreen() {
    //widget.onNewMessage();
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Conversa conv = widget.conversa;
    print("conversa é");
    print(conv);
    User me;
    User other;
    int me_num = AuthenticationProvider.helper.user.numero;
    if (conv.User1.numero == me_num) {
      me = conv.User1;
      other = conv.User2;
    } else {
      other = conv.User1;
      me = conv.User2;
    }

    String nome = other.nome;

    return Scaffold(
      appBar: AppBar(
        title: Text(nome),
        elevation: 0,
        actions: [
          //IconButton(onPressed: (){Navigator.of(context).pop();}, icon:const Icon(Icons.more_vert))
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                  value: 0, child: Text("Adicionar contato")),
            ],
            onSelected: (value) {
              switch (value) {
                case 0:
                  Contato novo = Contato(other.nome, other.numero);
                  ContactDataProvider.helper.addContato(novo);
                  showDialog(
                      context: context,
                      builder: (_) {
                        return SimpleDialog(
                          title: const Text("Contato adicionado"),
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Ok"))
                          ],
                        );
                      });

                  break;
              }
            },
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(12.0),
        child: BlocBuilder<ChatBloc, ChatState>(
          bloc: BlocProvider.of<ChatBloc>(context),
          builder: (context, state) {
            if (state is ChatErrorState) {
              return const Center(child: Text("Algo deu errado"));
            } else if (state is ChatLoadedState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MessageList(conv),
                  ChatBottom(conv),
                ],
              );
            } else {
              return const Center(child: Text("erro inesperado"));
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class MessageList extends StatelessWidget {
  MessageList(this.conv, {super.key});
  final Conversa conv;
  @override
  Widget build(BuildContext context) {
    var msgs = conv.mensagens.reversed.toList();
    //esse é o jeito mais preguiçoso de fazer a lista de mensagens ser inicializada em baixo
    //por outro ladd, ele tambem faz a lista ficar do tamanho certo quando vc abre o teclado
    var lista = ListView.builder(
      reverse: true,
      itemCount: msgs.length,
      itemBuilder: (BuildContext context, int index) {
        return MessageTile(msgs[index]);
      },
    );
    return Expanded(child: lista);
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile(this.msg, {super.key});
  final Mensagem msg;

  @override
  Widget build(BuildContext context) {
    bool is_it_me =
        msg.from.numero == AuthenticationProvider.helper.user.numero;
    return Row(
      mainAxisAlignment:
          is_it_me ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: is_it_me ? Colors.blue : Colors.blue[100],
              borderRadius: const BorderRadius.all(Radius.circular(6))),
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.all(10.0),
          child: Text(
            msg.texto,
            style: TextStyle(color: is_it_me ? Colors.white : Colors.black),
          ),
        ),
      ],
    );
  }
}

class ChatBottom extends StatefulWidget {
  const ChatBottom(
    this.conv, {
    super.key,
  });
  final Conversa conv;

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
                  User me = User(AuthenticationProvider.helper.user.nome,
                      AuthenticationProvider.helper.user.numero);

                  Mensagem msg = Mensagem(me, newMsgController.text.trim());
                  msg.sent = DateTime.now();
                  newMsgController.text = "";
                  BlocProvider.of<ChatBloc>(context)
                      .add(ChatSendMessageEvent(widget.conv, msg));
                  widget.conv.addMensagem(msg);
                  FocusManager.instance.primaryFocus?.unfocus();
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
