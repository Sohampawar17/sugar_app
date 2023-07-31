import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sugar_mill_app/views/home_view/home_view_screen.dart';
import 'package:sugar_mill_app/views/login_view/login_view_screen.dart';
import 'package:sugar_mill_app/views/splash_screen_view/splash_screen.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashScreen, initial: true),
    MaterialRoute(page: HomePageScreen),
    MaterialRoute(page: LoginViewScreen),
  ],
  dependencies: [
    Singleton(classType: NavigationService),
  ],
)
class App {
  //empty class, will be filled after code generation
}
