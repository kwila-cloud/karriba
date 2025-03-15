class Record {
  final int? id;
  final DateTime timestamp;
  final int applicatorId;
  final String? applicatorName;
  final int customerId;
  final String? customerName;
  final bool customerInformedOfRei;
  final String fieldName;

  Record({
    this.id,
    required this.timestamp,
    required this.applicatorId,
    this.applicatorName,
    required this.customerId,
    this.customerName,
    required this.customerInformedOfRei,
    required this.fieldName,
  });

  Record copyWith({
    int? id,
    DateTime? timestamp,
    int? applicatorId,
    String? applicatorName,
    int? customerId,
    String? customerName,
    bool? customerInformedOfRei,
    String? fieldName,
  }) {
    return Record(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      applicatorId: applicatorId ?? this.applicatorId,
      applicatorName: applicatorName ?? this.applicatorName,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerInformedOfRei:
          customerInformedOfRei ?? this.customerInformedOfRei,
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
      'field_name': fieldName,
    };
  }

  @override
  String toString() {
    return 'Record{id: $id, timestamp: $timestamp, customerId: $customerId, applicatorId: $applicatorId, customerInformedOfRei: $customerInformedOfRei, fieldName: $fieldName}';
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
          fieldName == other.fieldName;

  @override
  int get hashCode =>
      id.hashCode ^
      timestamp.hashCode ^
      customerId.hashCode ^
      applicatorId.hashCode ^
      customerInformedOfRei.hashCode ^
      fieldName.hashCode;
}
