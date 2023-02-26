class CategoryModel {
  bool? status;
  CategoryDataModel? data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoryDataModel.fromJson(json['data']);
  }
}

class CategoryDataModel {
  int? currentPage;
  List<DataModel>? categoryData = [];

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      categoryData!.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
