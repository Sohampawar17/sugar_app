import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/services/add_crop_sampling_service.dart';

import '../../../models/Crop_Sampling.dart';
import '../../../models/agri_cane_model.dart';
import '../../../router.router.dart';

class AddCropSmaplingModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  CropSampling cropsamplingdata = CropSampling();
  List<AgriCane> plotList = [];
  String? selectedPlot;
  late String samplingId;
  bool isEdit = false;

  initialise(BuildContext context, String samplingId) async {
    plotList = (await AddCropSmaplingServices().fetchcanelistwithfilter());
    if (samplingId != "") {
      isEdit = true;

      cropsamplingdata =
          await AddCropSmaplingServices().getCropSampling(samplingId) ??
              CropSampling();
      brixbottmAreaController.text = cropsamplingdata.brixBottom.toString();
      brixmiddleController.text = cropsamplingdata.brixMiddle.toString();
      brixtopController.text = cropsamplingdata.brixTop.toString();
      noofpairsController.text = cropsamplingdata.noOfPairs.toString();
      notifyListeners();
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

  String? validatenoofpairs(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select no. of pairs';
    }
    return null;
  }
}
