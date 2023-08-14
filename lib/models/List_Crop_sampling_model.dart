class ListSampling {
  String? id;
  String? season;
  String? plantationStatus;
  String? plantName;
  String? formNumber;
  String? name;

  ListSampling(
      {this.id,
      this.season,
      this.plantationStatus,
      this.plantName,
      this.formNumber,
      this.name});

  ListSampling.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    season = json['season'];
    plantationStatus = json['plantation_status'];
    plantName = json['plant_name'];
    formNumber = json['form_number'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['season'] = this.season;
    data['plantation_status'] = this.plantationStatus;
    data['plant_name'] = this.plantName;
    data['form_number'] = this.formNumber;
    data['name'] = this.name;
    return data;
  }
}
