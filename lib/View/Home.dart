import 'package:UnitalkV0_2/Blocs/Authentication/auth_bloc.dart';
import 'package:UnitalkV0_2/Blocs/Authentication/auth_event.dart';
import 'package:UnitalkV0_2/Blocs/Chats/chat_list_bloc.dart';
import 'package:UnitalkV0_2/Blocs/Chats/chat_list_event.dart';
import 'package:UnitalkV0_2/Blocs/Chats/chat_list_state.dart';
import 'package:UnitalkV0_2/Dados/auth_provider.dart';
import 'package:flutter/material.dart';
import '../Blocs/Contact/contact_bloc.dart';
import '../Blocs/Contact/contact_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ContactsPage/contato_tela.dart';

import "ChatsPage/conversa_tela.dart";



class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text("UniTalk"),
          bottom: const TabBar(tabs: [
            Tab(text: "Conversas"),
            Tab(text: "Contatos"),
          ]),
          actions: [
          
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem<int>(value: 0, child: Text("Informações")),
                const PopupMenuItem<int>(value: 1, child: Text("Sair")),
              ],
              onSelected: (value) {
                switch (value) {
                  case 0:
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text("Nome: ${AuthenticationProvider.helper.user.nome}"),
                          content: Text("Seu número é: #${AuthenticationProvider.helper.user.numero}", style: const TextStyle(fontSize: 16),),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Ok"))
                          ],
                        );
                      });
                    break;
                  case 1:
                    BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
                    break;
                }
              },
            )
          ],
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (ctx)=>ContactBloc(ContactFetchING())),
            BlocProvider(create: (ctx)=> ChatListBloc(ChatListFetchingState()))
          ],
          child: const TabBarView(children: [
            TelaConversas(),
            TelaContatos(),
          ]),
        ),
      ),
    );
  }
}
