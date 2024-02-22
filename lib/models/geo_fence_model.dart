// ignore_for_file: unnecessary_this, unnecessary_new, prefer_void_to_null, prefer_collection_literals

class GeoFenceModel {
  int? id;
  String? firstName;
  String? lastName;
  String? image;
  String? email;
  int? accountType;
  int? roleId;
  int? locationId;
  int? classDivisionId;
  int? accountStatus;
  String? upn;
  String? createdAt;
  String? updatedAt;
  int? isAutoCheckout;
  String? wagePerHour;
  String? joiningDate;
  int? isEnableGeofence;
  String? deactivationDate;

  GeoFenceModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.image,
      this.email,
      this.accountType,
      this.roleId,
      this.locationId,
      this.classDivisionId,
      this.accountStatus,
      this.upn,
      this.createdAt,
      this.updatedAt,
      this.isAutoCheckout,
      this.wagePerHour,
      this.joiningDate,
      this.isEnableGeofence,
      this.deactivationDate});

  GeoFenceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    email = json['email'];
    accountType = json['account_type'];
    roleId = json['role_id'];
    locationId = json['location_id'];
    classDivisionId = json['class_division_id'];
    accountStatus = json['account_status'];
    upn = json['upn'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isAutoCheckout = json['is_auto_checkout'];
    wagePerHour = json['wage_per_hour'];
    joiningDate = json['joining_date'];
    isEnableGeofence = json['is_enable_geofence'];
    deactivationDate = json['deactivation_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    data['email'] = this.email;
    data['account_type'] = this.accountType;
    data['role_id'] = this.roleId;
    data['location_id'] = this.locationId;
    data['class_division_id'] = this.classDivisionId;
    data['account_status'] = this.accountStatus;
    data['upn'] = this.upn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_auto_checkout'] = this.isAutoCheckout;
    data['wage_per_hour'] = this.wagePerHour;
    data['joining_date'] = this.joiningDate;
    data['is_enable_geofence'] = this.isEnableGeofence;
    data['deactivation_date'] = this.deactivationDate;
    return data;
  }
}
