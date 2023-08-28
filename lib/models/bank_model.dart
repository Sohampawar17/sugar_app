class BankMaster {
  String? bankAndBranch;
  String? branch;
  String? ifscCode;

  BankMaster({this.bankAndBranch, this.branch, this.ifscCode});

  BankMaster.fromJson(Map<String, dynamic> json) {
    bankAndBranch = json['bank_and_branch'];
    branch = json['branch'];
    ifscCode = json['ifsc_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_and_branch'] = this.bankAndBranch;
    data['branch'] = this.branch;
    data['ifsc_code'] = this.ifscCode;
    return data;
  }
}
