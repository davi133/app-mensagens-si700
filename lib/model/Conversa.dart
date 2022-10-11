import 'package:flutter_atividade2/model/mensagem.dart';

import 'contato.dart';
import 'user.dart';

class Conversa
{
  User owner;
  User outro;
  List<Mensagem> msgs = [];

  Conversa(this.owner, this.outro, {List<Mensagem> mensagens =const []});

  void addMensagem(Mensagem toAdd)
  {
    msgs.add(toAdd);
  }

  Mensagem getMsgByIndex(int index)
  {
    return msgs[index];
  }



}