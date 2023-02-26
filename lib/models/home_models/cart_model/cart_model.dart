class CartModel {
  bool? status;
  CartDataModel? data;

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CartDataModel.fromJson(json['data']);
  }
}

class CartDataModel {
  List<CartProductModel> cartItems = [];

  CartDataModel.fromJson(Map<String, dynamic> json) {
    json['cart_items'].forEach((element) {
      cartItems.add(CartProductModel.fromJson(element));
    });
  }
}

class CartProductModel {
  CartProduct? product;

  CartProductModel.fromJson(Map<String, dynamic> json) {
    product = CartProduct.fromJson(json['product']);
  }
}

class CartProduct {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inCart;

  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inCart = json['in_cart'];
  }
}
