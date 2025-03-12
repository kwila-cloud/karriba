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
}
