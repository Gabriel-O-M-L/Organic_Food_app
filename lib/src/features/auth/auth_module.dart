import 'package:flutter_modular/flutter_modular.dart';

import 'data/repository/login_repository.dart';
import 'domain/repository/login_interface.dart';
import 'domain/usecase/login_usecase.dart';
import 'presentation/view/page/login.dart';
import 'presentation/view/page/SignUp.dart';
import 'presentation/viewmodel/login_viewmodel.dart';
import 'package:pdm/src/features/auth/presentation/view/page/ResetPassoword.dart';

class AuthModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory((i) => LoginViewModel()),
        Bind.factory((i) => LoginUseCase()),
        Bind.factory<ILogin>((i) => LoginRepository()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => LoginScreen()),
        ChildRoute('/signup', child: (_, __) => SignUpScreen()),
        ChildRoute('/forgot', child: (_, __) => ForgetPassword())
      ];
}
