import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/models/trip_crop_harvesting_model.dart';
import 'package:sugar_mill_app/models/tripsheet.dart';
import '../../../models/CaneRoute.dart';
import '../../../models/tripsheet_transport_model.dart';
import '../../../models/tripsheet_water_supplier.dart';
import '../../../router.router.dart';
import '../../../services/add_tripsheet_service.dart';

class AddTripSheetModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  List<String> season = [""];
  List<String> plantList = [""];
  List<cropharvestingModel> plotList = [];
  TextEditingController plantingDateController = TextEditingController();
  final List<String> deductionType = [
    "Matured Cane",
    "Burn Cane",
    "Unmatured Cane"
  ];
  final List<String> ropeType = [
    "All",
    "trailor 1 st",
    "trailor  2 nd",
    "1 st & 2 nd trailor  upper rope",
    "1 st and 2 nd Bottom rope",
    "1st trailor all & 2nd  trailor  Upper Rope",
    "1st trailor all & 2nd  trailor  Bottom Rope",
    "1st trailor  upper rope",
    "1st trailor  Bottom rope",
    "2nd trailor all & 1st  trailor  Upper Rope",
    "2nd trailor  Bottom rope",
    "TL Middle Rope",
    "TL Middle Rope 1",
    "TL Bottom Rope",
    "TL Bottom & Middle Rope",
    "TL Top & Middle Rope",
    "2nd trailor all & 1st trailor  upper rope",
    "2nd trailor upper rope",
    "TL Middle Rope 2"
  ];
  List<WaterSupplierList> waterSupplier = [];
  List<caneRoute> routeList = [];
  List<TransportInfo> transportList = [];
  String? farmerCode;
  String? farmerName;
  String? village;
  String? caneVariety;
  String? surveyNo;
  double? area;
  DateTime? selectedDate;
  double? dist;
  String? transName;
  String? vehicleType;
  String? harCode;
  String? harName;
  String? eNo;
  String? trl_1;
  String? tri_2;
  String? gang;
  String? watersupplierName;
  bool isEdit = false;
  Tripsheet tripSheetData = Tripsheet();

  void onSavePressed(BuildContext context) async {
    setBusy(true);
    bool res = false;
    if (formKey.currentState!.validate()) {
      if (isEdit == true) {
        res = await AddTripSheetServices().updateTrip(tripSheetData);
        if (res) {
          if (context.mounted) {
            setBusy(false);
            setBusy(false);
            Navigator.pop(context);
          }
        }
      } else {
        res = await AddTripSheetServices().addTripSheet(tripSheetData);
        if (res) {
          if (context.mounted) {
            setBusy(false);
            setBusy(false);
            Navigator.pop(context);
          }
        }
      }
    }
    setBusy(false);
  }

  initialise(BuildContext context, String tripId) async {
    setBusy(true);
    season = await AddTripSheetServices().fetchSeason();
    plantList = await AddTripSheetServices().fetchPlant();
    plotList = await AddTripSheetServices().fetchPlot();
    routeList = await AddTripSheetServices().fetchRoute();
    transportList = await AddTripSheetServices().fetchTransport();
    waterSupplier = await AddTripSheetServices().fetchWaterSupplier();
    if (tripId != "") {
      isEdit = true;
      tripSheetData =
          await AddTripSheetServices().getTripsheet(tripId) ?? Tripsheet();
      notifyListeners();
      plantingDateController.text = tripSheetData.plantationDate ?? '';
    }
    if (plotList.isEmpty) {
      final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
      final SharedPreferences prefs = await prefs0;
      prefs.clear();
      if (context.mounted) {
        setBusy(false);
        Navigator.popAndPushNamed(context, Routes.loginViewScreen);
        Logger().i('logged out success');
      }
    }
    setBusy(false);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      plantingDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      tripSheetData.plantationDate = plantingDateController.text;
    }
  }

  void setSelectedSeason(String? season) {
    tripSheetData.season = season;
    notifyListeners();
  }

  void setSelectedPlant(String? plantList) {
    tripSheetData.branch = plantList;
    notifyListeners();
  }

  void setSelectPlotNo(String? plotNo) {
    final selectedGrowerData =
        plotList.firstWhere((growerData) => growerData.id == plotNo);
    Logger().i(plotNo);
    Logger().i(selectedGrowerData.toJson().toString());
    farmerCode = selectedGrowerData.growerCode;
    farmerName = selectedGrowerData.growerName;
    village = selectedGrowerData.area;
    caneVariety = selectedGrowerData.cropVariety;
    surveyNo = selectedGrowerData.surveyNumber;
    area = selectedGrowerData.areaAcrs;
    plantingDateController.text =
        selectedGrowerData.plantattionRatooningDate.toString();
    tripSheetData.plotNo = selectedGrowerData.name;
    tripSheetData.farmerCode = farmerCode;
    tripSheetData.farmerName = farmerName;
    tripSheetData.plantationDate = plantingDateController.text;
    tripSheetData.fieldVillage = village;
    tripSheetData.caneVariety = caneVariety;
    tripSheetData.surveryNo = surveyNo;
    tripSheetData.areaAcre = area;
    Logger().i(farmerName);
    notifyListeners();
  }

  void setSelectedRoute(String? route) {
    final selectedGrowerData =
        routeList.firstWhere((growerData) => growerData.route == route);
    dist = selectedGrowerData.distanceKm;
    tripSheetData.routeName = selectedGrowerData.name;
    tripSheetData.distance = dist;
    Logger().i(tripSheetData.distance);
    notifyListeners();
  }

  void setSelectedTransCode(String? traCode) {
    tripSheetData.transporterCode = traCode;
    final selectedGrowerData = transportList
        .firstWhere((growerData) => growerData.name.toString() == traCode);
    transName = selectedGrowerData.transporterName;
    vehicleType = selectedGrowerData.vehicleType;
    harCode = selectedGrowerData.harvesterCode;
    harName = selectedGrowerData.harvesterName;
    eNo = selectedGrowerData.vehicleNo;
    trl_1 = selectedGrowerData.trolly1;
    tri_2 = selectedGrowerData.trolly2;
    gang = selectedGrowerData.gangType;
    tripSheetData.vehicleNumber = eNo;
    tripSheetData.gangType = gang;
    tripSheetData.tolly1 = trl_1;
    tripSheetData.tolly2 = tri_2;
    tripSheetData.transporterName = transName;
    tripSheetData.vehicleType = vehicleType;
    tripSheetData.harvesterName = harName;
    tripSheetData.harvesterCode = harCode;
    Logger().i(tripSheetData.transporterName);
    Logger().i(tripSheetData.vehicleType);
    notifyListeners();
  }

  void setSelectedWaterSupplier(String? waterSupp) {
    tripSheetData.waterSupplier = waterSupp;
    final selectedGrowerData =
        waterSupplier.firstWhere((growerData) => growerData.name == waterSupp);
    watersupplierName = selectedGrowerData.supplierName;
    tripSheetData.waterSupplierName = watersupplierName;
    notifyListeners();
  }

  void setSelectedWaterSuppName(String? wsName) {
    watersupplierName = wsName;
    tripSheetData.waterSupplierName = watersupplierName;
    notifyListeners();
  }

  void setSelectedWaterSupShare(String? wsShare) {
    tripSheetData.waterShare = double.tryParse(wsShare ?? "");
    Logger().i(tripSheetData.waterShare);
    notifyListeners();
  }

  void setSelectedEngine(String? eng) {
    eNo = eng;
    tripSheetData.vehicleNumber = eNo;
    notifyListeners();
  }

  void setSelectedGang(String? gangType) {
    gang = gangType;
    tripSheetData.gangType = gang;
    notifyListeners();
  }

  void setSelectedTy_1(String? tol_1) {
    trl_1 = tol_1;
    tripSheetData.tolly1 = trl_1;
    notifyListeners();
  }

  void setSelectedTy_2(String? tol_2) {
    tri_2 = tol_2;
    tripSheetData.tolly2 = tri_2;
    notifyListeners();
  }

  void setSelectedHarCode(String? hCode) {
    harCode = hCode;
    tripSheetData.harvesterCode = harCode;
    notifyListeners();
  }

  void setSelectedHarName(String? hName) {
    harName = hName;
    tripSheetData.harvesterName = harName;
    notifyListeners();
  }

  void setSelectedTransporterName(String? traName) {
    transName = traName;
    tripSheetData.transporterCode = transName;
    notifyListeners();
  }

  void setSelectedVType(String? vType) {
    vehicleType = vType;
    tripSheetData.vehicleType = vehicleType;
    notifyListeners();
  }

  void setSelectedDistance(String? distance) {
    tripSheetData.distance = double.tryParse(distance ?? "");
    notifyListeners();
  }

  void setSelectFarmerCode(String? farCode) {
    farmerCode = farCode;
    tripSheetData.farmerCode = farmerCode;
    notifyListeners();
  }

  void setSelectFarmerName(String? farName) {
    farmerName = farName;
    tripSheetData.farmerName = farmerName;
    notifyListeners();
  }

  void setSelectVillage(String? village) {
    village = village;
    tripSheetData.fieldVillage = village;
    notifyListeners();
  }

  void setSelectVariety(String? variety) {
    caneVariety = variety;
    tripSheetData.caneVariety = caneVariety;
    notifyListeners();
  }

  void setSelectPlantationDate(String? plantationDate) {
    tripSheetData.caneVariety = plantationDate;
    notifyListeners();
  }

  void setSelectSurvey(String? survey) {
    surveyNo = survey;
    tripSheetData.surveryNo = surveyNo;
    notifyListeners();
  }

  void setSelectArea(String? areaAcr) {
    area = double.tryParse(areaAcr ?? "");
    tripSheetData.areaAcre = area;
    notifyListeners();
  }

  void setSelectSlipNo(String? slipNo) {
    tripSheetData.slipNo = int.tryParse(slipNo ?? "");
    notifyListeners();
  }

  void setSelectedDeduction(String? deduction) {
    tripSheetData.burnCane = deduction;
    notifyListeners();
  }

  void setSelectedDeductionAmount(String? amt) {
    tripSheetData.deduction = double.tryParse(amt ?? "");
    notifyListeners();
  }

  void setSelectedRope(String? ropeData) {
    tripSheetData.rope = ropeData;
    Logger().i(tripSheetData.rope);
    notifyListeners();
  }

  void setSelectedCartNo(String? cartNo) {
    tripSheetData.cartno = double.tryParse(cartNo ?? "");
  }

  ///////validators//////

  String? validatePlotNo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select plot Number';
    }
    return null;
  }

  String? validateRote(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select the route';
    }
    return null;
  }

  String? validateDedAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select plot Number';
    }
    return null;
  }

  String? validateTrans(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select the route';
    }
    return null;
  }

  String? validateWaterSupplier(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select the Water Supplier';
    }
    return null;
  }

  String? validateCartNo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Cart No';
    }
    return null;
  }
  // String? validateSlipNo(String? value)
  // {
  //   if (value == null || value.isEmpty) {
  //     return 'Please Enter Slip Nor';
  //   }
  //   return null;
  // }
}
