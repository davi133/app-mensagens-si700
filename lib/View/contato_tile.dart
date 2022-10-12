import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_atividade2/View/contato_tela.dart';
import '../model/user.dart';
import '../model/contato.dart';
import "../Dados/contactList.dart";
import 'Chat.dart';

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
      //BOTÃO DE CONVERSAR COM O CONTATO =============================================================
      child: ListTile(
        title: Text(cont.apelido),
        subtitle: Text("#${cont.numero}"),
        trailing: IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext ctx) {
              return ChatScreen(User(cont.apelido, cont.numero));
            }));
          },
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
        //BOTÃO DE EDITAR #######################################
        ListTile(
          leading: const Icon(
            Icons.edit,
            color: Colors.blue,
          ),
          title: const Text("Editar"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return EditContato(
                cont,
                onFinish: onChanged,
              );
            }));
          },
        ),
        //BOTÃO DE DELETAR ###################################
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

class EditContato extends StatelessWidget {
  EditContato(this.cont, {Key? key, this.onFinish = (pressedDefault)})
      : super(key: key);
  final Function onFinish;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Contato aux = Contato("", 1);
  Contato cont;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("novo contato"), elevation: 0,),
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
                    initialValue: cont.apelido,
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
                  initialValue: "${cont.numero}",
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    editContato(cont.numero, aux);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    onFinish();
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

void pressedDefault() {
  return;
}
