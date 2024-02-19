// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class ShowActivityModel {
  List<Activities>? activities;

  ShowActivityModel({this.activities});

  ShowActivityModel.fromJson(Map<String, dynamic> json) {
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(new Activities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activities != null) {
      data['activities'] = this.activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activities {
  int? id;
  int? userId;
  String? timestamp;
  int? type;
  int? exitReason;
  int? option;
  String? variation;
  int? locationId;
  String? unrecognizedTemplateName;
  String? fileName;
  String? leaveTime;
  String? image;
  String? reason;
  int? isArchive;
  double? lat;
  double? long;
  String? locationName;

  Activities(
      {this.id,
      this.userId,
      this.timestamp,
      this.type,
      this.exitReason,
      this.option,
      this.variation,
      this.locationId,
      this.unrecognizedTemplateName,
      this.fileName,
      this.leaveTime,
      this.image,
      this.reason,
      this.isArchive,
      this.lat,
      this.long,
      this.locationName});

  Activities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    timestamp = json['timestamp'];
    type = json['type'];
    exitReason = json['exit_reason'];
    option = json['option'];
    variation = json['variation'];
    locationId = json['location_id'];
    unrecognizedTemplateName = json['unrecognized_template_name'];
    fileName = json['file_name'];
    leaveTime = json['leave_time'];
    image = json['image'];
    reason = json['reason'];
    isArchive = json['is_archive'];
    lat = json['lat'];
    long = json['long'];
    locationName = json['location_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['timestamp'] = this.timestamp;
    data['type'] = this.type;
    data['exit_reason'] = this.exitReason;
    data['option'] = this.option;
    data['variation'] = this.variation;
    data['location_id'] = this.locationId;
    data['unrecognized_template_name'] = this.unrecognizedTemplateName;
    data['file_name'] = this.fileName;
    data['leave_time'] = this.leaveTime;
    data['image'] = this.image;
    data['reason'] = this.reason;
    data['is_archive'] = this.isArchive;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['location_name'] = this.locationName;
    return data;
  }
}
