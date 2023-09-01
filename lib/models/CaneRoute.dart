class caneRoute {
  String? route;
  double? distanceKm;
  String? name;
  String? village;
  String? circleOffice;
  String? taluka;

  caneRoute(
      {this.route,
      this.distanceKm,
      this.name,
      this.village,
      this.circleOffice,
      this.taluka});

  caneRoute.fromJson(Map<String, dynamic> json) {
    route = json['route'];
    distanceKm = json['distance_km'];
    name = json['name'];
    village = json['village'];
    circleOffice = json['circle_office'];
    taluka = json['taluka'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['route'] = this.route;
    data['distance_km'] = this.distanceKm;
    data['name'] = this.name;
    data['village'] = this.village;
    data['circle_office'] = this.circleOffice;
    data['taluka'] = this.taluka;
    return data;
  }
}
