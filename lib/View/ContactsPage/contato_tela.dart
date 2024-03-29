import 'dart:math';

import 'package:flutter/material.dart';
import '../../Blocs/Contact/contact_bloc.dart';
import '../../Blocs/Contact/contact_event.dart';
import '../../Blocs/Contact/contact_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/contato.dart';
import 'contato_tile.dart';
import '../../Dados/contactList.dart';
import 'contact_new.dart';

class TelaContatos extends StatelessWidget {
  const TelaContatos({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactState>(
      bloc: BlocProvider.of<ContactBloc>(context),
      builder: ((context, state) {
        if (state is ContactFetchING) {
          ContactBloc cb = BlocProvider.of<ContactBloc>(context);
          cb.add(ContactFetchEvent());
          return const Center(child: CircularProgressIndicator());
        } else if (state is ContactLoaded) {
          return ListaContatos(contatos: state.lista_de_contatos);
        } else {
          return const EmptyList();
        }
      }),
    );
  }
}

class ListaContatos extends StatefulWidget {
  const ListaContatos({super.key, this.contatos = const []});
  final List<Contato> contatos;
  @override
  State<ListaContatos> createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  @override
  Widget build(BuildContext context) {
    //List<Contato> contatos = contactList;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.contatos.length,
              itemBuilder: (BuildContext context, int index) {
                return ContatoTile(
                  widget.contatos.elementAt(index),
                  onChanged: () {
                    setState(() {});
                  },
                );
              },
            ),
          ),

          ///FROM HERE AND BELOW IS FOR THE FLOATING BUTTON ####################################
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return NewContactScreen(
                          BlocProvider.of<ContactBloc>(context));
                    }));
                  },
                  tooltip: 'Novo contato',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const Text("Você não tem contatos"),
        Container(
          height: 20,
        ),
        ElevatedButton(
          child: const Text("Adicionar"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return NewContactScreen(BlocProvider.of<ContactBloc>(context));
            }));
          },
        ),
      ]),
    );
  }
}
