class FarmersListModel {
  final String? supplierName;
  final String? village;
  final String? name;
  final String? workflowState;
  final String? circleOffice;

  FarmersListModel({
    this.supplierName,
    this.village,
    this.name,
    this.workflowState,
    this.circleOffice,
  });

  FarmersListModel.fromJson(Map<String, dynamic> json)
      : supplierName = json['supplier_name'] as String?,
        village = json['village'] as String?,
        name = json['name'] as String?,
        workflowState = json['workflow_state'] as String?,
        circleOffice = json['circle_office'] as String?;

  Map<String, dynamic> toJson() => {
        'supplier_name': supplierName,
        'village': village,
        'name': name,
        'workflow_state': workflowState,
        'circle_office': circleOffice
      };
}
