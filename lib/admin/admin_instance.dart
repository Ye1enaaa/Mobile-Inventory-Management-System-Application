// ignore_for_file: non_constant_identifier_names

class Dashboard{
  final int products_quantity;
  final int inventory_value;
  final String orders_value;
  final int admin_count;
  final int product_count;

  const Dashboard({
    required this.products_quantity,
    required this.inventory_value,
    required this.orders_value,
    required this.admin_count,
    required this.product_count
  });

  factory Dashboard.fromJson(Map<String, dynamic> json){
    return Dashboard(
      products_quantity: int.parse(json['products_quantity']), 
      inventory_value: json['inventory_value'], 
      orders_value: json['orders_value'].toString(), 
      admin_count: json['admin_count'],
      product_count: json['product_count']
    );
  }
}

class PurchaseOrder{
  final int _id;
  final int _userId;
  final String _name;
  final String _quantity;
  final int _totalValue;
  final String _userName;

  int get id => _id;
  int get userId => _userId;
  String get name => _name;
  String get quantity => _quantity;
  int get totalValue => _totalValue;
  String get userName => _userName;

  PurchaseOrder({
    required int id,
    required int userId,
    required String name,
    required String quantity,
    required int totalValue,
    required String userName,
  }): _id = id,
      _userId = userId,
      _name = name,
      _quantity = quantity,
      _totalValue = totalValue,
      _userName = userName
      ;

  factory PurchaseOrder.fromMap(Map<String, dynamic> map){
    return PurchaseOrder(
      id: map['id'], 
      userId: map['user_id']  , 
      name: map['name'], 
      quantity: map['quantity'], 
      totalValue: map['total_value'], 
      userName: map['user_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'user_id': _userId,
      'name': _name,
      'quantity': _quantity,
      'total_value': _totalValue,
      'user_name': _userName,  
    };
  }
}

class Products{
  final int _id;
  final String _name;
  final String _desc;
  final String _productCode;
  final String _unitPrice;
  final String _quantity;
  final String _inventoryValue;

  int get id => _id;
  String get name => _name;
  String get desc => _desc;
  String get productCode => _productCode;
  String get unitPrice => _unitPrice;
  String get quantity => _quantity;
  String get inventoryValue => _inventoryValue;

  Products({
    required int id,
    required String name,
    required String desc,
    required String productCode,
    required String unitPrice,
    required String quantity,
    required String inventoryValue
  }):
    _id = id,
    _name = name,
    _desc = desc,
    _productCode = productCode,
    _unitPrice = unitPrice,
    _quantity =quantity,
    _inventoryValue = inventoryValue;

  factory Products.fromMap(Map<String,dynamic> map){
    return Products(
      id: map['id'], 
      name: map['name'], 
      desc: map['description'], 
      productCode: map['product_code'], 
      unitPrice: map['unit_price'], 
      quantity: map['quantity'], 
      inventoryValue: map['inventory_value']);
  }
  Map<String,dynamic> toMap(){
    return {
      'id':  _id,
      'name': _name,
      'description': _desc,
      'product_code': _productCode,
      'unit_price': _unitPrice,
      'quantity': _quantity,
      'inventory_value': _inventoryValue
    };
  }
}




/*class PurchaseOrderData{
  final List<PurchaseOrder> purchaseOrder;

  PurchaseOrderData({required this.purchaseOrder});

  factory PurchaseOrderData.fromJson(Map<String,dynamic> json){
    var list = json['purchaseOrder'] as List<dynamic>;
    List<PurchaseOrder> purchaseOrderList =
      list.map((e) => PurchaseOrder.fromJson(e)).toList();
    return PurchaseOrderData(purchaseOrder: purchaseOrderList);
  }
}*/