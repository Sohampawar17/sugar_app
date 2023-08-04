import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/models/farmrs_list_model.dart';
import 'package:sugar_mill_app/services/list_farmers_service.dart';

class ListFarmersModel extends BaseViewModel {
  TextEditingController villageController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  List<FarmersListModelData> farmresList = [];
  List<FarmersListModelData> filteredList = [];
  initialise(BuildContext context) async {
    setBusy(true);
    farmresList = await ListFarmersService().getAllFarmersList();
    filteredList = farmresList;
    setBusy(false);
    notifyListeners();
  }

  void onRowClick(BuildContext context, FarmersListModelData? farmresList) {
    Logger().i("${farmresList?.name}");
  }

  void filterList(String query, String filter) async {
    notifyListeners();
    filteredList =
        await ListFarmersService().getFarmersListByFilter(query, filter);
    notifyListeners();
  }
}
