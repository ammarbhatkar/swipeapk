class CheckoutApiModel {
  bool? success;
  String? time;
  int? activityId;

  CheckoutApiModel({this.success, this.time, this.activityId});

  CheckoutApiModel.fromJson(Map<String, dynamic> json) {
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
