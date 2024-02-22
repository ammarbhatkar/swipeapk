import 'package:isar/isar.dart';

part 'user_info_collection.g.dart';

@Collection()
class UserInfoCollection {
  Id id = Isar.autoIncrement;
  late int userId;
  late String firstName;
  late String lastName;
  late String email;
  late DateTime updatedAt;
  late int isGeoFencingEnabled;
}
