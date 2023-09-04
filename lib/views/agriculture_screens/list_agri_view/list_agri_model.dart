import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../models/agri_list_model.dart';
import '../../../router.router.dart';
import '../../../services/list_agri_services.dart';

class ListAgriModel extends BaseViewModel {
  TextEditingController namecontroller = TextEditingController();
  String caneNameFilter = "";
  List<AgriListModel> agriList = [];
  List<AgriListModel> filteredagriList = [];

  initialise(BuildContext context) async {
    setBusy(true);
    agriList = (await ListAgriService().getAllCaneList()).cast<AgriListModel>();
    filteredagriList = agriList;
    setBusy(false);
    notifyListeners();
  }

  void filterListByNameAndVillage({String? name}) async {
    caneNameFilter = name ?? caneNameFilter;

    notifyListeners();
    filteredagriList =
        await ListAgriService().getAgriListByNameFilter(caneNameFilter);
    notifyListeners();
  }

  void onRowClick(BuildContext context, AgriListModel? agriList) {
    Navigator.pushNamed(
      context,
      Routes.addAgriScreen,
      arguments: AddAgriScreenArguments(agriId: agriList?.name ?? ""),
    );
    // Navigator.pushNamed(context, Routes.detailedFarmerScreen,
    //     arguments: DetailedFarmerScreenArguments(id: farmresList?.name ?? ""));
  }
}
