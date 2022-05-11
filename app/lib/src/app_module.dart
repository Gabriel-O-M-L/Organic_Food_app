import 'package:flutter_modular/flutter_modular.dart';
import 'features/auth/auth_module.dart';
import 'package:pdm/src/features/onboarding/onboradModule.dart';
import 'package:pdm/src/features/auth/presentation/view/page/login.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: OnboardModule()),
        ChildRoute('/login', child: (_, __) => LoginScreen()),
      ];
}
