import 'package:flutter/material.dart';
import 'Home.dart';

class SigninView extends StatelessWidget {
  SigninView({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //TEXT FIELD ===========================================
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                    ),
                    validator: (String? inValue) {
                      if (inValue != null) {}
                      return null;
                    },
                    onSaved: (String? inValue) {},
                  ),
                  //TEXT FIELD ===========================================
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (String? inValue) {
                      if (inValue != null) {}
                      return null;
                    },
                    onSaved: (String? inValue) {},
                  ),
                  //TEXT FIELD ===========================================
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                    ),
                    validator: (String? inValue) {
                      if (inValue != null) {}
                      return null;
                    },
                    onSaved: (String? inValue) {},
                  ),
                  Container(
                    height: 30,
                  ),
                  //BOTÃO ===============================================
                  ElevatedButton(
                    child: const Text("Entrar"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return const Home();
                      }));
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
