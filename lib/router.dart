import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sugar_mill_app/views/add_cane_view/add_cane_screen.dart';
import 'package:sugar_mill_app/views/farmer_screens/add_farmer_view/add_farmer_screen.dart';
import 'package:sugar_mill_app/views/farmer_screens/detailed_farmer_view/detailed_farmer_screen.dart';
import 'package:sugar_mill_app/views/farmer_screens/list_farmers_view/list_farmers_screen.dart';
import 'package:sugar_mill_app/views/home_view/home_view_screen.dart';
import 'package:sugar_mill_app/views/list_cane_view/list_cane_screen.dart';
import 'package:sugar_mill_app/views/login_view/login_view_screen.dart';
import 'package:sugar_mill_app/views/splash_screen_view/splash_screen.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashScreen, initial: true),
    MaterialRoute(page: HomePageScreen),
    MaterialRoute(page: LoginViewScreen),
    MaterialRoute(page: AddFarmerScreen),
    MaterialRoute(page: ListFarmersScreen),
    // DetailedFarmerScreen
    MaterialRoute(page: DetailedFarmerScreen),
    MaterialRoute(page: AddCaneScreen),
    MaterialRoute(page: ListCaneScreen)
  ],
  dependencies: [
    Singleton(classType: NavigationService),
  ],
)
class App {
  //empty class, will be filled after code generation
}
// flutter pub run build_runner build --delete-conflicting-outputs
