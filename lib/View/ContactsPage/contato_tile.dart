import 'package:flutter/material.dart';
import '../../Blocs/Contact/contact_bloc.dart';
import '../../Blocs/Contact/contact_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/user.dart';
import '../../model/contato.dart';
//import "../../Dados/contactList.dart";
import '../ChatsPage/Chat.dart';

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
            builder: (ctx) {
              return BlocProvider.value(
                value: BlocProvider.of<ContactBloc>(context),
                child: ContactOptions(
                  cont,
                  onChanged: onChanged,
                ),
              );
            });
      },
      //BOTÃO DE CONVERSAR COM O CONTATO =============================================================
      child: ListTile(
        title: Text(cont.apelido),
        subtitle: Text("#${cont.numero}"),
        trailing: IconButton(
          onPressed: () async {
            print("procurando contato");
            var chat = await iniciarConversaCom(cont.numero);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext ctx) {
              if (chat != null) {
                return ChatWith(chat);
              } else {
                print("contato inexistente");
                return Scaffold(
                  appBar: AppBar(
                  title: const Text("usuárioo inexistente"),
                  
                ),
                body: const Center(child: Text("usuárioo inexistente")),);
              }
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
              return BlocProvider.value(
                value: BlocProvider.of<ContactBloc>(context),
                child: EditContato(
                  cont,
                  onFinish: onChanged,
                ),
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
                          Navigator.pop(context);
                          Navigator.pop(context);
                          BlocProvider.of<ContactBloc>(context)
                              .add(ContactDeleteEvent(cont));
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
                    aux.id = cont.id;
                    BlocProvider.of<ContactBloc>(context)
                        .add(ContactEditEvent(aux));
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
