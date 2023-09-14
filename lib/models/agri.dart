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
        agricultureDevelopmentItem!.add(AgricultureDevelopmentItem.fromJson(v));
      });
    }
    if (json['grantor'] != null) {
      grantor = <Grantor>[];
      json['grantor'].forEach((v) {
        grantor!.add(Grantor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['sales_type'] = salesType;
    data['season'] = season;
    data['cane_registration_id'] = caneRegistrationId;
    data['supplier'] = supplier;
    data['vendor_code'] = vendorCode;
    data['grower_name'] = growerName;
    data['branch'] = branch;
    data['village'] = village;
    data['crop_type'] = cropType;
    data['crop_variety'] = cropVariety;
    data['date'] = date;
    data['area'] = area;
    data['development_area'] = developmentArea;
    data['route'] = route;
    data['basel'] = basel;
    data['pre_earthing'] = preEarthing;
    data['earth'] = earth;
    data['rainy'] = rainy;
    data['ratoon_1'] = ratoon1;
    data['ratoon_2'] = ratoon2;
    data['doctype'] = doctype;
    if (agricultureDevelopmentItem != null) {
      data['agriculture_development_item'] =
          agricultureDevelopmentItem!.map((v) => v.toJson()).toList();
    }
    if (grantor != null) {
      data['grantor'] = grantor!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['item_code'] = itemCode;
    data['item_name'] = itemName;
    data['basel'] = basel;
    data['pre_earthing'] = preEarthing;
    data['earth'] = earth;
    data['rainy'] = rainy;
    data['ratoon_1'] = ratoon1;
    data['ratoon_2'] = ratoon2;
    data['qty'] = qty;
    data['description'] = description;
    data['stock_uom'] = stockUom;
    data['rate'] = rate;
    data['item_tax_temp'] = itemTaxTemp;
    data['parent'] = parent;
    data['parentfield'] = parentfield;
    data['parenttype'] = parenttype;
    data['doctype'] = doctype;
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
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['owner'] = owner;
    data['modified_by'] = modifiedBy;
    data['docstatus'] = docstatus;
    data['idx'] = idx;
    data['surety_code'] = suretyCode;
    data['surety_name'] = suretyName;
    data['parent'] = parent;
    data['parentfield'] = parentfield;
    data['parenttype'] = parenttype;
    data['doctype'] = doctype;
    return data;
  }
}
