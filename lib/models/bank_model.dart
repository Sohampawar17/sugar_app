class BankMaster {
  String? bankName;
  String? branch;
  String? ifscCode;

  BankMaster({this.bankName, this.branch, this.ifscCode});

  BankMaster.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    branch = json['branch'];
    ifscCode = json['ifsc_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_name'] = this.bankName;
    data['branch'] = this.branch;
    data['ifsc_code'] = this.ifscCode;
    return data;
  }
}
