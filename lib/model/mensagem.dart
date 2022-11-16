
import 'user.dart';

class Mensagem {
  String texto ="";
  User from =User("Jhon",0); 
  
  DateTime sent = DateTime.now();


  Mensagem(this.from, this.texto);

  

  @override
  String toString()
  {
    String txt = "From: $from\n";
    txt       += "Sent: $sent\n";
    txt       += "$texto \n";

    return txt;
   
  }

  


}
