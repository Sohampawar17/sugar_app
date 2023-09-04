class DosetypeModel {
  String? itemCode;
  String? itemName;
  String? itemgroup;
  String? name;
  double? baselqty;
  double? preearthqty;
  double? earthingqty;
  double? rainyqty;
  double? ratoon1qty;
  double? ratoon2qty;

  DosetypeModel(
      {this.itemCode,
      this.itemName,
      this.itemgroup,
      this.name,
      this.baselqty,
      this.preearthqty,
      this.earthingqty,
      this.rainyqty,
      this.ratoon1qty,
      this.ratoon2qty});

  DosetypeModel.fromJson(Map<String, dynamic> json) {
    itemCode = json['ItemCode'];
    itemName = json['ItemName'];
    itemgroup = json['Itemgroup'];
    name = json['name'];
    baselqty = json['Baselqty'];
    preearthqty = json['preearthqty'];
    earthingqty = json['earthingqty'];
    rainyqty = json['Rainyqty'];
    ratoon1qty = json['Ratoon1qty'];
    ratoon2qty = json['Ratoon2qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemCode'] = this.itemCode;
    data['ItemName'] = this.itemName;
    data['Itemgroup'] = this.itemgroup;
    data['name'] = this.name;
    data['Baselqty'] = this.baselqty;
    data['preearthqty'] = this.preearthqty;
    data['earthingqty'] = this.earthingqty;
    data['Rainyqty'] = this.rainyqty;
    data['Ratoon1qty'] = this.ratoon1qty;
    data['Ratoon2qty'] = this.ratoon2qty;
    return data;
  }
}
