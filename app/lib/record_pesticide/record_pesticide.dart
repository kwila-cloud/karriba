class RecordPesticide {
  final int recordId;
  final int pesticideId;
  double rate;
  String rateUnit;

  RecordPesticide({
    required this.recordId,
    required this.pesticideId,
    required this.rate,
    required this.rateUnit,
  });

  RecordPesticide copyWith({
    int? recordId,
    int? pesticideId,
    double? rate,
    String? rateUnit,
  }) {
    return RecordPesticide(
      recordId: recordId ?? this.recordId,
      pesticideId: pesticideId ?? this.pesticideId,
      rate: rate ?? this.rate,
      rateUnit: rateUnit ?? this.rateUnit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'record_id': recordId,
      'pesticide_id': pesticideId,
      'rate': rate,
      'rate_unit': rateUnit,
    };
  }

  @override
  String toString() {
    return 'RecordPesticide{recordId: $recordId, pesticideId: $pesticideId, rate: $rate, rateUnit: $rateUnit}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordPesticide &&
          runtimeType == other.runtimeType &&
          recordId == other.recordId &&
          pesticideId == other.pesticideId &&
          rate == other.rate &&
          rateUnit == other.rateUnit;

  @override
  int get hashCode =>
      recordId.hashCode ^
      pesticideId.hashCode ^
      rate.hashCode ^
      rateUnit.hashCode;
}
