class Farmer {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? workflowState;
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
  String? pinCode;
  String? state;
  String? aadhaarCard;
  String? bankPassbook;
  String? panCard;
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
  List<dynamic>? accounts;
  List<dynamic>? companies;
  List<BankDetails>? bankDetails;

  Farmer({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.docstatus,
    this.idx,
    this.workflowState,
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
    this.pinCode,
    this.state,
    this.aadhaarCard,
    this.bankPassbook,
    this.panCard,
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
    this.accounts,
    this.companies,
    this.bankDetails,
  });

  Farmer.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        owner = json['owner'] as String?,
        creation = json['creation'] as String?,
        modified = json['modified'] as String?,
        modifiedBy = json['modified_by'] as String?,
        docstatus = json['docstatus'] as int?,
        idx = json['idx'] as int?,
        workflowState = json['workflow_state'] as String?,
        supplierName = json['supplier_name'] as String?,
        supplierType = json['supplier_type'] as String?,
        branch = json['branch'] as String?,
        aadhaarNumber = json['aadhaar_number'] as String?,
        panNumber = json['pan_number'] as String?,
        mobileNumber = json['mobile_number'] as String?,
        dateOfBirth = json['date_of_birth'] as String?,
        existingSupplierCode = json['existing_supplier_code'] as String?,
        gender = json['gender'] as String?,
        age = json['age'] as String?,
        country = json['country'] as String?,
        supplierGroup = json['supplier_group'] as String?,
        isTransporter = json['is_transporter'] as int?,
        isHarvester = json['is_harvester'] as int?,
        isFarmer = json['is_farmer'] as int?,
        isMember = json['is_member'] as int?,
        village = json['village'] as String?,
        circleOffice = json['circle_office'] as String?,
        taluka = json['taluka'] as String?,
        pinCode = json['pin_code'] as String?,
        state = json['state'] as String?,
        aadhaarCard = json['aadhaar_card'] as String?,
        bankPassbook = json['bank_passbook'] as String?,
        panCard = json['pan_card'] as String?,
        consentLetter = json['consent_letter'] as String?,
        isInternalSupplier = json['is_internal_supplier'] as int?,
        language = json['language'] as String?,
        allowPurchaseInvoiceCreationWithoutPurchaseOrder =
            json['allow_purchase_invoice_creation_without_purchase_order']
                as int?,
        allowPurchaseInvoiceCreationWithoutPurchaseReceipt =
            json['allow_purchase_invoice_creation_without_purchase_receipt']
                as int?,
        isFrozen = json['is_frozen'] as int?,
        disabled = json['disabled'] as int?,
        warnRfqs = json['warn_rfqs'] as int?,
        warnPos = json['warn_pos'] as int?,
        preventRfqs = json['prevent_rfqs'] as int?,
        preventPos = json['prevent_pos'] as int?,
        onHold = json['on_hold'] as int?,
        holdType = json['hold_type'] as String?,
        doctype = json['doctype'] as String?,
        accounts = json['accounts'] as List?,
        companies = json['companies'] as List?,
        bankDetails = (json['bank_details'] as List?)
            ?.map(
                (dynamic e) => BankDetails.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'name': name,
        'owner': owner,
        'creation': creation,
        'modified': modified,
        'modified_by': modifiedBy,
        'docstatus': docstatus,
        'idx': idx,
        'workflow_state': workflowState,
        'supplier_name': supplierName,
        'supplier_type': supplierType,
        'branch': branch,
        'aadhaar_number': aadhaarNumber,
        'pan_number': panNumber,
        'mobile_number': mobileNumber,
        'date_of_birth': dateOfBirth,
        'existing_supplier_code': existingSupplierCode,
        'gender': gender,
        'age': age,
        'country': country,
        'supplier_group': supplierGroup,
        'is_transporter': isTransporter,
        'is_harvester': isHarvester,
        'is_farmer': isFarmer,
        'is_member': isMember,
        'village': village,
        'circle_office': circleOffice,
        'taluka': taluka,
        'pin_code': pinCode,
        'state': state,
        'aadhaar_card': aadhaarCard,
        'bank_passbook': bankPassbook,
        'pan_card': panCard,
        'consent_letter': consentLetter,
        'is_internal_supplier': isInternalSupplier,
        'language': language,
        'allow_purchase_invoice_creation_without_purchase_order':
            allowPurchaseInvoiceCreationWithoutPurchaseOrder,
        'allow_purchase_invoice_creation_without_purchase_receipt':
            allowPurchaseInvoiceCreationWithoutPurchaseReceipt,
        'is_frozen': isFrozen,
        'disabled': disabled,
        'warn_rfqs': warnRfqs,
        'warn_pos': warnPos,
        'prevent_rfqs': preventRfqs,
        'prevent_pos': preventPos,
        'on_hold': onHold,
        'hold_type': holdType,
        'doctype': doctype,
        'accounts': accounts,
        'companies': companies,
        'bank_details': bankDetails?.map((e) => e.toJson()).toList()
      };
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
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  BankDetails({
    this.name,
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
    this.parent,
    this.parentfield,
    this.parenttype,
    this.doctype,
  });

  BankDetails.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        owner = json['owner'] as String?,
        creation = json['creation'] as String?,
        modified = json['modified'] as String?,
        modifiedBy = json['modified_by'] as String?,
        docstatus = json['docstatus'] as int?,
        idx = json['idx'] as int?,
        farmer = json['farmer'] as int?,
        harvester = json['harvester'] as int?,
        transporter = json['transporter'] as int?,
        bankName = json['bank_name'] as String?,
        branchifscCode = json['branchifsc_code'] as String?,
        accountNumber = json['account_number'] as String?,
        status = json['status'] as String?,
        isActive = json['is_active'] as String?,
        bankAndBranch = json['bank_and_branch'] as String?,
        parent = json['parent'] as String?,
        parentfield = json['parentfield'] as String?,
        parenttype = json['parenttype'] as String?,
        doctype = json['doctype'] as String?;

  Map<String, dynamic> toJson() => {
        'name': name,
        'owner': owner,
        'creation': creation,
        'modified': modified,
        'modified_by': modifiedBy,
        'docstatus': docstatus,
        'idx': idx,
        'farmer': farmer,
        'harvester': harvester,
        'transporter': transporter,
        'bank_name': bankName,
        'branchifsc_code': branchifscCode,
        'account_number': accountNumber,
        'status': status,
        'is_active': isActive,
        'bank_and_branch': bankAndBranch,
        'parent': parent,
        'parentfield': parentfield,
        'parenttype': parenttype,
        'doctype': doctype
      };
}
