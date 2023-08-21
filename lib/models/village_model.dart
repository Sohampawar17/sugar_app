class villagemodel {
  String? name;
  String? circleOffice;

  villagemodel({this.name, this.circleOffice});

  villagemodel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    circleOffice = json['circle_office'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['circle_office'] = this.circleOffice;
    return data;
  }
}
