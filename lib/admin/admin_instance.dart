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
      products_quantity: json['products_quantity'], 
      inventory_value: json['inventory_value'], 
      orders_value: json['orders_value'], 
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