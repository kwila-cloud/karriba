class Applicator {
  final int? id;
  final String name;
  final String licenseNumber;

  Applicator({this.id, required this.name, required this.licenseNumber});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'license_number': licenseNumber};
  }

  @override
  String toString() {
    return 'Applicator{id: $id, name: $name, licenseNumber: $licenseNumber}';
  }
}
