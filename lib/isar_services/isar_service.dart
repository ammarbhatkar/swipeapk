import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swype/isar_collections/activity_collection.dart';
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
        [LocationCollectionSchema, ActivityCollecionSchema],
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

  Future<void> addActivityToIsar(
    String userId,
    String locationName,
    String locationId,
    int type,
    String time,
  ) async {
    final isar = await db;
    final activity = ActivityCollecion()
      ..userId = userId
      ..locationId = locationId
      ..locationName = locationName
      ..type = type
      ..time = time;

    await isar.writeTxn(() async {
      await isar.activityCollecions.put(activity);
    });
  }

  Stream<List<ActivityCollecion>> getActivities() async* {
    final isar = await db;
    yield* isar.activityCollecions.where().watch(fireImmediately: true);
  }
}