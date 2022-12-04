
import '../model/mensagem.dart';

import 'user.dart';

class Conversa
{
  String id="-1";
  User User1;
  User User2;
  bool is_firebase_synced = true;
  List<Mensagem> mensagens = [];

  Conversa(this.User1, this.User2, {this.id="-1",this.mensagens =const []})
  {
    if(mensagens.isEmpty)
    {
      mensagens =[];
    }
  }
 



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
    txt += "$User1 with $User2 ";
    txt+="mensagens: \n";
    mensagens.forEach((element) {txt += element.toString();});
    txt +="\n";
    return txt;
  }

}