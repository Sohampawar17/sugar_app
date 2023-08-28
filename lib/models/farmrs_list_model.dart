class FarmersListModel {
  String? supplierName;
  String? village;
  String? name;
  String? workflowState;
  String? circleOffice;
  String? existingSupplierCode;

  FarmersListModel(
      {this.supplierName,
      this.village,
      this.name,
      this.workflowState,
      this.circleOffice,
      this.existingSupplierCode});

  FarmersListModel.fromJson(Map<String, dynamic> json) {
    supplierName = json['supplier_name'];
    village = json['village'];
    name = json['name'];
    workflowState = json['workflow_state'];
    circleOffice = json['circle_office'];
    existingSupplierCode = json['existing_supplier_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplier_name'] = this.supplierName;
    data['village'] = this.village;
    data['name'] = this.name;
    data['workflow_state'] = this.workflowState;
    data['circle_office'] = this.circleOffice;
    data['existing_supplier_code'] = this.existingSupplierCode;
    return data;
  }
}
