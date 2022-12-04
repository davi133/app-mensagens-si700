import 'package:bloc/bloc.dart';
import '../../Dados/auth_provider.dart';
import '../../model/session_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>
{
  SessionUser _user =SessionUser(nome: "nome", email: "email", numero: -1);

  AuthBloc(AuthState initialState) : super(initialState)
  {
    on<StartLoginEvent>((event, emit) {
      emit(OnLoginState());
    },);

    on<LoginEvent>((event, emit) async {
      print("tentando logar como ${event.email} e ${event.senha}");
      String message  = await AuthenticationProvider.helper.Login(email: event.email,senha: event.senha);
      print("message is $message");
      if (message=="")
      {
        emit(AuthenticatedState());
      }
      else
      {
        emit(OnLoginState(email: event.email,message: message));
      }
    });
    
    on<StartRegisterEvent>((event, emit) {
      emit(OnRegisterState());
    },);


    on<SignInEvent>((event, emit)async {
      print("tentando logar como ${event.nome} ${event.email} e ${event.senha}");
      String message = await AuthenticationProvider.helper.SignIn(email: event.email,nome: event.nome, senha: event.senha);
      print("message is $message");
      if (message=="")
      {
        emit(AuthenticatedState());
      }
      else
      {
        emit(OnRegisterState(email: event.email, nome: event.nome,message: message));
      }

    },);
    
    
    on<LogoutEvent>((event, emit) async {
      _user = SessionUser(nome: "...", email: "...", numero: -1);
      await AuthenticationProvider.helper.Logout();
      emit(OnLoginState());
    },);
  }
  
}