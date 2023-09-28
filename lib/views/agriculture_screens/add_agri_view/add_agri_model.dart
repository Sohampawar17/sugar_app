import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/constants.dart';
import 'package:sugar_mill_app/models/agri.dart';
import 'package:sugar_mill_app/models/item.dart';

import '../../../models/agri_cane_model.dart';
import '../../../models/cane_farmer.dart';
import '../../../models/dose_type.dart';

import '../../../services/add_agri_services.dart';

class AgriViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final bankformKey = GlobalKey<FormState>();
  final agriformKey = GlobalKey<FormState>();
  Agri agridata = Agri();
  List<AgricultureDevelopmentItem> agricultureDevelopmentItem = [];
  List<AgricultureDevelopmentItem2> agricultureDevelopmentItem2 = [];
  List<Grantor> grantor = [];
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
  List<String> saleslist = ["Drip", "Plant (Rope)", "Fertilizer"];
  List<AgriCane> canelistwithfilter = [];
  List<caneFarmer> farmerList = [];
  List<Item> itemList = [];

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
    farmerList = await AddAgriServices().fetchfarmerListwithfilter();
    itemList = await AddAgriServices().fetchItem();
    if (agriid != "") {
      isEdit = true;
      agridata = await AddAgriServices().getAgri(agriid) ?? Agri();
      notifyListeners();
      datecontroller.text = agridata.date ?? '';
      developmentAreaController.text = agridata.developmentArea.toString();

      agricultureDevelopmentItem
          .addAll(agridata.agricultureDevelopmentItem?.toList() ?? []);
      grantor.addAll(agridata.grantor?.toList() ?? []);
      agricultureDevelopmentItem2
          .addAll(agridata.agricultureDevelopmentItem2?.toList() ?? []);
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
      logout(context);
    }
    setBusy(false);
  }

  List<DosetypeModel> doseList = [];

  void onSavePressed(BuildContext context) async {
    if (agridata.docstatus == 1) {
      Fluttertoast.showToast(
          msg: "Can not edit Submitted document!",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      return;
    }
    setBusy(true);
    if (formKey.currentState!.validate()) {
      agridata.agricultureDevelopmentItem = agricultureDevelopmentItem;
      agridata.grantor = grantor;
      agridata.agricultureDevelopmentItem2 = agricultureDevelopmentItem2;
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

  void mapJsonToTable() async {
    double developmentArea =
        agridata.developmentArea ?? 0.0; // Assign your development area here
    double fixedArea = developmentArea.roundToDouble();
    double guntacal = developmentArea - fixedArea;
    double guntacalfix = double.parse(guntacal.toStringAsFixed(2));
    double quotent = 0.0;

    if (guntacalfix >= 0.01 && guntacalfix <= 0.10) {
      quotent = 0.0;
    } else if (guntacalfix >= 0.11 && guntacalfix <= 0.20) {
      quotent = 0.25;
    } else if (guntacalfix >= 0.21 && guntacalfix <= 0.30) {
      quotent = 0.50;
    } else if (guntacalfix >= 0.31 && guntacalfix <= 0.39) {
      quotent = 0.75;
    } else if (guntacalfix >= 0.40) {
      throw Exception(
          "Invalid input. The Gunta should be between 0.01 and 0.40.");
    } else {
      quotent = 0.0;
    }

    String croptype = agridata.cropType ?? "";
    String cropvariety = agridata.cropVariety ?? "";
    double areagunta = ((fixedArea * 40) + (quotent * 40)) / 40;
    String basel = agridata.basel == 1 ? 'Basel' : 'False';
    String preearth = agridata.preEarthing == 1 ? 'Pre-Earth' : 'False';
    String earth = agridata.earth == 1 ? 'Earthing' : 'False';
    String rainy = agridata.rainy == 1 ? 'Rainy' : 'False';
    String ratoon1 = agridata.ratoon1 == 1 ? 'Ratoon 1' : 'False';
    String ratoon2 = agridata.ratoon2 == 1 ? 'Ratoon 2' : 'False';

    doseList = await AddAgriServices().fetchdosetype(
        basel,
        preearth,
        earth,
        rainy,
        ratoon1,
        ratoon2,
        croptype,
        cropvariety,
        developmentArea,
        fixedArea,
        areagunta);
    Logger().i(doseList.toString());
    agricultureDevelopmentItem = doseList.map((e) {
      return AgricultureDevelopmentItem(
          itemCode: e.itemCode,
          itemName: e.itemName,
          basel: e.baselqty ?? 0.0,
          preEarthing: e.preearthqty ?? 0.0,
          earth: e.earthingqty ?? 0.0,
          rainy: e.rainyqty ?? 0.0,
          ratoon1: e.ratoon1qty ?? 0.0,
          ratoon2: e.ratoon2qty ?? 0.0,
          qty: ((e.baselqty ?? 0.0) +
              (e.preearthqty ?? 0.0) +
              (e.earthingqty ?? 0.0) +
              (e.rainyqty ?? 0.0) +
              (e.ratoon1qty ?? 0.0) +
              (e.ratoon2qty ?? 0.0))
          // Add other properties here
          );
    }).toList();
    notifyListeners();
  }

  void calculateTotal() {
    for (int index = 0; index < agricultureDevelopmentItem.length; index++) {
      double total = (agricultureDevelopmentItem[index].basel ?? 0.0) +
          (agricultureDevelopmentItem[index].preEarthing ?? 0.0) +
          (agricultureDevelopmentItem[index].earth ?? 0.0) +
          (agricultureDevelopmentItem[index].rainy ?? 0.0) +
          (agricultureDevelopmentItem[index].ratoon1 ?? 0.0) +
          (agricultureDevelopmentItem[index].ratoon2 ?? 0.0);

      // Update the qty property of the item with the calculated total
      agricultureDevelopmentItem[index].qty = total;
    }
  }

  void validateForm(BuildContext context, int index) async {
    final formState = bankformKey.currentState;
    if (formState!.validate()) {
      // Form is valid, submit it
      setBusy(true);

      submitBankAccount(index);
      setBusy(false);
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Grantor is Added Succesfully", toastLength: Toast.LENGTH_LONG);
    } else {
      // Form is invalid, show error messages
      Logger().i('Grantor Form is invalid');
    }
  }

  void validateAgriForm2(BuildContext context, int index) async {
    final formState = agriformKey.currentState;
    if (formState!.validate()) {
      // Form is valid, submit it
      setBusy(true);
      submitAgriAccount2(index);
      setBusy(false);
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "AgriCulture Item is Added Succesfully",
          toastLength: Toast.LENGTH_LONG);
    } else {
      // Form is invalid, show error messages
      Logger().i('AgriCulture Item Form is invalid');
    }
  }

  void validateAgriForm(BuildContext context, int index) async {
    final formState = agriformKey.currentState;
    if (formState!.validate()) {
      // Form is valid, submit it
      setBusy(true);

      submitAgriAccount(index);
      setBusy(false);
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "AgriCulture Item is Added Succesfully",
          toastLength: Toast.LENGTH_LONG);
    } else {
      // Form is invalid, show error messages
      Logger().i('AgriCulture Item Form is invalid');
    }
  }

  void deleteBankAccount(int index) {
    if (index >= 0 && index < grantor.length) {
      grantor.removeAt(index);
      notifyListeners();
    }
  }

  void deleteAgriAccount(int index) {
    if (index >= 0 && index < agricultureDevelopmentItem.length) {
      agricultureDevelopmentItem.removeAt(index);
      notifyListeners();
    }
  }

  void deleteAgriAccount2(int index) {
    if (index >= 0 && index < agricultureDevelopmentItem2.length) {
      agricultureDevelopmentItem2.removeAt(index);
      notifyListeners();
    }
  }

  void setSelectedSales(String? sales) async {
    agridata.salesType = sales;
    if (agridata.salesType != 'Fertilizer') {
      agricultureDevelopmentItem2.clear();
    }
    notifyListeners();
  }

  void setSelectedSeason(String? season) async {
    agridata.season = season;
    canelistwithfilter =
        await AddAgriServices().fetchcanelistwithfilter(season ?? "");

    notifyListeners();
  }

  String? selectedgrower;
  String? route_km;
  void setPlotnumber(String? caneRegistrationId) async {
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
    selectedgrower = selectedCaneData.growerCode;
    selectedvendor = selectedCaneData.vendorCode;
    route_km = selectedCaneData.routeKm.toString();
    agridata.growerName = selectedVendorname;
    agridata.route = route_km;
    agridata.village = selectedvillage;
    agridata.cropVariety = selectedcropvariety;
    agridata.cropType = selectedcroptype;
    agridata.area = selectedAreaInAcrs;
    agridata.date = datecontroller.text;
    agridata.supplier = selectedgrower;
    agridata.vendorCode = selectedvendor;
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
    agridata.vendorCode = selectedVendorname;
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

  TextEditingController developmentAreaController = TextEditingController();
  // TextEditingController kmController = TextEditingController();

  void setSelecteddevelopmentarea(String? surveyNumber) {
    developmentAreaController.value = developmentAreaController.value.copyWith(
      text: surveyNumber ?? '',
      selection: TextSelection.collapsed(offset: (surveyNumber ?? '').length),
    );
    agridata.developmentArea = double.parse(surveyNumber ?? '');
    notifyListeners();
  }

  void setSelectedkm(String? km) {
    // kmController.value = kmController.value.copyWith(
    //   text: km ?? '',
    //   selection: TextSelection.collapsed(offset: (km ?? '').length),
    // );
    route_km = km ?? '';
    agridata.route = route_km;
    notifyListeners();
  }

  /////validations/////
  String? validateSeason(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Season';
    }
    return null;
  }

  String? validateSalesType(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Sales type';
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

  late String suretyname = "";
  late String suretyCode;
  late String suretyExistingCode;
  late String itemCode = "";
  late String itemName = "";
  late String itemCode2 = "";
  late String itemName2 = "";
  late double total = 0.0;

  void setValuesToAgriVaribles(int index) {
    if (index != -1) {
      if (index >= agricultureDevelopmentItem.length) {
        return;
      }
      // Reset all roles to false
      itemCode = agricultureDevelopmentItem[index].itemCode!;
      itemName = agricultureDevelopmentItem[index].itemName!;
    }
    notifyListeners();
  }

  void resetAgriVariables() {
    itemCode = "";
  }

  final totalController = TextEditingController();
  void submitAgriAccount(int index) {
    if (index != -1) {
      agricultureDevelopmentItem[index].itemCode = itemCode;
      agricultureDevelopmentItem[index].itemName = itemName;
      notifyListeners();
      return;
    }
    agricultureDevelopmentItem.add(AgricultureDevelopmentItem(
      itemCode: itemCode,
      itemName: itemName,
    ));
    notifyListeners();
  }

  void setValuesToAgriVaribles2(int index) {
    if (index != -1) {
      if (index >= agricultureDevelopmentItem2.length) {
        return;
      }
      // Reset all roles to false
      itemCode2 = agricultureDevelopmentItem2[index].itemCode!;
      itemName2 = agricultureDevelopmentItem2[index].itemName!;
      total = agricultureDevelopmentItem2[index].qty!;
    }
    notifyListeners();
  }

  final totalController2 = TextEditingController();
  void resetAgriVariables2() {
    itemCode2 = "";
    totalController2.clear();
  }

  void submitAgriAccount2(int index) {
    if (index != -1) {
      agricultureDevelopmentItem2[index].itemCode = itemCode2;
      agricultureDevelopmentItem2[index].itemName = itemName2;
      agricultureDevelopmentItem2[index].qty = total;
      notifyListeners();
      return;
    }
    agricultureDevelopmentItem2.add(AgricultureDevelopmentItem2(
      itemCode: itemCode2,
      itemName: itemName2,
      qty: total,
    ));
    notifyListeners();
  }

  void setSelectedAgri2(String? agri) async {
    Logger().i(agri);
    itemCode2 = agri ?? "";
    final bankData = itemList.firstWhere((bank) => bank.itemCode == agri);
    itemName2 = bankData.itemName ?? "";
    notifyListeners();
  }

  void setValuesTograntorVaribles(int index) {
    if (index != -1) {
      if (index >= grantor.length) {
        return;
      }
      // Reset all roles to false
      suretyCode = grantor[index].suretyCode!;
      suretyExistingCode = grantor[index].suretyExistingCode!;
      suretyname = grantor[index].suretyName!;
    }
    notifyListeners();
  }

  void resetBankVariables() {
    suretyExistingCode = "";
    suretyname = "";
  }

  void submitBankAccount(int index) {
    if (index != -1) {
      grantor[index].suretyExistingCode = suretyExistingCode;
      grantor[index].suretyName = suretyname;
      grantor[index].suretyCode = suretyCode;
      notifyListeners();
      return;
    }
    grantor.add(Grantor(
      suretyExistingCode: suretyExistingCode,
      suretyName: suretyname,
      suretyCode: suretyCode,
    ));
    notifyListeners();
  }

  void setSelectedAgri(String? agri) async {
    Logger().i(agri);
    itemCode = agri ?? "";
    final bankData = itemList.firstWhere((bank) => bank.itemCode == agri);
    itemName = bankData.itemName ?? "";
    notifyListeners();
  }

  void setSelectedtotal(double? sales) async {
    total = sales ?? 0.0;
    notifyListeners();
  }

  String? suretyexistingcode;

  void setSelectedgrantor(String? bank) async {
    Logger().i(bank);
    final selectedRouteData =
        farmerList.firstWhere((bankData) => bankData.name == bank);
    Logger().i(selectedRouteData);
    suretyCode = selectedRouteData.name ?? "";
    suretyExistingCode = selectedRouteData.existingSupplierCode ?? "";
    suretyname = selectedRouteData.supplierName ?? "";
    notifyListeners();
  }
}
