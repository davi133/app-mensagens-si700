import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_atividade2/View/contato_tela.dart';
import '../model/user.dart';
import '../model/contato.dart';
import "../Dados/contactList.dart";

class ContatoTile extends StatelessWidget {
  const ContatoTile(this.cont, {super.key, this.onChanged = (pressedDefault)});
  final Contato cont;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    //return Text(user.toString());

    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
            context: context,
            builder: (_) {
              return ContactOptions(
                cont,
                onChanged: onChanged,
              );
            });
      },
      child: ListTile(
        title: Text(cont.apelido),
        subtitle: Text("#${cont.numero}"),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.chat),
          color: Colors.blue,
        ),
      ),
    );
  }
}

class ContactOptions extends StatelessWidget {
  const ContactOptions(this.cont,
      {super.key, this.onChanged = (pressedDefault)});
  final Contato cont;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(
            Icons.edit,
            color: Colors.blue,
          ),
          title: const Text("Editar"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          title: const Text("Excluir"),
          //onTap: (){removeContato(cont);Navigator.pop(context);onChanged();},
          onTap: () {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text("Excluir contato?"),
                    actions: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text("Não")),
                      OutlinedButton(
                        onPressed: () {
                          removeContato(cont);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          onChanged();
                        },
                        child: const Text("Sim"),
                      ),
                    ],
                  );
                });
          },
        )
      ],
    );
  }
}

void pressedDefault() {
  return;
}
