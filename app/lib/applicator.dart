// app/lib/applicator.dart
class Applicator {
  int? id;
  String name;
  String licenseNumber;

  Applicator({this.id, required this.name, required this.licenseNumber});

  // Convert a Applicator into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'license_number': licenseNumber,
    };
  }

  // Implement toString to make it easier to see information about
  // each applicator when using the print statement.
  @override
  String toString() {
    return 'Applicator{id: $id, name: $name, licenseNumber: $licenseNumber}';
  }
}
