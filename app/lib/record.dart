class Record {
  final int? id;
  final DateTime startTimestamp;
  final int applicatorId;
  final String? applicatorName;
  final int customerId;
  final String? customerName;
  final bool customerInformedOfRei;
  final String fieldName;
  final String crop;
  final double totalArea;
  final double pricePerAcre;
  final double sprayVolume;
  final double? windSpeedBefore;
  final double? windSpeedAfter;
  final String? windDirection;
  final double? temperature;
  final String notes;

  Record({
    this.id,
    required this.startTimestamp,
    required this.applicatorId,
    this.applicatorName,
    required this.customerId,
    this.customerName,
    required this.customerInformedOfRei,
    required this.fieldName,
    required this.crop,
    required this.totalArea,
    required this.pricePerAcre,
    required this.sprayVolume,
    this.windSpeedBefore,
    this.windSpeedAfter,
    this.windDirection,
    this.temperature,
    this.notes = '',
  });

  Record copyWith({
    int? id,
    DateTime? startTimestamp,
    int? applicatorId,
    String? applicatorName,
    int? customerId,
    String? customerName,
    bool? customerInformedOfRei,
    String? fieldName,
    String? crop,
    double? totalArea,
    double? pricePerAcre,
    double? sprayVolume,
    double? windSpeedBefore,
    double? windSpeedAfter,
    String? windDirection,
    double? temperature,
    String? notes,
  }) {
    return Record(
      id: id ?? this.id,
      startTimestamp: startTimestamp ?? this.startTimestamp,
      applicatorId: applicatorId ?? this.applicatorId,
      applicatorName: applicatorName ?? this.applicatorName,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerInformedOfRei:
          customerInformedOfRei ?? this.customerInformedOfRei,
      fieldName: fieldName ?? this.fieldName,
      crop: crop ?? this.crop,
      totalArea: totalArea ?? this.totalArea,
      pricePerAcre: pricePerAcre ?? this.pricePerAcre,
      sprayVolume: sprayVolume ?? this.sprayVolume,
      windSpeedBefore: windSpeedBefore ?? this.windSpeedBefore,
      windSpeedAfter: windSpeedAfter ?? this.windSpeedAfter,
      windDirection: windDirection ?? this.windDirection,
      temperature: temperature ?? this.temperature,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startTimestamp': startTimestamp.millisecondsSinceEpoch,
      'applicator_id': applicatorId,
      'customer_id': customerId,
      'customer_informed_of_rei': customerInformedOfRei ? 1 : 0,
      'field_name': fieldName,
      'crop': crop,
      'total_area': totalArea,
      'price_per_acre': pricePerAcre,
      'spray_volume': sprayVolume,
      'wind_speed_before': windSpeedBefore,
      'wind_speed_after': windSpeedAfter,
      'wind_direction': windDirection,
      'temperature': temperature,
      'notes': notes,
    };
  }

  @override
  String toString() {
    return 'Record{id: $id, startTimestamp: $startTimestamp, applicatorId: $applicatorId, customerId: $customerId, customerInformedOfRei: $customerInformedOfRei, fieldName: $fieldName, crop: $crop, totalArea: $totalArea, pricePerAcre: $pricePerAcre, sprayVolume: $sprayVolume, windSpeedBefore: $windSpeedBefore, windSpeedAfter: $windSpeedAfter, windDirection: $windDirection, temperature: $temperature, notes: $notes}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Record &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTimestamp == other.startTimestamp &&
          applicatorId == other.applicatorId &&
          customerId == other.customerId &&
          customerInformedOfRei == other.customerInformedOfRei &&
          fieldName == other.fieldName &&
          crop == other.crop &&
          totalArea == other.totalArea &&
          pricePerAcre == other.pricePerAcre &&
          sprayVolume == other.sprayVolume &&
          windSpeedBefore == other.windSpeedBefore &&
          windSpeedAfter == other.windSpeedAfter &&
          windDirection == other.windDirection &&
          temperature == other.temperature &&
          notes == other.notes;

  @override
  int get hashCode =>
      id.hashCode ^
      startTimestamp.hashCode ^
      applicatorId.hashCode ^
      customerId.hashCode ^
      customerInformedOfRei.hashCode ^
      fieldName.hashCode ^
      crop.hashCode ^
      totalArea.hashCode ^
      pricePerAcre.hashCode ^
      sprayVolume.hashCode ^
      windSpeedBefore.hashCode ^
      windSpeedAfter.hashCode ^
      windDirection.hashCode ^
      temperature.hashCode ^
      notes.hashCode;
}
