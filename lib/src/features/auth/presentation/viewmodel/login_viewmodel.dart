import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../domain/usecase/login_usecase.dart';

part 'login_viewmodel.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  final error = LoginError();
  final _usecase = Modular.get<LoginUseCase>();

  @observable
  String email = '';

  @observable
  String password = '';

  @action
  void validateEmail() {
    error.email = _usecase.validateEmail(email);
  }

  @action
  void validatePassword() {
    error.password = _usecase.validatePassword(password);
  }

  bool login() {
    error.clear();

    validateEmail();
    validatePassword();

    if (!error.hasErrors) {
      return false;
    } else {
      return true;
    }
  }
}

class LoginError = _LoginErrorBase with _$LoginError;

abstract class _LoginErrorBase with Store {
  @observable
  String? email;

  @observable
  String? password;

  @observable
  String? login;

  @computed
  bool get hasErrors => email != null || password != null || login != null;

  void clear() {
    email = null;
    password = null;
    login = null;
  }
}
