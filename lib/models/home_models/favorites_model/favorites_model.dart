class FavoritesModel {
  bool? status;
  FavoritesDataModel? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = FavoritesDataModel.fromJson(json['data']);
  }
}

class FavoritesDataModel {
  List<FavoriteProductModel> data = [];

  FavoritesDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(FavoriteProductModel.fromJson(element));
    });
  }
}

class FavoriteProductModel {
  FavoritesProduct? product;

  FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    product = FavoritesProduct.fromJson(json['product']);
  }
}

class FavoritesProduct {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;

  FavoritesProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}
