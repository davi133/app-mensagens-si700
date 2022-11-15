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
    on<LoginEvent>((event, emit) async {
      //print("auth bloc login");
      _user = await AuthenticationProvider.helper.Login(email: event.email,senha: event.senha);
      print(_user.numero);
      if (_user.numero != -1)
      {
        emit(AuthenticatedState(sessionUser: _user));
      }
      
      
        
    });
    
    on<SignInEvent>((event, emit)async {
      print("bloc signin");
      _user = await AuthenticationProvider.helper.SignIn(email: event.email,nome: event.nome, senha: event.senha);
       if (_user.numero != -1)
      {
        emit(AuthenticatedState(sessionUser: _user));
      }
    },);
    
    /*on<LoginAnonymousEvent>((event, emit) {
      //emit(AuthenticatedState( sessionUser:  SessionUser(email: "anon@email.com",nome: "Anonimo",numero: -69)));
    },);*/
    
    on<LogoutEvent>((event, emit) {
      _user = SessionUser(nome: "...", email: "...", numero: -1);
      emit(UnauthenticatedState());
    },);
  }
  
}