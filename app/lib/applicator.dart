class Applicator {
  final int? id;
  final String name;
  final String licenseNumber;

  Applicator({this.id, required this.name, required this.licenseNumber});

  Applicator copyWith({int? id, String? name, String? licenseNumber}) {
    return Applicator(
      id: id ?? this.id,
      name: name ?? this.name,
      licenseNumber: licenseNumber ?? this.licenseNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'license_number': licenseNumber};
  }

  @override
  String toString() {
    return 'Applicator{id: $id, name: $name, licenseNumber: $licenseNumber}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Applicator &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          licenseNumber == other.licenseNumber;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ licenseNumber.hashCode;
}
