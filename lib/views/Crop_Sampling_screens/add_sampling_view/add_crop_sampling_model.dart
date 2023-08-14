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
    plotList = await AddCropSmaplingServices().fetchcanelistwithfilter();
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

  void setSelectedplot(String? plot) {
    selectedPlot = plot;
    cropsamplingdata.id = selectedPlot;
  }

  void setSelectedbrixbottm(String? brixbottm) {
    cropsamplingdata.brixBottom = double.tryParse(brixbottm ?? "");
  }

  void setSelectedbrixmiddle(String? brixmiddle) {
    cropsamplingdata.brixMiddle = double.tryParse(brixmiddle ?? "");
  }

  void setSelectedbrixtop(String? brixtop) {
    cropsamplingdata.brixTop = double.tryParse(brixtop ?? "");
  }

  void setSelectednoofpairs(String? noofpairs) {
    cropsamplingdata.noOfPairs = int.tryParse(noofpairs ?? "");
  }

  ////validators////
  String? validateplotNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'please select Plot Number';
    }
    return null;
  }
}
