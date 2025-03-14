class Customer {
  final int? id;
  final String name;
  final String streetAddress;
  final String city;
  final String state;
  final String zipCode;

  Customer({
    this.id,
    required this.name,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  Customer copyWith({
    int? id,
    String? name,
    String? streetAddress,
    String? city,
    String? state,
    String? zipCode,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      streetAddress: streetAddress ?? this.streetAddress,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'street_address': streetAddress,
      'city': city,
      'state': state,
      'zip_code': zipCode,
    };
  }

  @override
  String toString() {
    return 'Customer{id: $id, name: $name, streetAddress: $streetAddress, city: $city, state: $state, zipCode: $zipCode}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Customer &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          streetAddress == other.streetAddress &&
          city == other.city &&
          state == other.state &&
          zipCode == other.zipCode;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      streetAddress.hashCode ^
      city.hashCode ^
      state.hashCode ^
      zipCode.hashCode;
}
