import 'package:flutter_atividade2/model/mensagem.dart';

import 'contato.dart';
import 'user.dart';

class Conversa
{
  User owner;
  User outro;
  List<Mensagem> mensagens = [];

  Conversa(this.owner, this.outro, {this.mensagens =const []});
 

  void addMensagem(Mensagem toAdd)
  {
    mensagens.add(toAdd);
  }

  Mensagem getMsgByIndex(int index)
  {
    return mensagens[index];
  }

  static Conversa conversaInvalida()
  {
    return Conversa(User("null",-1), User("null",-1));
  }

  String toString()
  {
    //print("to string:============================================= ");
    //print(mensagens);
    String txt ="";
    txt += "$owner with $outro";
    txt+="mensagens: \n";
    mensagens.forEach((element) {txt += element.toString();});
    return txt;
  }

}