import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/models/Agri.dart';

import '../../../models/agri_cane_model.dart';
import '../../../services/add_agri_services.dart';

class AgriViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  Agri agridata = Agri();
  List<String> seasonlist = [""];
  List<AgriCane> canelistwithfilter = [];
  String? selectedplot;
  initialise(BuildContext context) async {
    setBusy(true);
    seasonlist = await AddAgriServices().fetchSeason();
    canelistwithfilter = await AddAgriServices().fetchcanelistwithfilter();
    setBusy(false);
  }

  void setSelectedSeason(String? season) {
    agridata.season = season;
  }

  void setPlotnumber(String? caneRegistrationId) {
    selectedplot = caneRegistrationId;
    agridata.caneRegistrationId = selectedplot;
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
}
