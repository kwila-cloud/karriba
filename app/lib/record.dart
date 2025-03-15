class Record {
  final int? id;
  final DateTime timestamp;
  final int customerId;
  final int applicatorId;
  final bool customerInformedOfRei;
  final String? customerName;
  final String? fieldName;

  Record({
    this.id,
    required this.timestamp,
    required this.customerId,
    required this.applicatorId,
    required this.customerInformedOfRei,
    this.customerName,
    this.fieldName,
  });

  Record copyWith({
    int? id,
    DateTime? timestamp,
    int? customerId,
    int? applicatorId,
    bool? customerInformedOfRei,
    String? customerName,
    String? fieldName,
  }) {
    return Record(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      customerId: customerId ?? this.customerId,
      applicatorId: applicatorId ?? this.applicatorId,
      customerInformedOfRei: customerInformedOfRei ?? this.customerInformedOfRei,
      customerName: customerName ?? this.customerName,
      fieldName: fieldName ?? this.fieldName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'customer_id': customerId,
      'applicator_id': applicatorId,
      'customer_informed_of_rei': customerInformedOfRei ? 1 : 0,
      'customer_name': customerName,
      'field_name': fieldName,
    };
  }

  @override
  String toString() {
    return 'Record{id: $id, timestamp: $timestamp, customerId: $customerId, applicatorId: $applicatorId, customerInformedOfRei: $customerInformedOfRei, customerName: $customerName, fieldName: $fieldName}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Record &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          timestamp == other.timestamp &&
          customerId == other.customerId &&
          applicatorId == other.applicatorId &&
          customerInformedOfRei == other.customerInformedOfRei &&
          customerName == other.customerName &&
          fieldName == other.fieldName;

  @override
  int get hashCode =>
      id.hashCode ^
      timestamp.hashCode ^
      customerId.hashCode ^
      applicatorId.hashCode ^
      customerInformedOfRei.hashCode ^
      customerName.hashCode ^
      fieldName.hashCode;
}
