import 'package:isar/isar.dart';

part 'activity_collection.g.dart';

@Collection()
class ActivityCollecion {
  Id id = Isar.autoIncrement;
  late String userId;
  late int type;
  late String locationId;
  late String locationName;
  late String time;
}
