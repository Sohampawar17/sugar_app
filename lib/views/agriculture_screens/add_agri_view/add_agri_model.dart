import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/constants.dart';
import 'package:sugar_mill_app/models/agri.dart';
import 'package:sugar_mill_app/models/item.dart';
import 'package:sugar_mill_app/models/supplier_List.dart';
import '../../../models/agri_cane_model.dart';
import '../../../models/cane_farmer.dart';
import '../../../models/dose_type.dart';
import '../../../models/fertilizeritem.dart';
import '../../../models/village_model.dart';
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
  List<String> saleslist = ["Drip", "Nursery", "Fertilizer"];
  List<AgriCane> canelistwithfilter = [];
  List<caneFarmer> farmerList = [];
  List<Item> itemList = [];
  List<FertilizerItemList> fertilizeritemlist=[];
  List<SupplierList> supplierList = [];
List<villagemodel> villagelist=[];
  String? selectedplot;
  String? season;
  String? selectedVendorname;
  String? selectedplant;
  String? selectedvillage;
  String? selectedcropvariety;
  String? selectedcroptype;
  double? selectedAreaInAcrs;
  String? selectedvendor;
  DateTime? selecteddate;
  String? selectedgrowername;
  String? farmercode;
  TextEditingController datecontroller = TextEditingController();
  final List<String> _selectedItems = [];
  List<String> get selectedItems => _selectedItems;
  late String agriId;

  initialise(BuildContext context, String agriid) async {
    setBusy(true);
    seasonlist = await AddAgriServices().fetchSeason();
    supplierList = await AddAgriServices().fetchSupplierList();
    itemList = await AddAgriServices().fetchItem();
    fertilizeritemlist=await AddAgriServices().fetchItemwithfilter();
villagelist=await AddAgriServices().fetchVillages();
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

  List<DoseTypeModel> doseList = [];

  void onSavePressed(BuildContext context) async {
    if (agridata.docstatus == 1) {
      Fluttertoast.showToast(
          msg: "Can not edit Submitted document!",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      return;
    }
    if (grantor.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please fill the grantor details.",
          textColor: Colors.white);
      return;
    }
    setBusy(true);
    if (formKey.currentState!.validate()) {
      agridata.agricultureDevelopmentItem = agricultureDevelopmentItem;
      agridata.grantor = grantor;
      agridata.agricultureDevelopmentItem2 = agricultureDevelopmentItem2;
      bool res = false;

      Logger().i(agridata.toJson());
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
              (e.ratoon2qty ?? 0.0)),
itemTaxTemp: e.itemTaxTemp,
          actualQty: e.actualQty,
          taxNumber: e.taxNumber,
          rate: e.rate,
          weightPerUnit: e.weightPerUnit,
totalWeight: (e.weightPerUnit ?? 0.0) * (e.qty ?? 0.0),
          baseAmount: ((e.qty ?? 0.0) * (e.rate ?? 0.0)),
          taxableAmount: (((e.qty ?? 0.0) * (e.rate ?? 0.0))* (e.taxNumber ?? 0.0)/100),
          // Add other properties here
        totalAmount: (((e.qty ?? 0.0) * (e.rate ?? 0.0))+ (((e.qty ?? 0.0) * (e.rate ?? 0.0))* (e.taxNumber ?? 0.0)/100))
          );
    }).toList();

    notifyListeners();
    calculateratoon2total();
    calculateratoon1total();
    calculaterainytotal();
    calculatedearthtotal();
    calculateprearthtotal();
    calculatebaseltotal();
    calculatetotal();
    calculatetotalAmount();
