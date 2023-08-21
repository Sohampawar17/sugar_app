class WaterSupplierList {
  String? name;
  String? supplierName;

  WaterSupplierList({this.name, this.supplierName});

  WaterSupplierList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    supplierName = json['supplier_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['supplier_name'] = this.supplierName;
    return data;
  }
}