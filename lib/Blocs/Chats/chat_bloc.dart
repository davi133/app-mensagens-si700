import 'package:UnitalkV0_2/Dados/chat_provider.dart';
import 'package:bloc/bloc.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState>
{
  ChatBloc(ChatState initialState) : super(initialState)
  {
    
    on<ChatSendMessageEvent>((event, emit) async{
      print('sending message on bloc');
      await ChatProvider.helper.sendMessage(event.conv,event.msg);
      print("sim, enviado");
      //emit(ChatLoadedState());
    },);
    
    on<ChatRecieveMessageEvent>((event, emit) {
      
    },);

    on<ChatRefreshEvent>((event, emit) {
      emit(ChatLoadedState());
    },);

     ChatProvider.helper.stream.listen((event) {
      if (event[0] == "received") {
        add(ChatRefreshEvent());
      }
    });
  }

}