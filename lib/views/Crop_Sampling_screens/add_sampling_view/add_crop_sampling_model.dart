import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/services/add_crop_sampling_service.dart';

import '../../../models/Crop_Sampling.dart';
import '../../../models/agri_cane_model.dart';

class AddCropSmaplingModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  CropSampling cropsamplingdata = CropSampling();
  List<AgriCane> plotList = [];
  String? selectedPlot;

  initialise(BuildContext context) async {
    plotList = (await AddCropSmaplingServices().fetchcanelistwithfilter());
    cropsamplingdata.brixBottom = 0.0; // Set your desired initial value
    cropsamplingdata.brixMiddle = 0.0; // Set your desired initial value
    cropsamplingdata.brixTop = 0.0; // Set your desired initial value
    cropsamplingdata.noOfPairs = 0; // Set your desired initial value
  }

  void onSavePressed(BuildContext context) async {
    setBusy(true);
    if (formKey.currentState!.validate()) {
      bool res = false;
      Logger().i(cropsamplingdata.toJson().toString());
      res = await AddCropSmaplingServices().addCropsampling(cropsamplingdata);
      if (res) {
        if (context.mounted) {
          setBusy(false);
          setBusy(false);
          Navigator.pop(context);
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
    cropsamplingdata.growerName = selectedVendorname;
    cropsamplingdata.area = selectedvillage;
    cropsamplingdata.cropVariety = selectedcropvariety;
    cropsamplingdata.cropType = selectedcroptype;
    cropsamplingdata.soilType = selectedAreaInAcrs;
    cropsamplingdata.growerCode = selectedvendor;
    cropsamplingdata.plantName = selectedplant;
    notifyListeners();
  }

  void setSelectedbrixbottm(String? brixbottm) {
    cropsamplingdata.brixBottom = double.tryParse(brixbottm ?? "");
    notifyListeners();
  }

  void setSelectedbrixmiddle(String? brixmiddle) {
    cropsamplingdata.brixMiddle = double.tryParse(brixmiddle ?? "");
    notifyListeners();
  }

  void setSelectedbrixtop(String? brixtop) {
    cropsamplingdata.brixTop = double.tryParse(brixtop ?? "");
    notifyListeners();
  }

  void setSelectednoofpairs(String? noofpairs) {
    cropsamplingdata.noOfPairs = int.tryParse(noofpairs ?? "");
    notifyListeners();
  }

  void setSelectedVendor(String? growerCode) {
    selectedvendor = growerCode;
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

  String? validatenoofpairs(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select no. of pairs';
    }
    return null;
  }
}
