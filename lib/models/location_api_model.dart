// class LocationApiModel {
//   List<Locations>? locations;

//   LocationApiModel({this.locations});

//   LocationApiModel.fromJson(Map<String, dynamic> json) {
//     if (json['locations'] != null) {
//       locations = <Locations>[];
//       json['locations'].forEach((v) {
//         locations!.add(new Locations.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.locations != null) {
//       data['locations'] = this.locations!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Locations {
//   int? id;
//   String? name;

//   Locations({this.id, this.name});

//   Locations.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     return data;
//   }
// }

class LocationApiModel {
  List<Locations>? locations;

  LocationApiModel({this.locations});

  LocationApiModel.fromJson(Map<String, dynamic> json) {
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(new Locations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.locations != null) {
      data['locations'] = this.locations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Locations {
  int? id;
  String? name;
  double? lat;
  double? long;
  int? radius;

  Locations({this.id, this.name, this.lat, this.long, this.radius});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lat = json['lat'];
    long = json['long'];
    radius = json['radius'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['radius'] = this.radius;
    return data;
  }
}
