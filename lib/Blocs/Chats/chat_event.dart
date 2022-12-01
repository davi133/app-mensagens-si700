import 'package:UnitalkV0_2/model/Conversa.dart';
import 'package:UnitalkV0_2/model/mensagem.dart';

abstract class ChatEvent{}



class ChatSendMessageEvent extends ChatEvent
{
  Conversa conv;
  Mensagem msg;
  ChatSendMessageEvent(this.conv, this.msg);
}

class ChatRecieveMessageEvent extends ChatEvent
{
  
}