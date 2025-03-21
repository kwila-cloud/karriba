class Record {
  final int? id;
  final DateTime timestamp;
  final int applicatorId;
  final String? applicatorName;
  final int customerId;
  final String? customerName;
  final bool customerInformedOfRei;
  final String fieldName;
  final double? windSpeedBefore;
  final double? windSpeedAfter;
  final String? windDirection;
  final double? temperature;

  Record({
    this.id,
    required this.timestamp,
    required this.applicatorId,
    this.applicatorName,
    required this.customerId,
    this.customerName,
    required this.customerInformedOfRei,
    required this.fieldName,
    this.windSpeedBefore,
    this.windSpeedAfter,
    this.windDirection,
    this.temperature,
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
    double? windSpeedBefore,
    double? windSpeedAfter,
    String? windDirection,
    double? temperature,
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
      windSpeedBefore: windSpeedBefore ?? this.windSpeedBefore,
      windSpeedAfter: windSpeedAfter ?? this.windSpeedAfter,
      windDirection: windDirection ?? this.windDirection,
      temperature: temperature ?? this.temperature,
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
      'wind_speed_before': windSpeedBefore,
      'wind_speed_after': windSpeedAfter,
      'wind_direction': windDirection,
      'temperature': temperature,
    };
  }

  @override
  String toString() {
    return 'Record{id: $id, timestamp: $timestamp, customerId: $customerId, applicatorId: $applicatorId, customerInformedOfRei: $customerInformedOfRei, fieldName: $fieldName, windSpeedBefore: $windSpeedBefore, windSpeedAfter: $windSpeedAfter, windDirection: $windDirection, temperature: $temperature}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Record &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          timestamp == other.timestamp &&
          applicatorId == other.applicatorId &&
          customerId == other.customerId &&
          customerInformedOfRei == other.customerInformedOfRei &&
          fieldName == other.fieldName &&
          windSpeedBefore == other.windSpeedBefore &&
          windSpeedAfter == other.windSpeedAfter &&
          windDirection == other.windDirection &&
          temperature == other.temperature;

  @override
  int get hashCode =>
      id.hashCode ^
      timestamp.hashCode ^
      applicatorId.hashCode ^
      customerId.hashCode ^
      customerInformedOfRei.hashCode ^
      fieldName.hashCode ^
      windSpeedBefore.hashCode ^
      windSpeedAfter.hashCode ^
      windDirection.hashCode ^
      temperature.hashCode;
}
