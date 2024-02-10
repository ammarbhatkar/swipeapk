import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swype/isar_collections/location_collection.dart';

class IsarService {
  late Future<Isar> db;
  IsarService() {
    db = openDB();
  }
  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final directory = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [LocationCollectionSchema],
        directory: directory.path,
      );
    }

    return await Future.value(Isar.getInstance());
  }

  Future<List<LocationCollection>> getLocations() async {
    final isar = await db;
    final locations = await isar.locationCollections.where().findAll();
    return locations;
  }

  void addLocation(int locationId, String locationName, double lat, double long,
      int radius) async {
    final isar = await db;
    final location = LocationCollection()
      ..locationId = locationId
      ..name = locationName
      ..lat = lat
      ..long = long
      ..radius = radius;
    isar.writeTxnSync(() {
      isar.locationCollections.putSync(location);
    });
  }
}
