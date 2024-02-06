class LoginApiModel {
  String? success;
  String? accessToken;

  LoginApiModel({this.success, this.accessToken});

  LoginApiModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['access_token'] = this.accessToken;
    return data;
  }
}
