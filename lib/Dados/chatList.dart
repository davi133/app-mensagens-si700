import 'package:flutter_atividade2/Dados/contactList.dart';

import '../model/contato.dart';
import '../model/user.dart';
import '../model/mensagem.dart';
import '../model/Conversa.dart';
import 'global.dart';

var chatList = [
  Conversa(CURRENT_USER, User("Felipe", 1002), mensagens: [
    Mensagem(CURRENT_USER, User("Felipe", 1002), "ola"),
    Mensagem(User("Felipe", 1002),CURRENT_USER, "opa"),

  ]),
   Conversa(CURRENT_USER, User("Gabriel", 1005), mensagens: [
    Mensagem(CURRENT_USER, User("Gabriel", 1005), "seu pai ta solteiro?"),
  ])


];

void setConversa(Conversa conv)
{
  for(int i =0; i< chatList.length;i++)
  {
    if (conv.outro.numero == chatList[i].outro.numero)
    {
      chatList[i] = conv;
      return;
    }
  }
  chatList.add(conv);
}

Conversa? getByOthersNumber(int number)
{
  for(int i =0; i< chatList.length;i++)
  {
    if (number == chatList[i].outro.numero)
    {
      return chatList[i];
    }
  }
  return null;
}
