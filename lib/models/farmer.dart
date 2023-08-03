///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class FarmerDataBankDetails {
/*
{
  "farmer": 1,
  "harvester": 0,
  "transporter": 0,
  "bank_name": "161930",
  "branchifsc_code": "h5785jjjtj",
  "account_number": "576576567575",
  "parent": "FA-1",
  "parentfield": "bank_details",
  "parenttype": "Farmer List",
  "doctype": "Bank Details"
} 
*/

  int? farmer;
  int? harvester;
  int? transporter;
  String? bankName;
  String? branchifscCode;
  String? accountNumber;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  FarmerDataBankDetails({
    this.farmer,
    this.harvester,
    this.transporter,
    this.bankName,
    this.branchifscCode,
    this.accountNumber,
    this.parent,
    this.parentfield,
    this.parenttype,
    this.doctype,
  });
  FarmerDataBankDetails.fromJson(Map<String, dynamic> json) {
    farmer = json['farmer']?.toInt();
    harvester = json['harvester']?.toInt();
    transporter = json['transporter']?.toInt();
    bankName = json['bank_name']?.toString();
    branchifscCode = json['branchifsc_code']?.toString();
    accountNumber = json['account_number']?.toString();
    parent = json['parent']?.toString();
    parentfield = json['parentfield']?.toString();
    parenttype = json['parenttype']?.toString();
    doctype = json['doctype']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['farmer'] = farmer;
    data['harvester'] = harvester;
    data['transporter'] = transporter;
    data['bank_name'] = bankName;
    data['branchifsc_code'] = branchifscCode;
    data['account_number'] = accountNumber;
    data['parent'] = parent;
    data['parentfield'] = parentfield;
    data['parenttype'] = parenttype;
    data['doctype'] = doctype;
    return data;
  }
}

class FarmerData {
/*
{
  "supplier_name": "ABHAY PURANDAR KHOT ",
  "supplier_type": "Individual",
  "branch": "Bedkihal",
  "aadhaar_number": "157855154445",
  "pan_number": "df4geh454b",
  "mobile_number": "4759456232",
  "date_of_birth": "1970-05-06",
  "existing_supplier_code": "2",
  "gender": "Male",
  "age": "53",
  "country": "India",
  "supplier_group": "CANE",
  "is_transporter": 0,
  "is_harvester": 0,
  "is_farmer": 1,
  "is_member": 0,
  "village": "BEDKIHAL",
  "circle_office": "BEDKIHAL",
  "taluka": "CHIKODI",
  "state": "Karnataka",
  "aadhaar_card": "/files/quantbit-client.py",
  "bank_passbook": "/files/final_rfid.py",
  "pan_card": "/files/quantbit-client.py",
  "consent_letter": "/files/quantbit-client.py",
  "bank_details": [
    {
      "farmer": 1,
      "harvester": 0,
      "transporter": 0,
      "bank_name": "161930",
      "branchifsc_code": "h5785jjjtj",
      "account_number": "576576567575",
      "parent": "FA-1",
      "parentfield": "bank_details",
      "parenttype": "Farmer List",
      "doctype": "Bank Details"
    }
  ]
} 
*/

  String? supplierName;
  String? supplierType;
  String? branch;
  String? aadhaarNumber;
  String? panNumber;
  String? mobileNumber;
  String? dateOfBirth;
  String? existingSupplierCode;
  String? gender;
  String? age;
  String? country;
  String? supplierGroup;
  int? isTransporter;
  int? isHarvester;
  int? isFarmer;
  int? isMember;
  String? village;
  String? circleOffice;
  String? taluka;
  String? state;
  String? aadhaarCard;
  String? bankPassbook;
  String? panCard;
  String? consentLetter;
  List<FarmerDataBankDetails?>? bankDetails;

