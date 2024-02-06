// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class CheckInApiModel {
  bool? success;
  String? message;

  CheckInApiModel({this.success, this.message});

  CheckInApiModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}
