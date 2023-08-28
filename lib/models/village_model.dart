class villagemodel {
  String? name;
  String? circleOffice;
  String? taluka;

  villagemodel({this.name, this.circleOffice, this.taluka});

  villagemodel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    circleOffice = json['circle_office'];
    taluka = json['taluka'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['circle_office'] = this.circleOffice;
    data['taluka'] = this.taluka;
    return data;
  }
}
