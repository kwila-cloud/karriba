class Pesticide {
  final int? id;
  final String name;
  final String registrationNumber;

  Pesticide({this.id, required this.name, required this.registrationNumber});

  Pesticide copyWith({int? id, String? name, String? registrationNumber}) {
    return Pesticide(
      id: id ?? this.id,
      name: name ?? this.name,
      registrationNumber: registrationNumber ?? this.registrationNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'registration_number': registrationNumber};
  }

  @override
  String toString() {
    return 'Pesticide{id: $id, name: $name, registrationNumber: $registrationNumber}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pesticide &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          registrationNumber == other.registrationNumber;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ registrationNumber.hashCode;
}
