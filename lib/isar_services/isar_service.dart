import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swype/isar_collections/activity_collection.dart';
import 'package:swype/isar_collections/location_collection.dart';
import 'package:swype/isar_collections/user_info_collection.dart';

class IsarService {
  late Future<Isar> db;
  IsarService() {
    db = openDB();
  }
  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final directory = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [
          LocationCollectionSchema,
          ActivityCollecionSchema,
          UserInfoCollectionSchema
        ],
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

  Future<UserInfoCollection?> getUserInfoFromIsar(int userId) async {
    final isar = await db;
    return isar.userInfoCollections.get(userId);
  }

  // Stream<List<UserInfoCollection?>> watchUserInfoFromIsar(int userId) async* {
  //   final isar = await db;
  //   yield* isar.userInfoCollections.where().idEqualTo(userId).watch();
  // }

  Future<LocationCollection?> getUnrecogniedLocationFromIsar(
      String locationName) async {
    final isar = await db;
    return isar.locationCollections
        .where()
        .filter()
        .nameEqualTo(locationName)
        .findFirst();
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

  Future<void> addUserInfoToIsar(
    int userId,
    String firstName,
    String lastName,
    String email,
    int isGeoFencingEnabled,
    DateTime updatedAt,
  ) async {
    final isar = await db;
    final userInfo = UserInfoCollection()
      ..id = userId
      ..userId =
          userId // Assuming the id of UserInfoCollection is the same as userId
      ..firstName = firstName
      ..lastName = lastName
      ..email = email
      ..updatedAt = updatedAt
      ..isGeoFencingEnabled = isGeoFencingEnabled;
    await isar.writeTxn(() async {
      await isar.userInfoCollections.put(userInfo);
    });
  }

  Stream<List<ActivityCollecion>> getActivities() async* {
    final isar = await db;
    yield* isar.activityCollecions.where().watch(fireImmediately: true);
  }
}
