import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/models/Agri.dart';

import '../../../models/agri_cane_model.dart';
import '../../../router.router.dart';
import '../../../services/add_agri_services.dart';

class AgriViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  Agri agridata = Agri();
  List<AgricultureDevelopmentItem> agricultureDevelopmentItem = [];
  final List<String> items = [
    'Basel',
    'Pre-Earthing',
    'Earth',
    'Rainy',
    'Ratoon1',
    'Ratoon2'
  ];
  bool isEdit = false;
  List<String> seasonlist = [""];
  List<AgriCane> canelistwithfilter = [];
  String? selectedplot;
  String? selectedVendorname;
  String? selectedplant;
  String? selectedvillage;
  String? selectedcropvariety;
  String? selectedcroptype;
  double? selectedAreaInAcrs;
  String? selectedvendor;
  DateTime? selecteddate;
  TextEditingController datecontroller = TextEditingController();
  final List<String> _selectedItems = [];
  List<String> get selectedItems => _selectedItems;
  late String AgriId;

  initialise(BuildContext context, String agriid) async {
    setBusy(true);
    seasonlist = await AddAgriServices().fetchSeason();
    canelistwithfilter =
        await AddAgriServices().fetchcanelistwithfilter(agridata.season ?? "");
    if (agriid != "") {
      isEdit = true;
      agridata = await AddAgriServices().getAgri(agriid) ?? Agri();
      notifyListeners();
      datecontroller.text = agridata.date ?? '';
      agricultureDevelopmentItem
          .addAll(agridata.agricultureDevelopmentItem?.toList() ?? []);
      if (agridata.basel == 1) {
        _selectedItems.add(items[0]);
      }
      if (agridata.preEarthing == 1) {
        _selectedItems.add(items[1]);
      }
      if (agridata.earth == 1) {
        _selectedItems.add(items[2]);
      }
      if (agridata.rainy == 1) {
        _selectedItems.add(items[3]);
      }
      if (agridata.ratoon1 == 1) {
        _selectedItems.add(items[4]);
      }
      if (agridata.ratoon2 == 1) {
        _selectedItems.add(items[5]);
      }
    }
    if (seasonlist.isEmpty) {
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

  void setSelectedSeason(String? season) async {
    agridata.season = season;
    canelistwithfilter =
        await AddAgriServices().fetchcanelistwithfilter(season ?? "");
  }

  void setPlotnumber(String? caneRegistrationId) {
    selectedplot = caneRegistrationId;
    agridata.caneRegistrationId = selectedplot.toString();
    Logger().i(selectedplot);
    final selectedCaneData = canelistwithfilter.firstWhere(
        (caneData) => caneData.name.toString() == caneRegistrationId);
    Logger().i(selectedCaneData);
    selectedVendorname = selectedCaneData.growerName;
    selectedplant = selectedCaneData.plantName;
    selectedvillage = selectedCaneData.area;
    selectedcropvariety = selectedCaneData.cropVariety;
    selectedcroptype = selectedCaneData.cropType;
    selectedAreaInAcrs = selectedCaneData.areaAcrs;
    datecontroller.text = selectedCaneData.plantattionRatooningDate!;
    selectedvendor = selectedCaneData.vendorCode;
    agridata.growerName = selectedVendorname;
    agridata.village = selectedvillage;
    agridata.cropVariety = selectedcropvariety;
    agridata.cropType = selectedcroptype;
    agridata.area = selectedAreaInAcrs;
    agridata.date = datecontroller.text;
    agridata.supplier = selectedvendor;
    agridata.branch = selectedplant;
    notifyListeners();
  }

  void toggleItem(String item) {
    if (_selectedItems.contains(item)) {
      _selectedItems.remove(item);
      // 'Transporter', 'Harvester', 'Farmer', 'Member'
      if (item == items[0]) {
        agridata.basel = 0;
      }
      if (item == items[1]) {
        agridata.preEarthing = 0;
      }
      if (item == items[2]) {
        agridata.earth = 0;
      }
      if (item == items[3]) {
        agridata.rainy = 0;
      }
      if (item == items[4]) {
        agridata.ratoon1 = 0;
      }
      if (item == items[5]) {
        agridata.ratoon2 = 0;
      }
    } else {
      _selectedItems.add(item);
      if (item == items[0]) {
        agridata.basel = 1;
      }
      if (item == items[1]) {
        agridata.preEarthing = 1;
      }
      if (item == items[2]) {
        agridata.earth = 1;
      }
      if (item == items[3]) {
        agridata.rainy = 1;
      }
      if (item == items[4]) {
        agridata.ratoon1 = 1;
      }
      if (item == items[5]) {
        agridata.ratoon2 = 1;
      }
    }

    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selecteddate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selecteddate) {
      selecteddate = picked;
      datecontroller.text = DateFormat('yyyy-MM-dd').format(picked);
      agridata.date = datecontroller.text;
    }
  }

  void setSelectedVendor(String? supplier) {
    selectedVendorname = supplier;
    agridata.supplier = selectedVendorname;
    notifyListeners();
  }

  void setSelectedfarmername(String? growerName) {
    selectedVendorname = growerName;
    agridata.growerName = selectedVendorname;
    notifyListeners();
  }

  void setSelectedPlantName(String? branch) {
    selectedplant = branch;
    agridata.branch = selectedplant;
    notifyListeners();
  }

  void setSelectedvillage(String? village) {
    selectedvillage = village;
    agridata.village = selectedvillage;
    notifyListeners();
  }

  void setSelectedcropvariety(String? cropVariety) {
    selectedcropvariety = cropVariety;
    agridata.cropVariety = selectedcropvariety;
    notifyListeners();
  }

  void setSelectedcroptype(String? cropType) {
    selectedcroptype = cropType;
    agridata.cropType = selectedcroptype;
  }

  void setSelectedAreaInAcrs(String? area) {
    selectedAreaInAcrs = double.parse(area ?? '');
    agridata.area = selectedAreaInAcrs;
    notifyListeners();
  }

  void ondateChanged(String value) {
    agridata.date = value;
    notifyListeners();
  }

  void onSavePressed(BuildContext context) async {
    setBusy(true);
    if (formKey.currentState!.validate()) {
      bool res = false;
      Logger().i(agridata.toJson().toString());
      if (isEdit == true) {
        res = await AddAgriServices().updateAgri(agridata);
        if (res) {
          if (context.mounted) {
            setBusy(false);
            setBusy(false);
            Navigator.pop(context);
          }
        }
      } else {
        res = await AddAgriServices().addAgri(agridata);
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

  void setSelecteddevelopmentarea(String? developmentarea) {
    agridata.developmentArea = double.tryParse(developmentarea ?? "0");
    notifyListeners();
  }

  void setSelectedkm(String? km) {
    agridata.route = km;
    notifyListeners();
  }

  /////validations/////
  String? validateSeason(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Season';
    }
    return null;
  }

  String? validateplotNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Plot Number';
    }
    return null;
  }

  String? validatedevelopmentArea(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the Development Area';
    } else if (agridata.area == null || agridata.area! < double.parse(value)) {
      Logger().i(agridata.area.toString());
      return 'Enter a valid Development Area';
    } else {
      return null; // No validation error
    }
  }
}
