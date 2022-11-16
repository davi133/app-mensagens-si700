import 'package:bloc/bloc.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState>
{
  ChatBloc(ChatState initialState) : super(initialState)
  {
    on<ChatFetchEvent>((event, emit) {
      
    },);
    
    on<ChatSendMessageEvent>((event, emit) {
      
    },);
    
    on<ChatRecieveMessageEvent>((event, emit) {
      
    },);
  }

}