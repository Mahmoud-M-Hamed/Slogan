class ProfileModel{
  ProfileData? data;

  ProfileModel.fromJson(Map<String, dynamic> json){
    data = ProfileData.fromJson(json['data']);
  }
}

class ProfileData{
  String? name, email, phone;

  ProfileData.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }
}