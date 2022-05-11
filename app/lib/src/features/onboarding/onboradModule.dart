import 'package:flutter_modular/flutter_modular.dart';
import 'package:pdm/src/features/onboarding/presentation/page/onboarding.dart';

class OnboardModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => OnboardingScreen()),
      ];
}
