// // ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

// class CheckInApiModel {
//   bool? success;
//   String? message;

//   CheckInApiModel({this.success, this.message});

//   CheckInApiModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['message'] = this.message;
//     return data;
//   }
// }

class CheckInApiModel {
  bool? success;
  String? time;
  int? activityId;

  CheckInApiModel({this.success, this.time, this.activityId});

  CheckInApiModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    time = json['time'];
    activityId = json['activityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['time'] = this.time;
    data['activityId'] = this.activityId;
    return data;
  }
}
