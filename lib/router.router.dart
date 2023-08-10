// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/cupertino.dart' as _i11;
import 'package:flutter/material.dart' as _i10;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i12;
import 'package:sugar_mill_app/views/agriculture_screens/add_agri_view/add_agri_screen.dart'
    as _i9;
import 'package:sugar_mill_app/views/cane_screens/add_cane_view/add_cane_screen.dart'
    as _i7;
import 'package:sugar_mill_app/views/cane_screens/list_cane_view/list_cane_screen.dart'
    as _i8;
import 'package:sugar_mill_app/views/farmer_screens/add_farmer_view/add_farmer_screen.dart'
    as _i5;
import 'package:sugar_mill_app/views/farmer_screens/list_farmers_view/list_farmers_screen.dart'
    as _i6;
import 'package:sugar_mill_app/views/home_view/home_view_screen.dart' as _i3;
import 'package:sugar_mill_app/views/login_view/login_view_screen.dart' as _i4;
import 'package:sugar_mill_app/views/splash_screen_view/splash_screen.dart'
    as _i2;

class Routes {
  static const splashScreen = '/';

  static const homePageScreen = '/home-page-screen';

  static const loginViewScreen = '/login-view-screen';

  static const addFarmerScreen = '/add-farmer-screen';

  static const listFarmersScreen = '/list-farmers-screen';

  static const addCaneScreen = '/add-cane-screen';

  static const listCaneScreen = '/list-cane-screen';

  static const addAgriScreen = '/add-agri-screen';

  static const all = <String>{
    splashScreen,
    homePageScreen,
    loginViewScreen,
    addFarmerScreen,
    listFarmersScreen,
    addCaneScreen,
    listCaneScreen,
    addAgriScreen,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashScreen,
      page: _i2.SplashScreen,
    ),
    _i1.RouteDef(
      Routes.homePageScreen,
      page: _i3.HomePageScreen,
    ),
    _i1.RouteDef(
      Routes.loginViewScreen,
      page: _i4.LoginViewScreen,
    ),
    _i1.RouteDef(
      Routes.addFarmerScreen,
      page: _i5.AddFarmerScreen,
    ),
    _i1.RouteDef(
      Routes.listFarmersScreen,
      page: _i6.ListFarmersScreen,
    ),
    _i1.RouteDef(
      Routes.addCaneScreen,
      page: _i7.AddCaneScreen,
    ),
    _i1.RouteDef(
      Routes.listCaneScreen,
      page: _i8.ListCaneScreen,
    ),
    _i1.RouteDef(
      Routes.addAgriScreen,
      page: _i9.AddAgriScreen,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashScreen: (data) {
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.SplashScreen(),
        settings: data,
      );
    },
    _i3.HomePageScreen: (data) {
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.HomePageScreen(),
        settings: data,
      );
    },
    _i4.LoginViewScreen: (data) {
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.LoginViewScreen(),
        settings: data,
      );
    },
    _i5.AddFarmerScreen: (data) {
      final args = data.getArgs<AddFarmerScreenArguments>(nullOk: false);
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i5.AddFarmerScreen(key: args.key, farmerid: args.farmerid),
        settings: data,
      );
    },
    _i6.ListFarmersScreen: (data) {
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.ListFarmersScreen(),
        settings: data,
      );
    },
    _i7.AddCaneScreen: (data) {
      final args = data.getArgs<AddCaneScreenArguments>(nullOk: false);
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i7.AddCaneScreen(key: args.key, caneId: args.caneId),
        settings: data,
      );
    },
    _i8.ListCaneScreen: (data) {
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.ListCaneScreen(),
        settings: data,
      );
    },
    _i9.AddAgriScreen: (data) {
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.AddAgriScreen(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class AddFarmerScreenArguments {
  const AddFarmerScreenArguments({
    this.key,
    required this.farmerid,
  });

  final _i11.Key? key;

  final String farmerid;

  @override
  String toString() {
    return '{"key": "$key", "farmerid": "$farmerid"}';
  }

  @override
  bool operator ==(covariant AddFarmerScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.farmerid == farmerid;
  }

  @override
  int get hashCode {
    return key.hashCode ^ farmerid.hashCode;
  }
}

class AddCaneScreenArguments {
  const AddCaneScreenArguments({
    this.key,
    required this.caneId,
  });

  final _i11.Key? key;

  final String caneId;

  @override
  String toString() {
    return '{"key": "$key", "caneId": "$caneId"}';
  }

  @override
  bool operator ==(covariant AddCaneScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.caneId == caneId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ caneId.hashCode;
  }
}

extension NavigatorStateExtension on _i12.NavigationService {
  Future<dynamic> navigateToSplashScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomePageScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homePageScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginViewScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginViewScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddFarmerScreen({
    _i11.Key? key,
    required String farmerid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addFarmerScreen,
        arguments: AddFarmerScreenArguments(key: key, farmerid: farmerid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToListFarmersScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.listFarmersScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddCaneScreen({
    _i11.Key? key,
    required String caneId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addCaneScreen,
        arguments: AddCaneScreenArguments(key: key, caneId: caneId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToListCaneScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.listCaneScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddAgriScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addAgriScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomePageScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homePageScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginViewScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginViewScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddFarmerScreen({
    _i11.Key? key,
    required String farmerid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addFarmerScreen,
        arguments: AddFarmerScreenArguments(key: key, farmerid: farmerid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithListFarmersScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.listFarmersScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddCaneScreen({
    _i11.Key? key,
    required String caneId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addCaneScreen,
        arguments: AddCaneScreenArguments(key: key, caneId: caneId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithListCaneScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.listCaneScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddAgriScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addAgriScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
