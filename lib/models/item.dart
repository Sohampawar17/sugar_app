class Item {
  String? itemCode;
  String? itemName;

  Item({this.itemCode, this.itemName});

  Item.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemName = json['item_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_code'] = itemCode;
    data['item_name'] = itemName;
    return data;
  }
}