calculatebaseAmount();
    calculatetotalgstamount();
    calculatetotalweight();
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
      agricultureDevelopmentItem[index].totalWeight=(agricultureDevelopmentItem[index].qty ?? 0.0)*(agricultureDevelopmentItem[index].weightPerUnit ?? 0.0);
      agricultureDevelopmentItem[index].baseAmount=(agricultureDevelopmentItem[index].qty ?? 0.0)*(agricultureDevelopmentItem[index].rate ?? 0.0);
      agricultureDevelopmentItem[index].taxableAmount=((agricultureDevelopmentItem[index].baseAmount ?? 0.0)*(agricultureDevelopmentItem[index].taxNumber ?? 0.0))/100;
      agricultureDevelopmentItem[index].totalAmount=(agricultureDevelopmentItem[index].baseAmount ?? 0.0)+(agricultureDevelopmentItem[index].taxableAmount ?? 0.0);
    }
    calculatetotalAmount();
    calculatebaseAmount();
    calculatetotalgstamount();
    calculatetotalweight();
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

  void setSelectedSales(String? sales)  {
    agridata.salesType = sales;
    if (agridata.salesType != 'Fertilizer') {
      agricultureDevelopmentItem2.clear();
    }
    Logger().i(agridata.salesType);
    Logger().i(sales);

    notifyListeners();
  }

  void setSelectedSeason(String? seasom)  {
    agridata.season = seasom;

    Logger().i(seasom);

    notifyListeners();
  }



   void setsseason
    (String? sales)  {
      agridata.season = sales;

      Logger().i(agridata.salesType);
      Logger().i(sales);

      notifyListeners();
    }

  void calculatebaseltotal() {
    double baselTotal = 0.0;
    for (int index = 0; index < agricultureDevelopmentItem.length; index++) {
      baselTotal += agricultureDevelopmentItem[index].basel ?? 0.0;
    }
    agridata.baselTotal = baselTotal;
  }

  void calculateprearthtotal() {
    double prearthtotal = 0.0;
    for (int index = 0; index < agricultureDevelopmentItem.length; index++) {
      prearthtotal += agricultureDevelopmentItem[index].preEarthing ?? 0.0;
    }
    agridata.preEarthingTotal = prearthtotal;
  }

  void calculatedearthtotal() {
    double earthtotal = 0.0;
    for (int index = 0; index < agricultureDevelopmentItem.length; index++) {
      earthtotal += agricultureDevelopmentItem[index].earth ?? 0.0;
    }
    agridata.earthTotal = earthtotal;
  }

  void calculaterainytotal() {
    double rainytotal = 0.0;
    for (int index = 0; index < agricultureDevelopmentItem.length; index++) {
      rainytotal += agricultureDevelopmentItem[index].rainy ?? 0.0;
    }
    agridata.rainyTotal = rainytotal;
  }

  void calculateratoon1total() {
    double ratoon1total = 0.0;
    for (int index = 0; index < agricultureDevelopmentItem.length; index++) {
      ratoon1total += agricultureDevelopmentItem[index].ratoon1 ?? 0.0;
    }
    agridata.ratoon1Total = ratoon1total;
  }

  void calculateratoon2total() {
    double ratoon2total = 0.0;
    for (int index = 0; index < agricultureDevelopmentItem.length; index++) {
      ratoon2total += agricultureDevelopmentItem[index].ratoon2 ?? 0.0;
    }
    agridata.ratoon2Total = ratoon2total;
  }

  void calculatetotal() {
    double total = 0.0;
    for (int index = 0; index < agricultureDevelopmentItem.length; index++) {
      total += agricultureDevelopmentItem[index].qty ?? 0.0;
    }
    agridata.total = total;
  }
  void calculatetotalweight() {
    double totalWeight = 0.0;
    for (int index = 0; index < agricultureDevelopmentItem.length; index++) {
      totalWeight += agricultureDevelopmentItem[index].totalWeight ?? 0.0;
    }
    agridata.totalWeight = totalWeight;
  }
  void calculatetotalgstamount() {
    double totalGstAmount = 0.0;
    for (int index = 0; index < agricultureDevelopmentItem.length; index++) {
      totalGstAmount += agricultureDevelopmentItem[index].taxableAmount ?? 0.0;
    }
    agridata.totalGstAmount = totalGstAmount;
  }
  void calculatebaseAmount() {
    double totalBaseAmount = 0.0;
    for (int index = 0; index < agricultureDevelopmentItem.length; index++) {
      totalBaseAmount += agricultureDevelopmentItem[index].baseAmount ?? 0.0;
    }
    agridata.totalBaseAmount = totalBaseAmount;
  }

  void calculatetotalAmount() {
    double totalAmount = 0.0;
    for (int index = 0; index < agricultureDevelopmentItem.length; index++) {
      totalAmount += agricultureDevelopmentItem[index].totalAmount ?? 0.0;
    }
    agridata.totalAmount = totalAmount;
  }

  String? selectedgrower;
  String? routeKm;
  String? supplier;
  String? suppliername;
  void setsupplier(String? suppli) async {
    supplier = suppli;
    agridata.nurserySupplier = supplier.toString();
    Logger().i(selectedplot);
    final selectedCaneData = supplierList
        .firstWhere((caneData) => caneData.name.toString() == suppli);
    Logger().i(selectedCaneData);
    suppliername = selectedCaneData.supplierName;
    agridata.supplierName = suppliername;
    notifyListeners();
  }

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
    routeKm = selectedCaneData.routeKm.toString();
    agridata.growerName = selectedVendorname;
    agridata.route = routeKm;
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

