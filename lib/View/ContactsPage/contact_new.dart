

import 'package:flutter/material.dart';
import '../../Blocs/contact_bloc.dart';
import '../../Blocs/contact_event.dart';
import '../../model/contato.dart';



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
        child: Center(
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
      ),
    );
  }
}
