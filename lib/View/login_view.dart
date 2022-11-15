import 'package:flutter/material.dart';
import 'signin_view.dart';
import 'Home.dart';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entrar"),
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
                    keyboardType: TextInputType.text,
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
                    keyboardType: TextInputType.text,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: const Text("Entrar"),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                          }
                          DatabaseReference _testRef = FirebaseDatabase.instance.ref().child("teste");
                          _testRef.set("Log in ${Random().nextInt(100)}");


                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return const Home();
                          }));
                        },
                      ),
                      Container(
                        width: 20,
                      ),
                      ElevatedButton(
                          child: const Text("Cadastrar"),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return SigninView();
                            }));
                          }),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
