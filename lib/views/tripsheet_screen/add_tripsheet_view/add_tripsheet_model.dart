import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/models/trip_crop_harvesting_model.dart';
import 'package:sugar_mill_app/models/tripsheet.dart';

import '../../../constants.dart';
import '../../../models/cane_route.dart';
import '../../../models/tripsheet_transport_model.dart';
import '../../../models/tripsheet_water_supplier.dart';

import '../../../services/add_tripsheet_service.dart';

class AddTripSheetModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  List<String> season = [""];
  List<String> plantList = [""];
  List<cropharvestingModel> plotList = [];
  TextEditingController plantingDateController = TextEditingController();
  TextEditingController slipnoController = TextEditingController();
  TextEditingController deductionController = TextEditingController();
  TextEditingController watershareController = TextEditingController();
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
  String? routename;
  double? area;
  String? selectedfarcode;
  String? seletedvendor;
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
    plotList = await AddTripSheetServices().fetchPlot("");
    season = await AddTripSheetServices().fetchSeason();
    plantList = await AddTripSheetServices().fetchPlant();
    routeList = await AddTripSheetServices().fetchRoute();
    transportList = await AddTripSheetServices().fetchTransport();
    waterSupplier = await AddTripSheetServices().fetchWaterSupplier();
    tripSheetData.branch="Bedkihal";
    if (tripId != "") {
      isEdit = true;
      tripSheetData =
          await AddTripSheetServices().getTripsheet(tripId) ?? Tripsheet();
      // selectedCaneRoute = tripSheetData.routeName;
      for (caneRoute i in routeList) {
        if (i.name == tripSheetData.routeName) {
          selectedCaneRoute = i.route;
          notifyListeners();
          Logger().i(selectedCaneRoute);
        }
      }
      for (cropharvestingModel i in plotList) {
        if (i.growerCode == tripSheetData.farmerCode) {
          selectedfarcode = i.vendorCode;
          notifyListeners();
          Logger().i(selectedfarcode);
        }
      }
      for (WaterSupplierList i in waterSupplier) {
        if (i.name == tripSheetData.waterSupplier) {
          watersuppliercode = i.existingSupplierCode;
          notifyListeners();
          Logger().i(watersuppliercode);
        }
      }
      notifyListeners();
      plantingDateController.text = tripSheetData.plantationDate ?? '';
      slipnoController.text = tripSheetData.slipNo.toString();
      deductionController.text = tripSheetData.deduction.toString();
      watershareController.text = tripSheetData.waterShare.toString();
    }
    if (season.isEmpty) {
      logout(context);
    }
    if (waterSupplier.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,

          content: Text(
            'There is farmer available',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          duration: Duration(seconds: 3), // Adjust the duration as needed
        ),
      );
    }
    if (transportList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,

          content: Text(
            'There is Transporter available',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          duration: Duration(seconds: 3), // Adjust the duration as needed
        ),
      );
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

  void setSelectedSeason(BuildContext context, String? season) async {
    tripSheetData.season = season;
    plotList = await AddTripSheetServices().fetchPlot(season ?? "");
    if (plotList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,

          content: Text(
            'There is No plot available at season $season',
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          duration: const Duration(seconds: 3), // Adjust the duration as needed
        ),
      );
    }
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
    tripSheetData.platNoId = selectedGrowerData.id;
    dist = double.tryParse(selectedGrowerData.routeKm ?? "");
    routename = selectedGrowerData.route;
    selectedfarcode = selectedGrowerData.vendorCode;
    tripSheetData.vendorCode = selectedGrowerData.vendorCode;
    tripSheetData.farmerCode = farmerCode;
    tripSheetData.farmerName = farmerName;
    tripSheetData.plantationDate = plantingDateController.text;
    tripSheetData.fieldVillage = village;
    tripSheetData.caneVariety = caneVariety;
    tripSheetData.surveryNo = surveyNo;
    tripSheetData.areaAcre = area;

    Logger().i(routename);
    notifyListeners();
  }

  String? selectedCaneRoute = "";

  void setSelectedRoute(caneRoute route) {
    selectedCaneRoute = route.route;
    tripSheetData.routeName = route.name;
    tripSheetData.distance = route.distanceKm;
    notifyListeners();
  }

  void setSelectedTransCode(String? traCode) {
    tripSheetData.transporterCode = traCode;
    final selectedGrowerData = transportList
        .firstWhere((growerData) => growerData.name.toString() == traCode);
    transName = selectedGrowerData.transporterName;
    vehicleType = selectedGrowerData.vehicleType;
    tripSheetData.transporter = selectedGrowerData.name.toString();

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

    Logger().i(tripSheetData.transporterName);
    Logger().i(tripSheetData.vehicleType);
    notifyListeners();
  }

  String? watersuppliercode;
  void setSelectedWaterSupplier(WaterSupplierList waterSupp) {
    Logger().i("watersupplier IS: $waterSupp");
    watersuppliercode = waterSupp.existingSupplierCode;
    tripSheetData.waterSupplier = waterSupp.name;
    notifyListeners();
    tripSheetData.waterSupplierName = waterSupp.supplierName;
    notifyListeners();
  }

  void setSelectedWaterSuppName(String? wsName) {
    watersupplierName = wsName;
    tripSheetData.waterSupplierName = watersupplierName;
    notifyListeners();
  }

  void setSelectedWaterSupShare(String? wsShare) {
    watershareController.value = watershareController.value.copyWith(
      text: wsShare ?? '',
      selection: TextSelection.collapsed(offset: (wsShare ?? '').length),
    );
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
    tripSheetData.harvestingCodeHt = hCode;
    final selectedGrowerData = transportList
        .firstWhere((growerData) => growerData.name.toString() == hCode);
    harCode = selectedGrowerData.harvesterCode;
    tripSheetData.harvesterCodeOld = harCode;
    harName = selectedGrowerData.harvesterName;
    tripSheetData.harvesterNameH = harName;
    notifyListeners();
  }

  void setSelectedHarName(String? hName) {
    harName = hName;
    tripSheetData.harvesterNameH = harName;
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
    slipnoController.value = slipnoController.value.copyWith(
      text: slipNo ?? '',
      selection: TextSelection.collapsed(offset: (slipNo ?? '').length),
    );
    tripSheetData.slipNo = int.tryParse(slipNo ?? "");
    notifyListeners();
  }

  void setSelectedDeduction(String? deduction) {
    tripSheetData.burnCane = deduction;
    notifyListeners();
  }

  void setSelectedDeductionAmount(String? amt) {
    deductionController.value = deductionController.value.copyWith(
      text: amt ?? '',
      selection: TextSelection.collapsed(offset: (amt ?? '').length),
    );

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