String? selectedVillage;

  void setSelectedVillage(String? village) async {
    selectedVillage = village;
    agridata.village = selectedVillage;

    farmerList=await AddAgriServices().fetchfarmerListwithfilter(agridata.village ?? "");
    notifyListeners();
  }


  void setSelectedgrowername(String? growername) async {
    selectedgrowername = growername;
    final selectedgrowerData = farmerList.firstWhere(
            (growerData) => growerData.supplierName == growername);
    Logger().i(selectedgrowerData);
    // Set th distance in the kmController
    farmercode=selectedgrowerData.name;
    agridata.vendorCode = selectedgrowerData.existingSupplierCode;
    agridata.growerName = selectedgrowername;
    Logger().i(selectedgrowername);
    canelistwithfilter = (await AddAgriServices().fetchcanelistwithfilter(agridata.season ?? "",agridata.village ?? "",farmercode ?? ""));
    notifyListeners();
  }

  void setSelectedsupplier(String? supplierName) {
    suppliername = supplierName;
    agridata.supplierName = suppliername;
    notifyListeners();
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
    selectedAreaInAcrs = double.tryParse(area ?? '');
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
    agridata.developmentArea = double.tryParse(surveyNumber ?? '');
    notifyListeners();
  }

  void setSelectedkm(String? km) {
    // kmController.value = kmController.value.copyWith(
    //   text: km ?? '',
    //   selection: TextSelection.collapsed(offset: (km ?? '').length),
    // );
    routeKm = km ?? '';
    agridata.route = routeKm;
    notifyListeners();
  }

  void setbaseltotal(String? km) {
    agridata.baselTotal = double.tryParse(km ?? "");
    notifyListeners();
  }

  void setpreeath(String? km) {
    agridata.preEarthingTotal = double.tryParse(km ?? "");
    notifyListeners();
  }

  void setearthtotal(String? km) {
    agridata.earthTotal = double.tryParse(km ?? "");
    notifyListeners();
  }

  void setrainytotal(String? km) {
    agridata.rainyTotal = double.tryParse(km ?? "");
    notifyListeners();
  }

  void setratoon1total(String? km) {
    agridata.ratoon1Total = double.tryParse(km ?? "");
    notifyListeners();
  }

  void setratoon2total(String? km) {
    agridata.ratoon2Total = double.tryParse(km ?? "");
    notifyListeners();
  }

  void settotal(String? km) {
    agridata.total = double.tryParse(km ?? "");
    notifyListeners();
  }

  /////validations/////
  String? validateSeason(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Season';
    }
    return null;
  }
  String? validatefarmer(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select farmer';
    }
    return null;
  }


  String? validatevillage(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Village';
    }
    return null;
  }

  String? validateSalesType(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Sales type';
    }

    return null;
  }

  String? validateSupplier(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Supplier';
    }
    return null;
  }

  String? validateSupplierName(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Supplier Name';
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
  late double weight = 0.0;
  late String itemTaxTemp = "";
  late double taxNumber = 0.0;
  late double fertilizerrate = 0.0;
  late double actualQty = 0.0;
  late String itemCode2 = "";
  late String itemName2 = "";
  late double total = 0.0;
  late double rate = 0.0;
  late double amount = 0.0;

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
      agricultureDevelopmentItem[index].weightPerUnit=weight;
      agricultureDevelopmentItem[index].itemTaxTemp=itemTaxTemp;
      agricultureDevelopmentItem[index].taxNumber=taxNumber;
      agricultureDevelopmentItem[index].actualQty=actualQty;
      agricultureDevelopmentItem[index].rate=fertilizerrate;
      notifyListeners();
      return;
    }
    agricultureDevelopmentItem.add(AgricultureDevelopmentItem(
      itemCode: itemCode,
      itemName: itemName,
      weightPerUnit: weight,
      itemTaxTemp: itemTaxTemp,
      taxNumber: taxNumber,
      actualQty: actualQty,
      rate: rate
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
      rate = agricultureDevelopmentItem2[index].rate!;
      amount = agricultureDevelopmentItem2[index].amount!;
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
      agricultureDevelopmentItem2[index].rate = rate;
      agricultureDevelopmentItem2[index].amount = amount;
      notifyListeners();
      return;
    }
    agricultureDevelopmentItem2.add(AgricultureDevelopmentItem2(
        itemCode: itemCode2,
        itemName: itemName2,
        qty: total,
        rate: rate,
        amount: amount));
    notifyListeners();
  }

  void setSelectedAgri2(String? agri) async {
    Logger().i(agri);
    itemCode2 = agri ?? "";
    final bankData = itemList.firstWhere((bank) => bank.itemCode == agri);
    itemName2 = bankData.itemName ?? "";
    rate = bankData.standardRate ?? 0.0;
    notifyListeners();
  }
  String? suretyvillage;
  String? suretyexistingcode;

  void setValuesTograntorVaribles(int index) {
    if (index != -1) {
      if (index >= grantor.length) {
        return;
      }
      // Reset all roles to false
      suretyCode = grantor[index].suretyCode!;
      suretyvillage=grantor[index].village;
      suretyExistingCode = grantor[index].suretyExistingCode!;
      suretyname = grantor[index].suretyName!;
    }
    notifyListeners();
  }

  void resetBankVariables() {
    suretyExistingCode = "";
    suretyname = "";
    suretyvillage ="";
  }

  void submitBankAccount(int index) {
    if (index != -1) {
      grantor[index].village = suretyvillage;
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
      village: suretyvillage
    ));
    notifyListeners();
  }

  void setSelectedAgri(String? agri) async {
    Logger().i(agri);
    itemCode = agri ?? "";
    final bankData = fertilizeritemlist.firstWhere((bank) => bank.itemCode == agri);
    itemName = bankData.itemName ?? "";
    weight=bankData.weightPerUnit?? 0.0;
    itemTaxTemp=bankData.itemTaxTemp ?? "";
    taxNumber=bankData.taxNumber ?? 0.0;
    actualQty=bankData.actualQty ?? 0.0;
    rate=bankData.rate ?? 0.0;
    notifyListeners();
  }

  void setSelectedtotal(double? sales) async {
    total = sales ?? 0.0;
    amount = rate * total;
    notifyListeners();
  }


  void setSelectedgrantorvillage(String? village) async {
    Logger().i(village);
    final selectedRouteData =
    villagelist.firstWhere((bankData) => bankData.name == village);
    Logger().i(selectedRouteData);
    suretyvillage = selectedRouteData.name ?? "";
    farmerList=await AddAgriServices().fetchfarmerListwithfilter(suretyvillage ?? "");
    notifyListeners();
  }

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
