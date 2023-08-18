class TripSheetSearch {
  int? name;
  String? farmerName;
  String? fieldVillage;
  String? transporterName;
  String? circleOffice;
  String? season;

  TripSheetSearch(
      {this.name,
      this.farmerName,
      this.fieldVillage,
      this.transporterName,
      this.circleOffice,
      this.season});

  TripSheetSearch.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    farmerName = json['farmer_name'];
    fieldVillage = json['field_village'];
    transporterName = json['transporter_name'];
    circleOffice = json['circle_office'];
    season = json['season'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['farmer_name'] = this.farmerName;
    data['field_village'] = this.fieldVillage;
    data['transporter_name'] = this.transporterName;
    data['circle_office'] = this.circleOffice;
    data['season'] = this.season;
    return data;
  }
}