  FarmerData({
    this.supplierName,
    this.supplierType,
    this.branch,
    this.aadhaarNumber,
    this.panNumber,
    this.mobileNumber,
    this.dateOfBirth,
    this.existingSupplierCode,
    this.gender,
    this.age,
    this.country,
    this.supplierGroup,
    this.isTransporter,
    this.isHarvester,
    this.isFarmer,
    this.isMember,
    this.village,
    this.circleOffice,
    this.taluka,
    this.state,
    this.aadhaarCard,
    this.bankPassbook,
    this.panCard,
    this.consentLetter,
    this.bankDetails,
  });
  FarmerData.fromJson(Map<String, dynamic> json) {
    supplierName = json['supplier_name']?.toString();
    supplierType = json['supplier_type']?.toString();
    branch = json['branch']?.toString();
    aadhaarNumber = json['aadhaar_number']?.toString();
    panNumber = json['pan_number']?.toString();
    mobileNumber = json['mobile_number']?.toString();
    dateOfBirth = json['date_of_birth']?.toString();
    existingSupplierCode = json['existing_supplier_code']?.toString();
    gender = json['gender']?.toString();
    age = json['age']?.toString();
    country = json['country']?.toString();
    supplierGroup = json['supplier_group']?.toString();
    isTransporter = json['is_transporter']?.toInt();
    isHarvester = json['is_harvester']?.toInt();
    isFarmer = json['is_farmer']?.toInt();
    isMember = json['is_member']?.toInt();
    village = json['village']?.toString();
    circleOffice = json['circle_office']?.toString();
    taluka = json['taluka']?.toString();
    state = json['state']?.toString();
    aadhaarCard = json['aadhaar_card']?.toString();
    bankPassbook = json['bank_passbook']?.toString();
    panCard = json['pan_card']?.toString();
    consentLetter = json['consent_letter']?.toString();
    if (json['bank_details'] != null) {
      final v = json['bank_details'];
      final arr0 = <FarmerDataBankDetails>[];
      v.forEach((v) {
        arr0.add(FarmerDataBankDetails.fromJson(v));
      });
      bankDetails = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['supplier_name'] = supplierName;
    data['supplier_type'] = supplierType;
    data['branch'] = branch;
    data['aadhaar_number'] = aadhaarNumber;
    data['pan_number'] = panNumber;
    data['mobile_number'] = mobileNumber;
    data['date_of_birth'] = dateOfBirth;
    // data['existing_supplier_code'] = existingSupplierCode;
    data['gender'] = gender;
    data['age'] = age;
    data['country'] = country;
    data['supplier_group'] = supplierGroup;
    data['is_transporter'] = isTransporter;
    data['is_harvester'] = isHarvester;
    data['is_farmer'] = isFarmer;
    data['is_member'] = isMember;
    data['village'] = village;
    data['circle_office'] = circleOffice;
    data['taluka'] = taluka;
    data['state'] = state;
    data['aadhaar_card'] = aadhaarCard;
    data['bank_passbook'] = bankPassbook;
    data['pan_card'] = panCard;
    data['consent_letter'] = consentLetter;
    if (bankDetails != null) {
      final v = bankDetails;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['bank_details'] = arr0;
    }
    return data;
  }
}

class Farmer {
/*
{
  "data": {
    "supplier_name": "ABHAY PURANDAR KHOT ",
    "supplier_type": "Individual",
    "branch": "Bedkihal",
    "aadhaar_number": "157855154445",
    "pan_number": "df4geh454b",
    "mobile_number": "4759456232",
    "date_of_birth": "1970-05-06",
    "existing_supplier_code": "2",
    "gender": "Male",
    "age": "53",
    "country": "India",
    "supplier_group": "CANE",
    "is_transporter": 0,
    "is_harvester": 0,
    "is_farmer": 1,
    "is_member": 0,
    "village": "BEDKIHAL",
    "circle_office": "BEDKIHAL",
    "taluka": "CHIKODI",
    "state": "Karnataka",
    "aadhaar_card": "/files/quantbit-client.py",
    "bank_passbook": "/files/final_rfid.py",
    "pan_card": "/files/quantbit-client.py",
    "consent_letter": "/files/quantbit-client.py",
    "bank_details": [
      {
        "farmer": 1,
        "harvester": 0,
        "transporter": 0,
        "bank_name": "161930",
        "branchifsc_code": "h5785jjjtj",
        "account_number": "576576567575",
        "parent": "FA-1",
        "parentfield": "bank_details",
        "parenttype": "Farmer List",
        "doctype": "Bank Details"
      }
    ]
  }
} 
*/

  FarmerData? data;

  Farmer({
    this.data,
  });
  Farmer.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null) ? FarmerData.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}
