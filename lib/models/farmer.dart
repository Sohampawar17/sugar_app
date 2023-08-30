class Farmer {
  String? name;
  String? owner;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? workflowState;
  String? namingSeries;
  String? supplierName;
  String? supplierType;
  String? branch;
  String? aadhaarNumber;
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
  String? consentLetter;
  int? isInternalSupplier;
  String? language;
  int? allowPurchaseInvoiceCreationWithoutPurchaseOrder;
  int? allowPurchaseInvoiceCreationWithoutPurchaseReceipt;
  int? isFrozen;
  int? disabled;
  int? warnRfqs;
  int? warnPos;
  int? preventRfqs;
  int? preventPos;
  int? onHold;
  String? holdType;
  String? doctype;
  List<BankDetails>? bankDetails;

  Farmer(
      {this.name,
      this.owner,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.workflowState,
      this.namingSeries,
      this.supplierName,
      this.supplierType,
      this.branch,
      this.aadhaarNumber,
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
      this.consentLetter,
      this.isInternalSupplier,
      this.language,
      this.allowPurchaseInvoiceCreationWithoutPurchaseOrder,
      this.allowPurchaseInvoiceCreationWithoutPurchaseReceipt,
      this.isFrozen,
      this.disabled,
      this.warnRfqs,
      this.warnPos,
      this.preventRfqs,
      this.preventPos,
      this.onHold,
      this.holdType,
      this.doctype,
      this.bankDetails});

  Farmer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    workflowState = json['workflow_state'];
    namingSeries = json['naming_series'];
    supplierName = json['supplier_name'];
    supplierType = json['supplier_type'];
    branch = json['branch'];
    aadhaarNumber = json['aadhaar_number'];
    mobileNumber = json['mobile_number'];
    dateOfBirth = json['date_of_birth'];
    existingSupplierCode = json['existing_supplier_code'];
    gender = json['gender'];
    age = json['age'];
    country = json['country'];
    supplierGroup = json['supplier_group'];
    isTransporter = json['is_transporter'];
    isHarvester = json['is_harvester'];
    isFarmer = json['is_farmer'];
    isMember = json['is_member'];
    village = json['village'];
    circleOffice = json['circle_office'];
    taluka = json['taluka'];
    state = json['state'];
    aadhaarCard = json['aadhaar_card'];
    consentLetter = json['consent_letter'];
    isInternalSupplier = json['is_internal_supplier'];
    language = json['language'];
    allowPurchaseInvoiceCreationWithoutPurchaseOrder =
        json['allow_purchase_invoice_creation_without_purchase_order'];
    allowPurchaseInvoiceCreationWithoutPurchaseReceipt =
        json['allow_purchase_invoice_creation_without_purchase_receipt'];
    isFrozen = json['is_frozen'];
    disabled = json['disabled'];
    warnRfqs = json['warn_rfqs'];
    warnPos = json['warn_pos'];
    preventRfqs = json['prevent_rfqs'];
    preventPos = json['prevent_pos'];
    onHold = json['on_hold'];
    holdType = json['hold_type'];
    doctype = json['doctype'];
    if (json['bank_details'] != null) {
      bankDetails = <BankDetails>[];
      json['bank_details'].forEach((v) {
        bankDetails!.add(new BankDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['modified_by'] = this.modifiedBy;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['workflow_state'] = this.workflowState;
    data['naming_series'] = this.namingSeries;
    data['supplier_name'] = this.supplierName;
    data['supplier_type'] = this.supplierType;
    data['branch'] = this.branch;
    data['aadhaar_number'] = this.aadhaarNumber;
    data['mobile_number'] = this.mobileNumber;
    data['date_of_birth'] = this.dateOfBirth;
    data['existing_supplier_code'] = this.existingSupplierCode;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['country'] = this.country;
    data['supplier_group'] = this.supplierGroup;
    data['is_transporter'] = this.isTransporter;
    data['is_harvester'] = this.isHarvester;
    data['is_farmer'] = this.isFarmer;
    data['is_member'] = this.isMember;
    data['village'] = this.village;
    data['circle_office'] = this.circleOffice;
    data['taluka'] = this.taluka;
    data['state'] = this.state;
    data['aadhaar_card'] = this.aadhaarCard;
    data['consent_letter'] = this.consentLetter;
    data['is_internal_supplier'] = this.isInternalSupplier;
    data['language'] = this.language;
    data['allow_purchase_invoice_creation_without_purchase_order'] =
        this.allowPurchaseInvoiceCreationWithoutPurchaseOrder;
    data['allow_purchase_invoice_creation_without_purchase_receipt'] =
        this.allowPurchaseInvoiceCreationWithoutPurchaseReceipt;
    data['is_frozen'] = this.isFrozen;
    data['disabled'] = this.disabled;
    data['warn_rfqs'] = this.warnRfqs;
    data['warn_pos'] = this.warnPos;
    data['prevent_rfqs'] = this.preventRfqs;
    data['prevent_pos'] = this.preventPos;
    data['on_hold'] = this.onHold;
    data['hold_type'] = this.holdType;
    data['doctype'] = this.doctype;
    if (this.bankDetails != null) {
      data['bank_details'] = this.bankDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankDetails {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  int? farmer;
  int? harvester;
  int? transporter;
  String? bankName;
  String? branchifscCode;
  String? accountNumber;
  String? status;
  String? isActive;
  String? bankAndBranch;
  String? bankPassbook;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  BankDetails(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.farmer,
      this.harvester,
      this.transporter,
      this.bankName,
      this.branchifscCode,
      this.accountNumber,
      this.status,
      this.isActive,
      this.bankAndBranch,
      this.bankPassbook,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.doctype});

  BankDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    farmer = json['farmer'];
    harvester = json['harvester'];
    transporter = json['transporter'];
    bankName = json['bank_name'];
    branchifscCode = json['branchifsc_code'];
    accountNumber = json['account_number'];
    status = json['status'];
    isActive = json['is_active'];
    bankAndBranch = json['bank_and_branch'];
    bankPassbook = json['bank_passbook'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['farmer'] = this.farmer;
    data['harvester'] = this.harvester;
    data['transporter'] = this.transporter;
    data['bank_name'] = this.bankName;
    data['branchifsc_code'] = this.branchifscCode;
    data['account_number'] = this.accountNumber;
    data['status'] = this.status;
    data['is_active'] = this.isActive;
    data['bank_and_branch'] = this.bankAndBranch;
    data['bank_passbook'] = this.bankPassbook;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['doctype'] = this.doctype;
    return data;
  }
}
