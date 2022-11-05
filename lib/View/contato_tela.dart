import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_atividade2/Blocs/contact_bloc.dart';
import 'package:flutter_atividade2/Blocs/contact_event.dart';
import 'package:flutter_atividade2/Blocs/contact_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/contato.dart';
import 'contato_tile.dart';
import '../Dados/contactList.dart';

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
          return const Center(child: Text("Você não tem amigos"));
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
                        BlocProvider.of<ContactBloc>(context)
                      );
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

void pressedDefault() {
  return;
}

class NewContactScreen extends StatelessWidget {
  NewContactScreen(this.bloc,{Key? key})
      : super(key: key);
  final ContactBloc bloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Contato aux = Contato("", 1);
  //Esse widget me da vontade de chorar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("novo contato"),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                    minHeight: 80, minWidth: 300, maxWidth: 500),
                child: SizedBox(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Apelido',
                    ),
                    validator: (String? inValue) {
                      if (inValue != null) {
                        if (inValue.isEmpty) {
                          return "Insira um apelido";
                        }
                      }
                      return null;
                    },
                    onSaved: (String? inValue) {
                      aux.apelido = inValue ?? "";
                    },
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                    minHeight: 85, minWidth: 300, maxWidth: 500),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Número',
                  ),
                  validator: (String? inValue) {
                    if (inValue != null) {
                      if (inValue.isEmpty) {
                        return "Insira um número de contato";
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(inValue)) {
                        return "Insira Apenas números";
                      }
                    }
                    return null;
                  },
                  onSaved: (String? inValue) {
                    aux.numero = int.parse(inValue ?? "0");
                  },
                ),
              ),
              ElevatedButton(
                child: const Text("Salvar"),
                onPressed: ()async{
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.of(context).pop();
                    bloc.add(ContactAddEvent(aux));///////////////////////////////////////////////////////////////////////////
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
