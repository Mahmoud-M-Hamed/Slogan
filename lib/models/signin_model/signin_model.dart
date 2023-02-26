class SignInModel {
  bool? status;
  String? message;
  UserDataModel? data;

  SignInModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    message = jsonData['message'];
    data = jsonData['data'] != null
        ? UserDataModel.fromJson(jsonData['data'])
        : null;
  }
}

class UserDataModel {
  int? id;
  String? name, email, phone, image, token;

  UserDataModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    name = jsonData['name'];
    email = jsonData['email'];
    phone = jsonData['phone'];
    image = jsonData['image'];
    token = jsonData['token'];
  }
}
