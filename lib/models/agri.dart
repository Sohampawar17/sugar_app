class Agri {
  String? name;
  String? owner;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? salesType;
  String? season;
  String? caneRegistrationId;
  String? supplier;
  String? vendorCode;
  String? growerName;
  String? branch;
  String? village;
  String? cropType;
  String? cropVariety;
  String? date;
  double? area;
  double? developmentArea;
  String? route;
  int? basel;
  int? preEarthing;
  int? earth;
  int? rainy;
  int? ratoon1;
  int? ratoon2;
  String? doctype;
  List<AgricultureDevelopmentItem>? agricultureDevelopmentItem;
  List<AgricultureDevelopmentItem2>? agricultureDevelopmentItem2;
  List<Grantor>? grantor;

  Agri(
      {this.name,
      this.owner,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.salesType,
      this.season,
      this.caneRegistrationId,
      this.supplier,
      this.vendorCode,
      this.growerName,
      this.branch,
      this.village,
      this.cropType,
      this.cropVariety,
      this.date,
      this.area,
      this.developmentArea,
      this.route,
      this.basel,
      this.preEarthing,
      this.earth,
      this.rainy,
      this.ratoon1,
      this.ratoon2,
      this.doctype,
      this.agricultureDevelopmentItem,
      this.agricultureDevelopmentItem2,
      this.grantor});

  Agri.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    salesType = json['sales_type'];
    season = json['season'];
    caneRegistrationId = json['cane_registration_id'];
    supplier = json['supplier'];
    vendorCode = json['vendor_code'];
    growerName = json['grower_name'];
    branch = json['branch'];
    village = json['village'];
    cropType = json['crop_type'];
    cropVariety = json['crop_variety'];
    date = json['date'];
    area = json['area'];
    developmentArea = json['development_area'];
    route = json['route'];
    basel = json['basel'];
    preEarthing = json['pre_earthing'];
    earth = json['earth'];
    rainy = json['rainy'];
    ratoon1 = json['ratoon_1'];
    ratoon2 = json['ratoon_2'];
    doctype = json['doctype'];
    if (json['agriculture_development_item'] != null) {
      agricultureDevelopmentItem = <AgricultureDevelopmentItem>[];
      json['agriculture_development_item'].forEach((v) {
        agricultureDevelopmentItem!
            .add(new AgricultureDevelopmentItem.fromJson(v));
      });
    }
    if (json['agriculture_development_item2'] != null) {
      agricultureDevelopmentItem2 = <AgricultureDevelopmentItem2>[];
      json['agriculture_development_item2'].forEach((v) {
        agricultureDevelopmentItem2!
            .add(new AgricultureDevelopmentItem2.fromJson(v));
      });
    }
    if (json['grantor'] != null) {
      grantor = <Grantor>[];
      json['grantor'].forEach((v) {
        grantor!.add(new Grantor.fromJson(v));
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
    data['sales_type'] = this.salesType;
    data['season'] = this.season;
    data['cane_registration_id'] = this.caneRegistrationId;
    data['supplier'] = this.supplier;
    data['vendor_code'] = this.vendorCode;
    data['grower_name'] = this.growerName;
    data['branch'] = this.branch;
    data['village'] = this.village;
    data['crop_type'] = this.cropType;
    data['crop_variety'] = this.cropVariety;
    data['date'] = this.date;
    data['area'] = this.area;
    data['development_area'] = this.developmentArea;
    data['route'] = this.route;
    data['basel'] = this.basel;
    data['pre_earthing'] = this.preEarthing;
    data['earth'] = this.earth;
    data['rainy'] = this.rainy;
    data['ratoon_1'] = this.ratoon1;
    data['ratoon_2'] = this.ratoon2;
    data['doctype'] = this.doctype;
    if (this.agricultureDevelopmentItem != null) {
      data['agriculture_development_item'] =
          this.agricultureDevelopmentItem!.map((v) => v.toJson()).toList();
    }
    if (this.agricultureDevelopmentItem2 != null) {
      data['agriculture_development_item2'] =
          this.agricultureDevelopmentItem2!.map((v) => v.toJson()).toList();
    }
    if (this.grantor != null) {
      data['grantor'] = this.grantor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AgricultureDevelopmentItem {
  String? name;
  String? owner;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? itemCode;
  String? itemName;
  double? basel;
  double? preEarthing;
  double? earth;
  double? rainy;
  double? ratoon1;
  double? ratoon2;
  double? qty;
  String? description;
  String? stockUom;
  double? rate;
  String? itemTaxTemp;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  AgricultureDevelopmentItem(
      {this.name,
      this.owner,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.itemCode,
      this.itemName,
      this.basel,
      this.preEarthing,
      this.earth,
      this.rainy,
      this.ratoon1,
      this.ratoon2,
      this.qty,
      this.description,
      this.stockUom,
      this.rate,
      this.itemTaxTemp,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.doctype});

  AgricultureDevelopmentItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    basel = json['basel'];
    preEarthing = json['pre_earthing'];
    earth = json['earth'];
    rainy = json['rainy'];
    ratoon1 = json['ratoon_1'];
    ratoon2 = json['ratoon_2'];
    qty = json['qty'];
    description = json['description'];
    stockUom = json['stock_uom'];
    rate = json['rate'];
    itemTaxTemp = json['item_tax_temp'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['modified_by'] = this.modifiedBy;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['basel'] = this.basel;
    data['pre_earthing'] = this.preEarthing;
    data['earth'] = this.earth;
    data['rainy'] = this.rainy;
    data['ratoon_1'] = this.ratoon1;
    data['ratoon_2'] = this.ratoon2;
    data['qty'] = this.qty;
    data['description'] = this.description;
    data['stock_uom'] = this.stockUom;
    data['rate'] = this.rate;
    data['item_tax_temp'] = this.itemTaxTemp;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['doctype'] = this.doctype;
    return data;
  }
}

class AgricultureDevelopmentItem2 {
  String? name;
  String? owner;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? itemCode;
  String? itemName;
  double? qty;
  String? stockUom;
  double? rate;
  String? description;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  AgricultureDevelopmentItem2(
      {this.name,
      this.owner,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.itemCode,
      this.itemName,
      this.qty,
      this.stockUom,
      this.rate,
      this.description,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.doctype});

  AgricultureDevelopmentItem2.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    qty = json['qty'];
    stockUom = json['stock_uom'];
    rate = json['rate'];
    description = json['description'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['modified_by'] = this.modifiedBy;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['qty'] = this.qty;
    data['stock_uom'] = this.stockUom;
    data['rate'] = this.rate;
    data['description'] = this.description;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['doctype'] = this.doctype;
    return data;
  }
}

class Grantor {
  String? name;
  String? owner;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? suretyCode;
  String? suretyName;
  String? suretyExistingCode;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  Grantor(
      {this.name,
      this.owner,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.suretyCode,
      this.suretyName,
      this.suretyExistingCode,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.doctype});

  Grantor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    suretyCode = json['surety_code'];
    suretyName = json['surety_name'];
    suretyExistingCode = json['surety_existing_code'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['modified_by'] = this.modifiedBy;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['surety_code'] = this.suretyCode;
    data['surety_name'] = this.suretyName;
    data['surety_existing_code'] = this.suretyExistingCode;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['doctype'] = this.doctype;
    return data;
  }
}
