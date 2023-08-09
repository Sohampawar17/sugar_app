import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/models/CaneFarmer.dart';
import 'package:sugar_mill_app/models/CaneRoute.dart';
import 'package:sugar_mill_app/services/add_cane_service.dart';
import 'package:sugar_mill_app/services/geolocation_service.dart';
import '../../models/Cane.dart';

class CaneViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  TextEditingController plantationdateController = TextEditingController();
  TextEditingController formNumberController = TextEditingController();
  TextEditingController areainAcrsController = TextEditingController();
  TextEditingController baselDateController = TextEditingController();
  Cane canedata = Cane();
  final List<String> plantlist = ['Bedkihal', 'Nagpur'];
  final List<String> seasonlist = ["2022-2023", "2023-2024"];
  final List<String> yesno = ["Yes", "No"];
  final List<String> yesnomachine = ["YES", "NO"];
  final List<String> yesnoroadside = ["Yes (होय)", "No (नाही)"];
  final List<String> plantationStatus = [
    "New",
    "Harvester",
    "Diversion",
    "Added To Sampling",
    "Added To Harvesting",
    "To Sampling",
    "To Harvesting"
  ];
  final List<String> seedType = ["Regular", "Foundation"];
  List<caneFarmer> farmerList = [];
  List<String> villageList = [""];
  List<String> canevarietyList = [""];
  List<String> plantationsystemList = [""];
  List<String> seedmaterialList = [""];
  List<String> croptypeList = [""];
  List<caneRoute> routeList = [];
  List<String> irrigationmethodList = [""];
  List<String> irrigationSourceList = [""];
  List<String> soilTypeList = [""];
  List<String> cropVarietyList = [""];
  late String caneId;

  String? validateplantationdate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select plantation date';
    }
    return null;
  }

  String? validateBaseldate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Basel Date';
    }
    return null;
  }

  void onplantationdateChanged(String value) {
    // You can use the value here if needed.
    // Since we are using a date picker to select DOB, the value will not change through regular typing.
    canedata.plantattionRatooningDate = value;
  }

  void onBaseldateChanged(String value) {
    // You can use the value here if needed.
    // Since we are using a date picker to select DOB, the value will not change through regular typing.
    canedata.basalDate = value;
  }

  DateTime? selectedDate;
  DateTime? selectedBaselDate;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      plantationdateController.text = DateFormat('yyyy-MM-dd').format(picked);
      canedata.plantattionRatooningDate = plantationdateController.text;
    }
  }

  Future<void> selectBaselDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedBaselDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedBaselDate) {
      selectedBaselDate = picked;
      baselDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      canedata.basalDate = baselDateController.text;
    }
  }

  initialise(BuildContext context, String caneId) async {
    setBusy(true);
    villageList = await AddCaneService().fetchVillages();
    canevarietyList = await AddCaneService().fetchCaneVariety();
    plantationsystemList = await AddCaneService().fetchplantationsystem();
    seedmaterialList = await AddCaneService().fetchseedMaterial();
    croptypeList = await AddCaneService().fetchCropType();
    routeList = (await AddCaneService().fetchroute());
    irrigationmethodList = await AddCaneService().fetchirrigationmethod();
    irrigationSourceList = await AddCaneService().fetchIrrigationSource();
    soilTypeList = await AddCaneService().fetchSoilType();
    farmerList = await AddCaneService().fetchfarmerListwithfilter();
    Logger().i(caneId);
    if (caneId != "") {
      isEdit = true;
      canedata = await AddCaneService().getCane(caneId) ?? Cane();
      notifyListeners();
    }
    setBusy(false);
  }

  void onSavePressed(BuildContext context) async {
    setBusy(true);

    if (formKey.currentState!.validate()) {
      bool res = false;
      // Create an instance of your GeolocationService
      GeolocationService geolocationService = GeolocationService();
      // Get the user's position using the geolocation service
      Position? position = await geolocationService.determinePosition();
      if (position != null) {
        // Get the placemark using the geolocation service
        Placemark? placemark = await geolocationService.getPlacemarks(position);
        if (placemark != null) {
          // Extract properties from the placemark
          String street = placemark.street ?? '';
          String subLocality = placemark.subLocality ?? '';
          String locality = placemark.locality ?? '';
          String postalCode = placemark.postalCode ?? '';
          String country = placemark.country ?? '';
          // Create a formatted address string
          String formattedAddress =
              '$street, $subLocality, $locality $postalCode, $country';
          // Update canedata object with latitude, longitude, and address
          canedata.latitude = position.latitude.toString();
          canedata.longitude = position.longitude.toString();
          canedata.city = formattedAddress;
          Logger().i(canedata.toJson().toString());
          // Now you have the updated canedata object with location information
          // You can proceed with saving the data

          res = await AddCaneService().addCane(canedata);
          if (res) {
            if (context.mounted) {
              setBusy(false);
              Navigator.pop(context);
              // Do something after successful save
            }
          }
        } else {
          // Handle case where placemark is null
          Fluttertoast.showToast(msg: 'Failed to get placemark');
          setBusy(false);
        }
      } else {
        // Handle case where obtaining location fails
        Fluttertoast.showToast(msg: 'Failed to get location');
        setBusy(false);
      }
    }

    setBusy(false);
  }

  String? selectedVillage;
  String? selectedirrigationmethod;
  String? selectedirrigationsource;
  String? selectedcroptype;
  String? selectedcropVariety;
  String? selectedSoilType;
  String? selectedSeedMaterial;
  String? selectedRoute;
  String? selectedPlantationSystem;
  double? selectedDistance;

  void setSelectedseedType(String? seedType) {
    canedata.seedType = seedType;
    notifyListeners();
  }

  void setSelectedareainacrs(String? areainAcrs) {
    canedata.areaAcrs = double.tryParse(areainAcrs!) ?? 0;
    notifyListeners();
  }

  void setselectedcropVariety(String? cropVariety) {
    selectedcropVariety = cropVariety;
    canedata.cropVariety = selectedcropVariety;
    notifyListeners();
  }

  void setselectedRoute(String? route) {
    selectedRoute = route;
    canedata.route = selectedRoute;
    Logger().i(route);
    final selectedRouteData =
        routeList.firstWhere((routeData) => routeData.name == route);
    selectedDistance =
        selectedRouteData.distanceKm; // Set th distance in the kmController
    canedata.routeKm = selectedDistance;
    Logger().i(selectedDistance);
    notifyListeners();
  }

  void setroutekm(double? routekm) {
    selectedDistance = routekm;
    canedata.routeKm = selectedDistance;
    notifyListeners();
  }

  void setselectedSeedMaterial(String? seedMaterial) {
    selectedSeedMaterial = seedMaterial;
    canedata.seedMaterial = selectedSeedMaterial;
    notifyListeners();
  }

  void setselectedPlantationSystem(String? plantationSystem) {
    selectedPlantationSystem = plantationSystem;
    canedata.plantationSystem = selectedPlantationSystem;
    notifyListeners();
  }

  void setSelectedVillage(String? village) {
    selectedVillage = village;
    canedata.area = selectedVillage;
    notifyListeners();
  }

  void setSelectedPlant(String? plant) {
    canedata.plantName = plant;
    notifyListeners();
  }

  void setSelectedSeason(String? season) {
    canedata.season = season;
    notifyListeners();
  }

  void setSelectedDevelopmentplot(String? developmentPlot) {
    canedata.developmentPlot = developmentPlot;
    notifyListeners();
  }

  void setSelectedisMachine(String? isMachine) {
    canedata.isMachine = isMachine;
    notifyListeners();
  }

  void setSelectedirrigationmethod(String? irrigationmethod) {
    selectedirrigationmethod = irrigationmethod;
    canedata.irrigationMethod = selectedirrigationmethod;
    notifyListeners();
  }

  void setSelectedirrigationsource(String? irrigationsource) {
    selectedirrigationsource = irrigationsource;
    canedata.irrigationSource = selectedirrigationsource;
    notifyListeners();
  }

  void setSelectedcroptype(String? croptype) {
    selectedcroptype = croptype;
    canedata.cropType = selectedcroptype;
    notifyListeners();
  }

  void setSelectedSoilType(String? soilType) {
    selectedSoilType = soilType;
    canedata.soilType = selectedSoilType;
    notifyListeners();
  }

  String? selectedgrowercode;
  String? selectedgrowername;

  void setSelectedgrowercode(String? growercode) {
    selectedgrowercode = growercode;
    canedata.growerCode = selectedgrowercode;
    final selectedgrowerData =
        farmerList.firstWhere((growerData) => growerData.name == growercode);
    Logger().i(selectedgrowerData);
    selectedgrowername =
        selectedgrowerData.supplierName; // Set th distance in the kmController
    canedata.growerName = selectedgrowername;
    Logger().i(selectedgrowername);
    notifyListeners();
  }

  void setSelectedgrowername(String? growername) {
    selectedgrowername = growername;
    canedata.growerName = selectedgrowername;
    notifyListeners();
  }

  void setSelectedkisan(String? kisan) {
    canedata.isKisanCard = kisan;
    notifyListeners();
  }

  void setSelectedplantation(String? plantationStatus) {
    canedata.plantationStatus = plantationStatus;
    notifyListeners();
  }

  void setSelectedRoadSIde(String? roadside) {
    canedata.roadSide = roadside;
    notifyListeners();
  }

  void setsurveyNumber(String? surveyNumber) {
    canedata.surveyNumber = surveyNumber;
    notifyListeners();
  }

  void setFormNumber(String? formNumber) {
    canedata.formNumber = formNumber;
    notifyListeners();
  }

  bool isEdit = false;

  getVisibility() {
    return isEdit;
  }

  ////////////////// validators ////////////////////////////////////

  String? validateRoute(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Route';
    }
    return null;
  }

  String? validateVillage(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Village';
    }
    return null;
  }

  String? validatePlantationSystem(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Plantation System';
    }
    return null;
  }

  String? validateDevelopmentPlot(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Development Plot';
    }
    return null;
  }

  String? validateisMachine(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Is Machine';
    }
    return null;
  }

  String? validatePlant(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Plant';
    }
    return null;
  }

  String? validateCropVariety(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Crop Variety';
    }
    return null;
  }

  String? validateSeedMaterial(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Seed Material';
    }
    return null;
  }

  String? validateirrigationMethod(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Irrigation Method';
    }
    return null;
  }

  String? validateirrigationSource(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Irrigation Source';
    }
    return null;
  }

  String? validateSeason(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Season';
    }
    return null;
  }

  String? validateSoilType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Soil Type';
    }
    return null;
  }

  String? validateGrowerCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Grower Code';
    }
    return null;
  }

  String? validateKisanCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Is Kisan Card';
    }
    return null;
  }

  String? validatePlantationStatus(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select plantation status';
    }
    return null;
  }

  String? validateRoadSide(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Road Side';
    }
    return null;
  }

  String? validateSeedType(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Seed Type';
    }
    return null;
  }

  String? validateCropType(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Crop Type';
    }
    return null;
  }
}
