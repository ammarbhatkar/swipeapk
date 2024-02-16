class CheckOutApiModel {
  bool? success;
  String? time;
  int? activityId;

  CheckOutApiModel({this.success, this.time, this.activityId});

  CheckOutApiModel.fromJson(Map<String, dynamic> json) {
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
