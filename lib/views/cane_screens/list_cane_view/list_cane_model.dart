import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/router.router.dart';

import '../../../models/cane_list_model.dart';
import '../../../services/add_cane_service.dart';
import '../../../services/list_cane_service.dart';

class ListCaneModel extends BaseViewModel {
  TextEditingController idcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  List<CaneListModel> caneList = [];
  List<CaneListModel> canefilterList = [];
  String caneNameFilter = "";
  String caneseasonFilter = "";

  Color getTileColor(String? plantationStatus) {
    switch (plantationStatus) {
      case 'New':
        return const Color(0xFFD3E8FD);
      case 'To Sampling':
        return const Color(0xFFEAF5EE);
      case 'Harvester':
        return const Color(0xFFDCEDC8);
      case 'Diversion':
        return const Color(0xFFE1BEE7);
      case 'Added to Sampling':
        return const Color(0xFFCFD8DC);
      case 'Added to Harvesting':
        return const Color(0xFF66BB6A);
      default:
        return const Color(0xFFFFF5F5);
    }
  }

  List<String> seasonlist = [""];
  initialise(BuildContext context) async {
    setBusy(true);
    caneList = (await ListCaneService().getAllCaneList()).cast<CaneListModel>();
    canefilterList = caneList;
    seasonlist = await AddCaneService().fetchSeason();
    setBusy(false);
    if (caneList.isEmpty) {
      final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
      final SharedPreferences prefs = await prefs0;
      prefs.clear();
      if (context.mounted) {
        setBusy(false);
        Navigator.popAndPushNamed(context, Routes.loginViewScreen);
        Logger().i('logged out success');
      }
    }
    notifyListeners();
  }

  void filterList(String filter, int query) async {
    notifyListeners();
    canefilterList =
        await ListCaneService().getAllCaneListfilter(filter, query);
    notifyListeners();
  }

  void filterListByNameAndVillage({String? name, String? village}) async {
    caneNameFilter = name ?? caneNameFilter;
    caneseasonFilter = village ?? caneseasonFilter;
    notifyListeners();
    canefilterList = await ListCaneService()
        .getCaneListByNameFilter(caneNameFilter, caneseasonFilter);
    notifyListeners();
  }

  void onRowClick(BuildContext context, CaneListModel? caneList) {
    Navigator.pushNamed(
      context,
      Routes.addCaneScreen,
      arguments:
          AddCaneScreenArguments(caneId: caneList?.name.toString() ?? " "),
    );
    // Navigator.pushNamed(context, Routes.detailedFarmerScreen,
    //     arguments: DetailedFarmerScreenArguments(id: farmresList?.name ?? ""));
  }
}
