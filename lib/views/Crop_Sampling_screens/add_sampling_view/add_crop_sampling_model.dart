import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/models/sampling_formula.dart';
import 'package:sugar_mill_app/services/add_crop_sampling_service.dart';
import '../../../constants.dart';
import '../../../models/agri_cane_model.dart';
import '../../../models/crop_sampling.dart';
import '../../../services/add_agri_services.dart';

class AddCropSmaplingModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  CropSampling cropsamplingdata = CropSampling();
  samplingformula samplingformauladata = samplingformula();
  List<AgriCane> plotList = [];
  late String formulaList;
  String? selectedPlot;

  String? selectedfarcode;
  bool isEdit = false;
  List<String> seasonlist = [""];
  initialise(BuildContext context, String samplingId) async {
    setBusy(true);
    plotList = (await AddCropSmaplingServices().fetchcanelistwithfilter());
    seasonlist = await AddAgriServices().fetchSeason();
    samplingformauladata =
        await AddCropSmaplingServices().fetchsamplingFormula() ??
            samplingformula();
    Logger().i(samplingformauladata);
    if (samplingId != "") {
      isEdit = true;
      cropsamplingdata =
          await AddCropSmaplingServices().getCropSampling(samplingId) ??
              CropSampling();
      brixbottmAreaController.text = cropsamplingdata.brixBottom.toString();
      brixmiddleController.text = cropsamplingdata.brixMiddle.toString();
      brixtopController.text = cropsamplingdata.brixTop.toString();
      noofpairsController.text = cropsamplingdata.noOfPairs.toString();
      for (AgriCane i in plotList) {
        if (i.growerCode == cropsamplingdata.growerCode) {
          selectedfarcode = i.vendorCode;
          notifyListeners();
        }
      }
      notifyListeners();
    }
    if (seasonlist.isEmpty) {
      logout(context);
    }
    if (plotList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,

          content: Text(
            'There is No plot available',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          duration: Duration(seconds: 3), // Adjust the duration as needed
        ),
      );
    }
    setBusy(false);
  }

  void onSavePressed(BuildContext context) async {
    setBusy(true);
    if (formKey.currentState!.validate()) {
      bool res = false;
      Logger().i(cropsamplingdata.toJson().toString());
      if (isEdit == true) {
        res = await AddCropSmaplingServices()
            .updateCropSampling(cropsamplingdata);
        if (res) {
          if (context.mounted) {
            setBusy(false);
            setBusy(false);
            Navigator.pop(context);
          }
        }
      } else {
        res = await AddCropSmaplingServices().addCropsampling(cropsamplingdata);
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

  String? selectedplot;
  String? selectedVendorname;
  String? selectedplant;
  String? selectedvillage;
  String? selectedcropvariety;
  String? selectedcroptype;
  String? selectedAreaInAcrs;
  String? selectedvendor;
  String? selectedseason;

  void setSelectedplot(String? plot) {
    selectedPlot = plot;
    cropsamplingdata.id = selectedPlot;
    final selectedCaneData =
        plotList.firstWhere((caneData) => caneData.name.toString() == plot);
    Logger().i(selectedCaneData);
    selectedVendorname = selectedCaneData.growerName;
    selectedplant = selectedCaneData.plantName;
    selectedvillage = selectedCaneData.area;
    selectedcropvariety = selectedCaneData.cropVariety;
    selectedcroptype = selectedCaneData.cropType;
    selectedAreaInAcrs = selectedCaneData.soilType;
    selectedvendor = selectedCaneData.vendorCode;
    selectedfarcode = selectedvendor;
    selectedseason = selectedCaneData.season;
    cropsamplingdata.growerName = selectedVendorname;
    cropsamplingdata.area = selectedvillage;
    cropsamplingdata.cropVariety = selectedcropvariety;
    cropsamplingdata.cropType = selectedcroptype;
    cropsamplingdata.soilType = selectedAreaInAcrs;
    cropsamplingdata.growerCode = selectedvendor;
    cropsamplingdata.season = selectedseason;
    cropsamplingdata.plantName = selectedplant;
    notifyListeners();
  }

  TextEditingController brixbottmAreaController = TextEditingController();
  TextEditingController brixmiddleController = TextEditingController();
  TextEditingController brixtopController = TextEditingController();
  TextEditingController noofpairsController = TextEditingController();

  void setSelectedbrixbottm(String? brixbottm) {
    brixbottmAreaController.value = brixbottmAreaController.value.copyWith(
      text: brixbottm ?? '',
      selection: TextSelection.collapsed(offset: (brixbottm ?? '').length),
    );
    cropsamplingdata.brixBottom = double.parse(brixbottm ?? '');
    notifyListeners();
  }

  void setSelectedbrixmiddle(String? brixmiddle) {
    brixmiddleController.value = brixmiddleController.value.copyWith(
      text: brixmiddle ?? '',
      selection: TextSelection.collapsed(offset: (brixmiddle ?? '').length),
    );
    cropsamplingdata.brixMiddle = double.parse(brixmiddle ?? '');
    notifyListeners();
  }

  void setSelectedbrixtop(String? brixtop) {
    brixtopController.value = brixtopController.value.copyWith(
      text: brixtop ?? '',
      selection: TextSelection.collapsed(offset: (brixtop ?? '').length),
    );
    cropsamplingdata.brixTop = double.parse(brixtop ?? '');
    notifyListeners();
  }

  void setSelectednoofpairs(String? noofpairs) {
    noofpairsController.value = noofpairsController.value.copyWith(
      text: noofpairs ?? '',
      selection: TextSelection.collapsed(offset: (noofpairs ?? '').length),
    );
    cropsamplingdata.noOfPairs = int.tryParse(noofpairs ?? "");
    notifyListeners();
  }

  void setSelectedVendor(String? growerCode) {
    Logger().i(growerCode);
    selectedvendor = growerCode;
    notifyListeners();
    cropsamplingdata.growerCode = selectedvendor;
    notifyListeners();
  }

  void setSelectedfarmername(String? growerName) {
    selectedVendorname = growerName;
    cropsamplingdata.growerName = selectedVendorname;
    notifyListeners();
  }

  void setSelectedPlantName(String? plantName) {
    selectedplant = plantName;
    cropsamplingdata.plantName = selectedplant;
    notifyListeners();
  }

  void setSelectedvillage(String? area) {
    selectedvillage = area;
    cropsamplingdata.area = selectedvillage;
    notifyListeners();
  }

  void setSelectedseason(String? season) {
    selectedseason = season;
    cropsamplingdata.season = selectedseason;
    notifyListeners();
  }

  void setSelectedcropvariety(String? cropVariety) {
    selectedcropvariety = cropVariety;
    cropsamplingdata.cropVariety = selectedcropvariety;
    notifyListeners();
  }

  void setSelectedcroptype(String? cropType) {
    selectedcroptype = cropType;
    cropsamplingdata.cropType = selectedcroptype;
    notifyListeners();
  }

  void setSelectedSoilType(String? soilType) {
    selectedAreaInAcrs = soilType;
    cropsamplingdata.soilType = selectedAreaInAcrs;
    notifyListeners();
  }

  ////validators////
  String? validateplotNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Plot Number';
    }
    return null;
  }

  String? validatebrixbottom(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Brix Bottom';
    }
    return null;
  }

  String? validatebrixtop(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Brix Top';
    }
    return null;
  }

  String? validatebrixMiddle(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Brix Middle';
    }
    return null;
  }

  String? validatenoofpairs(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select no. of pairs';
    }
    return null;
  }
}
