import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  _LoginStore(){
    autorun((_){
      print(email);
    });
  }
  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  bool passwordVisible = false;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @action
  void togglePasswordVisibility() => passwordVisible = !passwordVisible;

  @action
  void setPassword(value) => password = value;

  @action
  void setEmail(value) => email = value;

  @action
  Future<void> login() async{
    loading = true;

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    loggedIn = true;
  }

  @action
  void logout(){
    loggedIn = false;
    email = "";
    password = "";
  }
  @computed
  bool get isEmailValid => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

  @computed
  bool get isPasswordValid => password.length >= 6;

  @computed
  Function get loginPressed => (isEmailValid && isPasswordValid && !loading) ? login : null;
}