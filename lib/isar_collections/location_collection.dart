import 'package:isar/isar.dart';

part 'location_collection.g.dart';

@Collection()
class LocationCollection {
  Id id = Isar.autoIncrement;

  late int locationId;
  late String name;
  late double lat;
  late double long;
  late int radius;
}
