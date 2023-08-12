import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/router.router.dart';

import '../../../models/cane_list_model.dart';
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
      default:
        return const Color(0xFFFFF5F5);
    }
  }

  initialise(BuildContext context) async {
    setBusy(true);
    caneList = (await ListCaneService().getAllCaneList()).cast<CaneListModel>();
    canefilterList = caneList;
    setBusy(false);
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