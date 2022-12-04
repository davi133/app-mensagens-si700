import '../../model/session_user.dart';

abstract class AuthState{}



class OnLoginState extends AuthState
{
  String message;
  String email;

  OnLoginState({this.message="",this.email=""});
}

class OnRegisterState extends AuthState
{
  String message;
  String nome;
  String email;


  OnRegisterState({this.message="",this.nome="",this.email=""});
}

class AuthenticatedState extends AuthState
{
 
}

