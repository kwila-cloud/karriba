class Customer {
  final int? id;
  final String name;
  final String address;

  Customer({
    this.id,
    required this.name,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
    };
  }

  @override
  String toString() {
    return 'Customer{id: $id, name: $name, address: $address}';
  }
}
