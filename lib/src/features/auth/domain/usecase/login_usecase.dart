import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import '../model/user.dart';
import '../repository/login_interface.dart';

class LoginUseCase {
  final repository = Modular.get<ILogin>();

  String? validateEmail(String email) {
    if (email.length < 5) {
      return "short_email".i18n();
    } else if (!email.contains("@")) {
      return "invalid_email".i18n();
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.length < 5) {
      return "short_password".i18n();
    }
    return null;
  }

  Future<User> login(String email, String password) {
    return repository.login(User(email, password));
  }
}
