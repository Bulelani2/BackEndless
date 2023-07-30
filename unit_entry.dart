/**
 * This is a class called UnitEntry which contains a Map of dynamic values, a username, an optional objectId, an optional created date, and an optional updated date.
 * It also contains a toJson() method which returns a Map of Strings and Objects, and a fromJson() method which returns a Unit
 */
class UnitEntry {
  Map<dynamic, dynamic> units;
  String username;
  String? objectId;
  DateTime? created;
  DateTime? updated;

  UnitEntry({
    required this.units,
    required this.username,
    this.objectId,
    this.created,
    this.updated,
  });

  Map<String, Object?> toJson() => {
        'username': username,
        'units': units,
        'created': created,
        'updated': updated,
        'objectId': objectId,
      };

  static UnitEntry fromJson(Map<dynamic, dynamic>? json) => UnitEntry(
        username: json!['username'] as String,
        units: json['units'] as Map<dynamic, dynamic>,
        objectId: json['objectId'] as String,
        created: json['created'] as DateTime,
      );
}
