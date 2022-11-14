


import '../model/user.dart';
import '../model/mensagem.dart';
import '../model/Conversa.dart';
import 'global.dart';

var chatList = [
  Conversa(CURRENT_USER, User("Felipe Araujo Santos Pinto", 169401), mensagens: [
    Mensagem(CURRENT_USER, User("Felipe",  169401), "ola"),
    Mensagem(User("Felipe", 169401),CURRENT_USER, "opaa"),

  ]),
   Conversa(CURRENT_USER, User("Ulisses", 1010), mensagens: [
    Mensagem(User("Ulisses", 1010),CURRENT_USER, "Você é um professor muito legal"),
    Mensagem(CURRENT_USER, User("Ulisses", 1010),"👍"),
  ]),
  Conversa(CURRENT_USER, User("Fischer", 1005), mensagens: [
    Mensagem(CURRENT_USER, User("Robson", 1005), "E domingo meu bacano"),
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

Conversa? getChatByOthersNumber(int number)
{
  for(int i =0; i< chatList.length;i++)
  {
    if (number == chatList[i].outro.numero)
    {
      return chatList[i];
    }
  }
  return null;
  //return Conversa(User("null",-1), User("null",-1));
}
