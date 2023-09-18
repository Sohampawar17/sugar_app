import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../../models/tripsheet_list_search.dart';
import '../../../router.router.dart';
import '../../../services/list_tripsheet_service.dart';

class ListTripsheet extends BaseViewModel {
  TextEditingController idcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  // TextEditingController idcontroller = TextEditingController();
  // TextEditingController namecontroller = TextEditingController();
  List<TripSheetSearch> triSheetList = [];
  List<TripSheetSearch> tripSheetFilter = [];
  List<String> seasonlist = [];
  String tripsheetVillageFilter = "";
  String tripsheeNameFilter = "";
  String tripsheetSeasonFilter = "";
  // String villageNameFilter = "";
  // String farmerNameFilter = "";
  // String transporterNameFilter = "";
  // String seasonFilter = "";

  initialise(BuildContext context) async {
    setBusy(true);
    triSheetList = (await ListTripshhetService().getAllTripsheetList())
        .cast<TripSheetSearch>();
    tripSheetFilter = triSheetList;
    seasonlist = await ListTripshhetService().fetchSeason();
    setBusy(false);
    if (triSheetList.isEmpty) {
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
    tripSheetFilter =
        await ListTripshhetService().getAllTripsheetListfilter(filter, query);
    notifyListeners();
  }

  void filterListByNameAndVillage(
      {String? transName, String? village, String? season}) async {
    tripsheeNameFilter = transName ?? tripsheeNameFilter;
    tripsheetVillageFilter = village ?? tripsheetVillageFilter;
    tripsheetSeasonFilter = season ?? tripsheetSeasonFilter;
    notifyListeners();
    tripSheetFilter = await ListTripshhetService().getTransporterNameFilter(
        tripsheeNameFilter, tripsheetVillageFilter, tripsheetSeasonFilter);
    notifyListeners();
  }

  void onRowClick(BuildContext context, TripSheetSearch? tripList) {
    Navigator.pushNamed(
      context,
      Routes.addTripsheetScreen,
      arguments:
          AddTripsheetScreenArguments(tripId: tripList?.name.toString() ?? " "),
    );
  }
}
