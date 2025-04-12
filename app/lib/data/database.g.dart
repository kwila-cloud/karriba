// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Applicator extends Table with TableInfo<Applicator, ApplicatorData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Applicator(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _licenseNumberMeta = const VerificationMeta(
    'licenseNumber',
  );
  late final GeneratedColumn<String> licenseNumber = GeneratedColumn<String>(
    'license_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, licenseNumber];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'applicator';
  @override
  VerificationContext validateIntegrity(
    Insertable<ApplicatorData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('license_number')) {
      context.handle(
        _licenseNumberMeta,
        licenseNumber.isAcceptableOrUnknown(
          data['license_number']!,
          _licenseNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_licenseNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ApplicatorData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ApplicatorData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      licenseNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}license_number'],
          )!,
    );
  }

  @override
  Applicator createAlias(String alias) {
    return Applicator(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class ApplicatorData extends DataClass implements Insertable<ApplicatorData> {
  final int id;
  final String name;
  final String licenseNumber;
  const ApplicatorData({
    required this.id,
    required this.name,
    required this.licenseNumber,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['license_number'] = Variable<String>(licenseNumber);
    return map;
  }

  ApplicatorCompanion toCompanion(bool nullToAbsent) {
    return ApplicatorCompanion(
      id: Value(id),
      name: Value(name),
      licenseNumber: Value(licenseNumber),
    );
  }

  factory ApplicatorData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ApplicatorData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      licenseNumber: serializer.fromJson<String>(json['license_number']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'license_number': serializer.toJson<String>(licenseNumber),
    };
  }

  ApplicatorData copyWith({int? id, String? name, String? licenseNumber}) =>
      ApplicatorData(
        id: id ?? this.id,
        name: name ?? this.name,
        licenseNumber: licenseNumber ?? this.licenseNumber,
      );
  ApplicatorData copyWithCompanion(ApplicatorCompanion data) {
    return ApplicatorData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      licenseNumber:
          data.licenseNumber.present
              ? data.licenseNumber.value
              : this.licenseNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ApplicatorData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('licenseNumber: $licenseNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, licenseNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ApplicatorData &&
          other.id == this.id &&
          other.name == this.name &&
          other.licenseNumber == this.licenseNumber);
}

class ApplicatorCompanion extends UpdateCompanion<ApplicatorData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> licenseNumber;
  const ApplicatorCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.licenseNumber = const Value.absent(),
  });
  ApplicatorCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String licenseNumber,
  }) : name = Value(name),
       licenseNumber = Value(licenseNumber);
  static Insertable<ApplicatorData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? licenseNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (licenseNumber != null) 'license_number': licenseNumber,
    });
  }

  ApplicatorCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? licenseNumber,
  }) {
    return ApplicatorCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      licenseNumber: licenseNumber ?? this.licenseNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (licenseNumber.present) {
      map['license_number'] = Variable<String>(licenseNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApplicatorCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('licenseNumber: $licenseNumber')
          ..write(')'))
        .toString();
  }
}

class Customer extends Table with TableInfo<Customer, CustomerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Customer(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _streetAddressMeta = const VerificationMeta(
    'streetAddress',
  );
  late final GeneratedColumn<String> streetAddress = GeneratedColumn<String>(
    'street_address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _zipCodeMeta = const VerificationMeta(
    'zipCode',
  );
  late final GeneratedColumn<String> zipCode = GeneratedColumn<String>(
    'zip_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    streetAddress,
    city,
    state,
    zipCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomerData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('street_address')) {
      context.handle(
        _streetAddressMeta,
        streetAddress.isAcceptableOrUnknown(
          data['street_address']!,
          _streetAddressMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_streetAddressMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('zip_code')) {
      context.handle(
        _zipCodeMeta,
        zipCode.isAcceptableOrUnknown(data['zip_code']!, _zipCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_zipCodeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      streetAddress:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}street_address'],
          )!,
      city:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}city'],
          )!,
      state:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}state'],
          )!,
      zipCode:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}zip_code'],
          )!,
    );
  }

  @override
  Customer createAlias(String alias) {
    return Customer(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class CustomerData extends DataClass implements Insertable<CustomerData> {
  final int id;
  final String name;
  final String streetAddress;
  final String city;
  final String state;
  final String zipCode;
  const CustomerData({
    required this.id,
    required this.name,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.zipCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['street_address'] = Variable<String>(streetAddress);
    map['city'] = Variable<String>(city);
    map['state'] = Variable<String>(state);
    map['zip_code'] = Variable<String>(zipCode);
    return map;
  }

  CustomerCompanion toCompanion(bool nullToAbsent) {
    return CustomerCompanion(
      id: Value(id),
      name: Value(name),
      streetAddress: Value(streetAddress),
      city: Value(city),
      state: Value(state),
      zipCode: Value(zipCode),
    );
  }

  factory CustomerData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      streetAddress: serializer.fromJson<String>(json['street_address']),
      city: serializer.fromJson<String>(json['city']),
      state: serializer.fromJson<String>(json['state']),
      zipCode: serializer.fromJson<String>(json['zip_code']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'street_address': serializer.toJson<String>(streetAddress),
      'city': serializer.toJson<String>(city),
      'state': serializer.toJson<String>(state),
      'zip_code': serializer.toJson<String>(zipCode),
    };
  }

  CustomerData copyWith({
    int? id,
    String? name,
    String? streetAddress,
    String? city,
    String? state,
    String? zipCode,
  }) => CustomerData(
    id: id ?? this.id,
    name: name ?? this.name,
    streetAddress: streetAddress ?? this.streetAddress,
    city: city ?? this.city,
    state: state ?? this.state,
    zipCode: zipCode ?? this.zipCode,
  );
  CustomerData copyWithCompanion(CustomerCompanion data) {
    return CustomerData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      streetAddress:
          data.streetAddress.present
              ? data.streetAddress.value
              : this.streetAddress,
      city: data.city.present ? data.city.value : this.city,
      state: data.state.present ? data.state.value : this.state,
      zipCode: data.zipCode.present ? data.zipCode.value : this.zipCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('streetAddress: $streetAddress, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('zipCode: $zipCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, streetAddress, city, state, zipCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerData &&
          other.id == this.id &&
          other.name == this.name &&
          other.streetAddress == this.streetAddress &&
          other.city == this.city &&
          other.state == this.state &&
          other.zipCode == this.zipCode);
}

class CustomerCompanion extends UpdateCompanion<CustomerData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> streetAddress;
  final Value<String> city;
  final Value<String> state;
  final Value<String> zipCode;
  const CustomerCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.streetAddress = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.zipCode = const Value.absent(),
  });
  CustomerCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String streetAddress,
    required String city,
    required String state,
    required String zipCode,
  }) : name = Value(name),
       streetAddress = Value(streetAddress),
       city = Value(city),
       state = Value(state),
       zipCode = Value(zipCode);
  static Insertable<CustomerData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? streetAddress,
    Expression<String>? city,
    Expression<String>? state,
    Expression<String>? zipCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (streetAddress != null) 'street_address': streetAddress,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (zipCode != null) 'zip_code': zipCode,
    });
  }

  CustomerCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? streetAddress,
    Value<String>? city,
    Value<String>? state,
    Value<String>? zipCode,
  }) {
    return CustomerCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      streetAddress: streetAddress ?? this.streetAddress,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (streetAddress.present) {
      map['street_address'] = Variable<String>(streetAddress.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (zipCode.present) {
      map['zip_code'] = Variable<String>(zipCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('streetAddress: $streetAddress, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('zipCode: $zipCode')
          ..write(')'))
        .toString();
  }
}

class Record extends Table with TableInfo<Record, RecordData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Record(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _startTimestampMeta = const VerificationMeta(
    'startTimestamp',
  );
  late final GeneratedColumn<DateTime> startTimestamp =
      GeneratedColumn<DateTime>(
        'start_timestamp',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  static const VerificationMeta _endTimestampMeta = const VerificationMeta(
    'endTimestamp',
  );
  late final GeneratedColumn<DateTime> endTimestamp = GeneratedColumn<DateTime>(
    'end_timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _applicatorIdMeta = const VerificationMeta(
    'applicatorId',
  );
  late final GeneratedColumn<int> applicatorId = GeneratedColumn<int>(
    'applicator_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _customerInformedOfReiMeta =
      const VerificationMeta('customerInformedOfRei');
  late final GeneratedColumn<bool> customerInformedOfRei =
      GeneratedColumn<bool>(
        'customer_informed_of_rei',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  static const VerificationMeta _fieldNameMeta = const VerificationMeta(
    'fieldName',
  );
  late final GeneratedColumn<String> fieldName = GeneratedColumn<String>(
    'field_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _cropMeta = const VerificationMeta('crop');
  late final GeneratedColumn<String> crop = GeneratedColumn<String>(
    'crop',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _totalAreaMeta = const VerificationMeta(
    'totalArea',
  );
  late final GeneratedColumn<double> totalArea = GeneratedColumn<double>(
    'total_area',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _pricePerAcreMeta = const VerificationMeta(
    'pricePerAcre',
  );
  late final GeneratedColumn<double> pricePerAcre = GeneratedColumn<double>(
    'price_per_acre',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _sprayVolumeMeta = const VerificationMeta(
    'sprayVolume',
  );
  late final GeneratedColumn<double> sprayVolume = GeneratedColumn<double>(
    'spray_volume',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _windSpeedBeforeMeta = const VerificationMeta(
    'windSpeedBefore',
  );
  late final GeneratedColumn<double> windSpeedBefore = GeneratedColumn<double>(
    'wind_speed_before',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _windSpeedAfterMeta = const VerificationMeta(
    'windSpeedAfter',
  );
  late final GeneratedColumn<double> windSpeedAfter = GeneratedColumn<double>(
    'wind_speed_after',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _windDirectionMeta = const VerificationMeta(
    'windDirection',
  );
  late final GeneratedColumn<String> windDirection = GeneratedColumn<String>(
    'wind_direction',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _temperatureMeta = const VerificationMeta(
    'temperature',
  );
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
    'temperature',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startTimestamp,
    endTimestamp,
    applicatorId,
    customerId,
    customerInformedOfRei,
    fieldName,
    crop,
    totalArea,
    pricePerAcre,
    sprayVolume,
    windSpeedBefore,
    windSpeedAfter,
    windDirection,
    temperature,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'record';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecordData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_timestamp')) {
      context.handle(
        _startTimestampMeta,
        startTimestamp.isAcceptableOrUnknown(
          data['start_timestamp']!,
          _startTimestampMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startTimestampMeta);
    }
    if (data.containsKey('end_timestamp')) {
      context.handle(
        _endTimestampMeta,
        endTimestamp.isAcceptableOrUnknown(
          data['end_timestamp']!,
          _endTimestampMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_endTimestampMeta);
    }
    if (data.containsKey('applicator_id')) {
      context.handle(
        _applicatorIdMeta,
        applicatorId.isAcceptableOrUnknown(
          data['applicator_id']!,
          _applicatorIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_applicatorIdMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('customer_informed_of_rei')) {
      context.handle(
        _customerInformedOfReiMeta,
        customerInformedOfRei.isAcceptableOrUnknown(
          data['customer_informed_of_rei']!,
          _customerInformedOfReiMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerInformedOfReiMeta);
    }
    if (data.containsKey('field_name')) {
      context.handle(
        _fieldNameMeta,
        fieldName.isAcceptableOrUnknown(data['field_name']!, _fieldNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldNameMeta);
    }
    if (data.containsKey('crop')) {
      context.handle(
        _cropMeta,
        crop.isAcceptableOrUnknown(data['crop']!, _cropMeta),
      );
    } else if (isInserting) {
      context.missing(_cropMeta);
    }
    if (data.containsKey('total_area')) {
      context.handle(
        _totalAreaMeta,
        totalArea.isAcceptableOrUnknown(data['total_area']!, _totalAreaMeta),
      );
    } else if (isInserting) {
      context.missing(_totalAreaMeta);
    }
    if (data.containsKey('price_per_acre')) {
      context.handle(
        _pricePerAcreMeta,
        pricePerAcre.isAcceptableOrUnknown(
          data['price_per_acre']!,
          _pricePerAcreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pricePerAcreMeta);
    }
    if (data.containsKey('spray_volume')) {
      context.handle(
        _sprayVolumeMeta,
        sprayVolume.isAcceptableOrUnknown(
          data['spray_volume']!,
          _sprayVolumeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sprayVolumeMeta);
    }
    if (data.containsKey('wind_speed_before')) {
      context.handle(
        _windSpeedBeforeMeta,
        windSpeedBefore.isAcceptableOrUnknown(
          data['wind_speed_before']!,
          _windSpeedBeforeMeta,
        ),
      );
    }
    if (data.containsKey('wind_speed_after')) {
      context.handle(
        _windSpeedAfterMeta,
        windSpeedAfter.isAcceptableOrUnknown(
          data['wind_speed_after']!,
          _windSpeedAfterMeta,
        ),
      );
    }
    if (data.containsKey('wind_direction')) {
      context.handle(
        _windDirectionMeta,
        windDirection.isAcceptableOrUnknown(
          data['wind_direction']!,
          _windDirectionMeta,
        ),
      );
    }
    if (data.containsKey('temperature')) {
      context.handle(
        _temperatureMeta,
        temperature.isAcceptableOrUnknown(
          data['temperature']!,
          _temperatureMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecordData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecordData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      startTimestamp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}start_timestamp'],
          )!,
      endTimestamp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}end_timestamp'],
          )!,
      applicatorId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}applicator_id'],
          )!,
      customerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}customer_id'],
          )!,
      customerInformedOfRei:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}customer_informed_of_rei'],
          )!,
      fieldName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}field_name'],
          )!,
      crop:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}crop'],
          )!,
      totalArea:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}total_area'],
          )!,
      pricePerAcre:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}price_per_acre'],
          )!,
      sprayVolume:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}spray_volume'],
          )!,
      windSpeedBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wind_speed_before'],
      ),
      windSpeedAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wind_speed_after'],
      ),
      windDirection: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wind_direction'],
      ),
      temperature: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature'],
      ),
      notes:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}notes'],
          )!,
    );
  }

  @override
  Record createAlias(String alias) {
    return Record(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class RecordData extends DataClass implements Insertable<RecordData> {
  final int id;
  final DateTime startTimestamp;
  final DateTime endTimestamp;
  final int applicatorId;
  final int customerId;
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
  const RecordData({
    required this.id,
    required this.startTimestamp,
    required this.endTimestamp,
    required this.applicatorId,
    required this.customerId,
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
    required this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['start_timestamp'] = Variable<DateTime>(startTimestamp);
    map['end_timestamp'] = Variable<DateTime>(endTimestamp);
    map['applicator_id'] = Variable<int>(applicatorId);
    map['customer_id'] = Variable<int>(customerId);
    map['customer_informed_of_rei'] = Variable<bool>(customerInformedOfRei);
    map['field_name'] = Variable<String>(fieldName);
    map['crop'] = Variable<String>(crop);
    map['total_area'] = Variable<double>(totalArea);
    map['price_per_acre'] = Variable<double>(pricePerAcre);
    map['spray_volume'] = Variable<double>(sprayVolume);
    if (!nullToAbsent || windSpeedBefore != null) {
      map['wind_speed_before'] = Variable<double>(windSpeedBefore);
    }
    if (!nullToAbsent || windSpeedAfter != null) {
      map['wind_speed_after'] = Variable<double>(windSpeedAfter);
    }
    if (!nullToAbsent || windDirection != null) {
      map['wind_direction'] = Variable<String>(windDirection);
    }
    if (!nullToAbsent || temperature != null) {
      map['temperature'] = Variable<double>(temperature);
    }
    map['notes'] = Variable<String>(notes);
    return map;
  }

  RecordCompanion toCompanion(bool nullToAbsent) {
    return RecordCompanion(
      id: Value(id),
      startTimestamp: Value(startTimestamp),
      endTimestamp: Value(endTimestamp),
      applicatorId: Value(applicatorId),
      customerId: Value(customerId),
      customerInformedOfRei: Value(customerInformedOfRei),
      fieldName: Value(fieldName),
      crop: Value(crop),
      totalArea: Value(totalArea),
      pricePerAcre: Value(pricePerAcre),
      sprayVolume: Value(sprayVolume),
      windSpeedBefore:
          windSpeedBefore == null && nullToAbsent
              ? const Value.absent()
              : Value(windSpeedBefore),
      windSpeedAfter:
          windSpeedAfter == null && nullToAbsent
              ? const Value.absent()
              : Value(windSpeedAfter),
      windDirection:
          windDirection == null && nullToAbsent
              ? const Value.absent()
              : Value(windDirection),
      temperature:
          temperature == null && nullToAbsent
              ? const Value.absent()
              : Value(temperature),
      notes: Value(notes),
    );
  }

  factory RecordData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecordData(
      id: serializer.fromJson<int>(json['id']),
      startTimestamp: serializer.fromJson<DateTime>(json['start_timestamp']),
      endTimestamp: serializer.fromJson<DateTime>(json['end_timestamp']),
      applicatorId: serializer.fromJson<int>(json['applicator_id']),
      customerId: serializer.fromJson<int>(json['customer_id']),
      customerInformedOfRei: serializer.fromJson<bool>(
        json['customer_informed_of_rei'],
      ),
      fieldName: serializer.fromJson<String>(json['field_name']),
      crop: serializer.fromJson<String>(json['crop']),
      totalArea: serializer.fromJson<double>(json['total_area']),
      pricePerAcre: serializer.fromJson<double>(json['price_per_acre']),
      sprayVolume: serializer.fromJson<double>(json['spray_volume']),
      windSpeedBefore: serializer.fromJson<double?>(json['wind_speed_before']),
      windSpeedAfter: serializer.fromJson<double?>(json['wind_speed_after']),
      windDirection: serializer.fromJson<String?>(json['wind_direction']),
      temperature: serializer.fromJson<double?>(json['temperature']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'start_timestamp': serializer.toJson<DateTime>(startTimestamp),
      'end_timestamp': serializer.toJson<DateTime>(endTimestamp),
      'applicator_id': serializer.toJson<int>(applicatorId),
      'customer_id': serializer.toJson<int>(customerId),
      'customer_informed_of_rei': serializer.toJson<bool>(
        customerInformedOfRei,
      ),
      'field_name': serializer.toJson<String>(fieldName),
      'crop': serializer.toJson<String>(crop),
      'total_area': serializer.toJson<double>(totalArea),
      'price_per_acre': serializer.toJson<double>(pricePerAcre),
      'spray_volume': serializer.toJson<double>(sprayVolume),
      'wind_speed_before': serializer.toJson<double?>(windSpeedBefore),
      'wind_speed_after': serializer.toJson<double?>(windSpeedAfter),
      'wind_direction': serializer.toJson<String?>(windDirection),
      'temperature': serializer.toJson<double?>(temperature),
      'notes': serializer.toJson<String>(notes),
    };
  }

  RecordData copyWith({
    int? id,
    DateTime? startTimestamp,
    DateTime? endTimestamp,
    int? applicatorId,
    int? customerId,
    bool? customerInformedOfRei,
    String? fieldName,
    String? crop,
    double? totalArea,
    double? pricePerAcre,
    double? sprayVolume,
    Value<double?> windSpeedBefore = const Value.absent(),
    Value<double?> windSpeedAfter = const Value.absent(),
    Value<String?> windDirection = const Value.absent(),
    Value<double?> temperature = const Value.absent(),
    String? notes,
  }) => RecordData(
    id: id ?? this.id,
    startTimestamp: startTimestamp ?? this.startTimestamp,
    endTimestamp: endTimestamp ?? this.endTimestamp,
    applicatorId: applicatorId ?? this.applicatorId,
    customerId: customerId ?? this.customerId,
    customerInformedOfRei: customerInformedOfRei ?? this.customerInformedOfRei,
    fieldName: fieldName ?? this.fieldName,
    crop: crop ?? this.crop,
    totalArea: totalArea ?? this.totalArea,
    pricePerAcre: pricePerAcre ?? this.pricePerAcre,
    sprayVolume: sprayVolume ?? this.sprayVolume,
    windSpeedBefore:
        windSpeedBefore.present ? windSpeedBefore.value : this.windSpeedBefore,
    windSpeedAfter:
        windSpeedAfter.present ? windSpeedAfter.value : this.windSpeedAfter,
    windDirection:
        windDirection.present ? windDirection.value : this.windDirection,
    temperature: temperature.present ? temperature.value : this.temperature,
    notes: notes ?? this.notes,
  );
  RecordData copyWithCompanion(RecordCompanion data) {
    return RecordData(
      id: data.id.present ? data.id.value : this.id,
      startTimestamp:
          data.startTimestamp.present
              ? data.startTimestamp.value
              : this.startTimestamp,
      endTimestamp:
          data.endTimestamp.present
              ? data.endTimestamp.value
              : this.endTimestamp,
      applicatorId:
          data.applicatorId.present
              ? data.applicatorId.value
              : this.applicatorId,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      customerInformedOfRei:
          data.customerInformedOfRei.present
              ? data.customerInformedOfRei.value
              : this.customerInformedOfRei,
      fieldName: data.fieldName.present ? data.fieldName.value : this.fieldName,
      crop: data.crop.present ? data.crop.value : this.crop,
      totalArea: data.totalArea.present ? data.totalArea.value : this.totalArea,
      pricePerAcre:
          data.pricePerAcre.present
              ? data.pricePerAcre.value
              : this.pricePerAcre,
      sprayVolume:
          data.sprayVolume.present ? data.sprayVolume.value : this.sprayVolume,
      windSpeedBefore:
          data.windSpeedBefore.present
              ? data.windSpeedBefore.value
              : this.windSpeedBefore,
      windSpeedAfter:
          data.windSpeedAfter.present
              ? data.windSpeedAfter.value
              : this.windSpeedAfter,
      windDirection:
          data.windDirection.present
              ? data.windDirection.value
              : this.windDirection,
      temperature:
          data.temperature.present ? data.temperature.value : this.temperature,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecordData(')
          ..write('id: $id, ')
          ..write('startTimestamp: $startTimestamp, ')
          ..write('endTimestamp: $endTimestamp, ')
          ..write('applicatorId: $applicatorId, ')
          ..write('customerId: $customerId, ')
          ..write('customerInformedOfRei: $customerInformedOfRei, ')
          ..write('fieldName: $fieldName, ')
          ..write('crop: $crop, ')
          ..write('totalArea: $totalArea, ')
          ..write('pricePerAcre: $pricePerAcre, ')
          ..write('sprayVolume: $sprayVolume, ')
          ..write('windSpeedBefore: $windSpeedBefore, ')
          ..write('windSpeedAfter: $windSpeedAfter, ')
          ..write('windDirection: $windDirection, ')
          ..write('temperature: $temperature, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startTimestamp,
    endTimestamp,
    applicatorId,
    customerId,
    customerInformedOfRei,
    fieldName,
    crop,
    totalArea,
    pricePerAcre,
    sprayVolume,
    windSpeedBefore,
    windSpeedAfter,
    windDirection,
    temperature,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecordData &&
          other.id == this.id &&
          other.startTimestamp == this.startTimestamp &&
          other.endTimestamp == this.endTimestamp &&
          other.applicatorId == this.applicatorId &&
          other.customerId == this.customerId &&
          other.customerInformedOfRei == this.customerInformedOfRei &&
          other.fieldName == this.fieldName &&
          other.crop == this.crop &&
          other.totalArea == this.totalArea &&
          other.pricePerAcre == this.pricePerAcre &&
          other.sprayVolume == this.sprayVolume &&
          other.windSpeedBefore == this.windSpeedBefore &&
          other.windSpeedAfter == this.windSpeedAfter &&
          other.windDirection == this.windDirection &&
          other.temperature == this.temperature &&
          other.notes == this.notes);
}

class RecordCompanion extends UpdateCompanion<RecordData> {
  final Value<int> id;
  final Value<DateTime> startTimestamp;
  final Value<DateTime> endTimestamp;
  final Value<int> applicatorId;
  final Value<int> customerId;
  final Value<bool> customerInformedOfRei;
  final Value<String> fieldName;
  final Value<String> crop;
  final Value<double> totalArea;
  final Value<double> pricePerAcre;
  final Value<double> sprayVolume;
  final Value<double?> windSpeedBefore;
  final Value<double?> windSpeedAfter;
  final Value<String?> windDirection;
  final Value<double?> temperature;
  final Value<String> notes;
  const RecordCompanion({
    this.id = const Value.absent(),
    this.startTimestamp = const Value.absent(),
    this.endTimestamp = const Value.absent(),
    this.applicatorId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.customerInformedOfRei = const Value.absent(),
    this.fieldName = const Value.absent(),
    this.crop = const Value.absent(),
    this.totalArea = const Value.absent(),
    this.pricePerAcre = const Value.absent(),
    this.sprayVolume = const Value.absent(),
    this.windSpeedBefore = const Value.absent(),
    this.windSpeedAfter = const Value.absent(),
    this.windDirection = const Value.absent(),
    this.temperature = const Value.absent(),
    this.notes = const Value.absent(),
  });
  RecordCompanion.insert({
    this.id = const Value.absent(),
    required DateTime startTimestamp,
    required DateTime endTimestamp,
    required int applicatorId,
    required int customerId,
    required bool customerInformedOfRei,
    required String fieldName,
    required String crop,
    required double totalArea,
    required double pricePerAcre,
    required double sprayVolume,
    this.windSpeedBefore = const Value.absent(),
    this.windSpeedAfter = const Value.absent(),
    this.windDirection = const Value.absent(),
    this.temperature = const Value.absent(),
    required String notes,
  }) : startTimestamp = Value(startTimestamp),
       endTimestamp = Value(endTimestamp),
       applicatorId = Value(applicatorId),
       customerId = Value(customerId),
       customerInformedOfRei = Value(customerInformedOfRei),
       fieldName = Value(fieldName),
       crop = Value(crop),
       totalArea = Value(totalArea),
       pricePerAcre = Value(pricePerAcre),
       sprayVolume = Value(sprayVolume),
       notes = Value(notes);
  static Insertable<RecordData> custom({
    Expression<int>? id,
    Expression<DateTime>? startTimestamp,
    Expression<DateTime>? endTimestamp,
    Expression<int>? applicatorId,
    Expression<int>? customerId,
    Expression<bool>? customerInformedOfRei,
    Expression<String>? fieldName,
    Expression<String>? crop,
    Expression<double>? totalArea,
    Expression<double>? pricePerAcre,
    Expression<double>? sprayVolume,
    Expression<double>? windSpeedBefore,
    Expression<double>? windSpeedAfter,
    Expression<String>? windDirection,
    Expression<double>? temperature,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startTimestamp != null) 'start_timestamp': startTimestamp,
      if (endTimestamp != null) 'end_timestamp': endTimestamp,
      if (applicatorId != null) 'applicator_id': applicatorId,
      if (customerId != null) 'customer_id': customerId,
      if (customerInformedOfRei != null)
        'customer_informed_of_rei': customerInformedOfRei,
      if (fieldName != null) 'field_name': fieldName,
      if (crop != null) 'crop': crop,
      if (totalArea != null) 'total_area': totalArea,
      if (pricePerAcre != null) 'price_per_acre': pricePerAcre,
      if (sprayVolume != null) 'spray_volume': sprayVolume,
      if (windSpeedBefore != null) 'wind_speed_before': windSpeedBefore,
      if (windSpeedAfter != null) 'wind_speed_after': windSpeedAfter,
      if (windDirection != null) 'wind_direction': windDirection,
      if (temperature != null) 'temperature': temperature,
      if (notes != null) 'notes': notes,
    });
  }

  RecordCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? startTimestamp,
    Value<DateTime>? endTimestamp,
    Value<int>? applicatorId,
    Value<int>? customerId,
    Value<bool>? customerInformedOfRei,
    Value<String>? fieldName,
    Value<String>? crop,
    Value<double>? totalArea,
    Value<double>? pricePerAcre,
    Value<double>? sprayVolume,
    Value<double?>? windSpeedBefore,
    Value<double?>? windSpeedAfter,
    Value<String?>? windDirection,
    Value<double?>? temperature,
    Value<String>? notes,
  }) {
    return RecordCompanion(
      id: id ?? this.id,
      startTimestamp: startTimestamp ?? this.startTimestamp,
      endTimestamp: endTimestamp ?? this.endTimestamp,
      applicatorId: applicatorId ?? this.applicatorId,
      customerId: customerId ?? this.customerId,
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

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startTimestamp.present) {
      map['start_timestamp'] = Variable<DateTime>(startTimestamp.value);
    }
    if (endTimestamp.present) {
      map['end_timestamp'] = Variable<DateTime>(endTimestamp.value);
    }
    if (applicatorId.present) {
      map['applicator_id'] = Variable<int>(applicatorId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (customerInformedOfRei.present) {
      map['customer_informed_of_rei'] = Variable<bool>(
        customerInformedOfRei.value,
      );
    }
    if (fieldName.present) {
      map['field_name'] = Variable<String>(fieldName.value);
    }
    if (crop.present) {
      map['crop'] = Variable<String>(crop.value);
    }
    if (totalArea.present) {
      map['total_area'] = Variable<double>(totalArea.value);
    }
    if (pricePerAcre.present) {
      map['price_per_acre'] = Variable<double>(pricePerAcre.value);
    }
    if (sprayVolume.present) {
      map['spray_volume'] = Variable<double>(sprayVolume.value);
    }
    if (windSpeedBefore.present) {
      map['wind_speed_before'] = Variable<double>(windSpeedBefore.value);
    }
    if (windSpeedAfter.present) {
      map['wind_speed_after'] = Variable<double>(windSpeedAfter.value);
    }
    if (windDirection.present) {
      map['wind_direction'] = Variable<String>(windDirection.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecordCompanion(')
          ..write('id: $id, ')
          ..write('startTimestamp: $startTimestamp, ')
          ..write('endTimestamp: $endTimestamp, ')
          ..write('applicatorId: $applicatorId, ')
          ..write('customerId: $customerId, ')
          ..write('customerInformedOfRei: $customerInformedOfRei, ')
          ..write('fieldName: $fieldName, ')
          ..write('crop: $crop, ')
          ..write('totalArea: $totalArea, ')
          ..write('pricePerAcre: $pricePerAcre, ')
          ..write('sprayVolume: $sprayVolume, ')
          ..write('windSpeedBefore: $windSpeedBefore, ')
          ..write('windSpeedAfter: $windSpeedAfter, ')
          ..write('windDirection: $windDirection, ')
          ..write('temperature: $temperature, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class Pesticide extends Table with TableInfo<Pesticide, PesticideData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Pesticide(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _registrationNumberMeta =
      const VerificationMeta('registrationNumber');
  late final GeneratedColumn<String> registrationNumber =
      GeneratedColumn<String>(
        'registration_number',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        $customConstraints: 'NOT NULL',
      );
  @override
  List<GeneratedColumn> get $columns => [id, name, registrationNumber];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pesticide';
  @override
  VerificationContext validateIntegrity(
    Insertable<PesticideData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('registration_number')) {
      context.handle(
        _registrationNumberMeta,
        registrationNumber.isAcceptableOrUnknown(
          data['registration_number']!,
          _registrationNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_registrationNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PesticideData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PesticideData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      registrationNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}registration_number'],
          )!,
    );
  }

  @override
  Pesticide createAlias(String alias) {
    return Pesticide(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class PesticideData extends DataClass implements Insertable<PesticideData> {
  final int id;
  final String name;
  final String registrationNumber;
  const PesticideData({
    required this.id,
    required this.name,
    required this.registrationNumber,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['registration_number'] = Variable<String>(registrationNumber);
    return map;
  }

  PesticideCompanion toCompanion(bool nullToAbsent) {
    return PesticideCompanion(
      id: Value(id),
      name: Value(name),
      registrationNumber: Value(registrationNumber),
    );
  }

  factory PesticideData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PesticideData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      registrationNumber: serializer.fromJson<String>(
        json['registration_number'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'registration_number': serializer.toJson<String>(registrationNumber),
    };
  }

  PesticideData copyWith({int? id, String? name, String? registrationNumber}) =>
      PesticideData(
        id: id ?? this.id,
        name: name ?? this.name,
        registrationNumber: registrationNumber ?? this.registrationNumber,
      );
  PesticideData copyWithCompanion(PesticideCompanion data) {
    return PesticideData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      registrationNumber:
          data.registrationNumber.present
              ? data.registrationNumber.value
              : this.registrationNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PesticideData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('registrationNumber: $registrationNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, registrationNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PesticideData &&
          other.id == this.id &&
          other.name == this.name &&
          other.registrationNumber == this.registrationNumber);
}

class PesticideCompanion extends UpdateCompanion<PesticideData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> registrationNumber;
  const PesticideCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.registrationNumber = const Value.absent(),
  });
  PesticideCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String registrationNumber,
  }) : name = Value(name),
       registrationNumber = Value(registrationNumber);
  static Insertable<PesticideData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? registrationNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (registrationNumber != null) 'registration_number': registrationNumber,
    });
  }

  PesticideCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? registrationNumber,
  }) {
    return PesticideCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      registrationNumber: registrationNumber ?? this.registrationNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (registrationNumber.present) {
      map['registration_number'] = Variable<String>(registrationNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PesticideCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('registrationNumber: $registrationNumber')
          ..write(')'))
        .toString();
  }
}

class RecordPesticide extends Table
    with TableInfo<RecordPesticide, RecordPesticideData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  RecordPesticide(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  late final GeneratedColumn<int> recordId = GeneratedColumn<int>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _pesticideIdMeta = const VerificationMeta(
    'pesticideId',
  );
  late final GeneratedColumn<int> pesticideId = GeneratedColumn<int>(
    'pesticide_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  late final GeneratedColumn<double> rate = GeneratedColumn<double>(
    'rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _rateUnitMeta = const VerificationMeta(
    'rateUnit',
  );
  late final GeneratedColumn<String> rateUnit = GeneratedColumn<String>(
    'rate_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [recordId, pesticideId, rate, rateUnit];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'record_pesticide';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecordPesticideData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('pesticide_id')) {
      context.handle(
        _pesticideIdMeta,
        pesticideId.isAcceptableOrUnknown(
          data['pesticide_id']!,
          _pesticideIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pesticideIdMeta);
    }
    if (data.containsKey('rate')) {
      context.handle(
        _rateMeta,
        rate.isAcceptableOrUnknown(data['rate']!, _rateMeta),
      );
    } else if (isInserting) {
      context.missing(_rateMeta);
    }
    if (data.containsKey('rate_unit')) {
      context.handle(
        _rateUnitMeta,
        rateUnit.isAcceptableOrUnknown(data['rate_unit']!, _rateUnitMeta),
      );
    } else if (isInserting) {
      context.missing(_rateUnitMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {recordId, pesticideId};
  @override
  RecordPesticideData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecordPesticideData(
      recordId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}record_id'],
          )!,
      pesticideId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}pesticide_id'],
          )!,
      rate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}rate'],
          )!,
      rateUnit:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}rate_unit'],
          )!,
    );
  }

  @override
  RecordPesticide createAlias(String alias) {
    return RecordPesticide(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(record_id, pesticide_id)',
    'FOREIGN KEY(record_id)REFERENCES record(id)ON DELETE CASCADE',
    'FOREIGN KEY(pesticide_id)REFERENCES pesticide(id)ON DELETE CASCADE',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class RecordPesticideData extends DataClass
    implements Insertable<RecordPesticideData> {
  final int recordId;
  final int pesticideId;
  final double rate;
  final String rateUnit;
  const RecordPesticideData({
    required this.recordId,
    required this.pesticideId,
    required this.rate,
    required this.rateUnit,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['record_id'] = Variable<int>(recordId);
    map['pesticide_id'] = Variable<int>(pesticideId);
    map['rate'] = Variable<double>(rate);
    map['rate_unit'] = Variable<String>(rateUnit);
    return map;
  }

  RecordPesticideCompanion toCompanion(bool nullToAbsent) {
    return RecordPesticideCompanion(
      recordId: Value(recordId),
      pesticideId: Value(pesticideId),
      rate: Value(rate),
      rateUnit: Value(rateUnit),
    );
  }

  factory RecordPesticideData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecordPesticideData(
      recordId: serializer.fromJson<int>(json['record_id']),
      pesticideId: serializer.fromJson<int>(json['pesticide_id']),
      rate: serializer.fromJson<double>(json['rate']),
      rateUnit: serializer.fromJson<String>(json['rate_unit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'record_id': serializer.toJson<int>(recordId),
      'pesticide_id': serializer.toJson<int>(pesticideId),
      'rate': serializer.toJson<double>(rate),
      'rate_unit': serializer.toJson<String>(rateUnit),
    };
  }

  RecordPesticideData copyWith({
    int? recordId,
    int? pesticideId,
    double? rate,
    String? rateUnit,
  }) => RecordPesticideData(
    recordId: recordId ?? this.recordId,
    pesticideId: pesticideId ?? this.pesticideId,
    rate: rate ?? this.rate,
    rateUnit: rateUnit ?? this.rateUnit,
  );
  RecordPesticideData copyWithCompanion(RecordPesticideCompanion data) {
    return RecordPesticideData(
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      pesticideId:
          data.pesticideId.present ? data.pesticideId.value : this.pesticideId,
      rate: data.rate.present ? data.rate.value : this.rate,
      rateUnit: data.rateUnit.present ? data.rateUnit.value : this.rateUnit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecordPesticideData(')
          ..write('recordId: $recordId, ')
          ..write('pesticideId: $pesticideId, ')
          ..write('rate: $rate, ')
          ..write('rateUnit: $rateUnit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(recordId, pesticideId, rate, rateUnit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecordPesticideData &&
          other.recordId == this.recordId &&
          other.pesticideId == this.pesticideId &&
          other.rate == this.rate &&
          other.rateUnit == this.rateUnit);
}

class RecordPesticideCompanion extends UpdateCompanion<RecordPesticideData> {
  final Value<int> recordId;
  final Value<int> pesticideId;
  final Value<double> rate;
  final Value<String> rateUnit;
  final Value<int> rowid;
  const RecordPesticideCompanion({
    this.recordId = const Value.absent(),
    this.pesticideId = const Value.absent(),
    this.rate = const Value.absent(),
    this.rateUnit = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecordPesticideCompanion.insert({
    required int recordId,
    required int pesticideId,
    required double rate,
    required String rateUnit,
    this.rowid = const Value.absent(),
  }) : recordId = Value(recordId),
       pesticideId = Value(pesticideId),
       rate = Value(rate),
       rateUnit = Value(rateUnit);
  static Insertable<RecordPesticideData> custom({
    Expression<int>? recordId,
    Expression<int>? pesticideId,
    Expression<double>? rate,
    Expression<String>? rateUnit,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (recordId != null) 'record_id': recordId,
      if (pesticideId != null) 'pesticide_id': pesticideId,
      if (rate != null) 'rate': rate,
      if (rateUnit != null) 'rate_unit': rateUnit,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecordPesticideCompanion copyWith({
    Value<int>? recordId,
    Value<int>? pesticideId,
    Value<double>? rate,
    Value<String>? rateUnit,
    Value<int>? rowid,
  }) {
    return RecordPesticideCompanion(
      recordId: recordId ?? this.recordId,
      pesticideId: pesticideId ?? this.pesticideId,
      rate: rate ?? this.rate,
      rateUnit: rateUnit ?? this.rateUnit,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (recordId.present) {
      map['record_id'] = Variable<int>(recordId.value);
    }
    if (pesticideId.present) {
      map['pesticide_id'] = Variable<int>(pesticideId.value);
    }
    if (rate.present) {
      map['rate'] = Variable<double>(rate.value);
    }
    if (rateUnit.present) {
      map['rate_unit'] = Variable<String>(rateUnit.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecordPesticideCompanion(')
          ..write('recordId: $recordId, ')
          ..write('pesticideId: $pesticideId, ')
          ..write('rate: $rate, ')
          ..write('rateUnit: $rateUnit, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class RecordViewData extends DataClass {
  final int id;
  final DateTime startTimestamp;
  final DateTime endTimestamp;
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
  const RecordViewData({
    required this.id,
    required this.startTimestamp,
    required this.endTimestamp,
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
    required this.notes,
  });
  factory RecordViewData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecordViewData(
      id: serializer.fromJson<int>(json['id']),
      startTimestamp: serializer.fromJson<DateTime>(json['start_timestamp']),
      endTimestamp: serializer.fromJson<DateTime>(json['end_timestamp']),
      applicatorId: serializer.fromJson<int>(json['applicator_id']),
      applicatorName: serializer.fromJson<String?>(json['applicator_name']),
      customerId: serializer.fromJson<int>(json['customer_id']),
      customerName: serializer.fromJson<String?>(json['customer_name']),
      customerInformedOfRei: serializer.fromJson<bool>(
        json['customer_informed_of_rei'],
      ),
      fieldName: serializer.fromJson<String>(json['field_name']),
      crop: serializer.fromJson<String>(json['crop']),
      totalArea: serializer.fromJson<double>(json['total_area']),
      pricePerAcre: serializer.fromJson<double>(json['price_per_acre']),
      sprayVolume: serializer.fromJson<double>(json['spray_volume']),
      windSpeedBefore: serializer.fromJson<double?>(json['wind_speed_before']),
      windSpeedAfter: serializer.fromJson<double?>(json['wind_speed_after']),
      windDirection: serializer.fromJson<String?>(json['wind_direction']),
      temperature: serializer.fromJson<double?>(json['temperature']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'start_timestamp': serializer.toJson<DateTime>(startTimestamp),
      'end_timestamp': serializer.toJson<DateTime>(endTimestamp),
      'applicator_id': serializer.toJson<int>(applicatorId),
      'applicator_name': serializer.toJson<String?>(applicatorName),
      'customer_id': serializer.toJson<int>(customerId),
      'customer_name': serializer.toJson<String?>(customerName),
      'customer_informed_of_rei': serializer.toJson<bool>(
        customerInformedOfRei,
      ),
      'field_name': serializer.toJson<String>(fieldName),
      'crop': serializer.toJson<String>(crop),
      'total_area': serializer.toJson<double>(totalArea),
      'price_per_acre': serializer.toJson<double>(pricePerAcre),
      'spray_volume': serializer.toJson<double>(sprayVolume),
      'wind_speed_before': serializer.toJson<double?>(windSpeedBefore),
      'wind_speed_after': serializer.toJson<double?>(windSpeedAfter),
      'wind_direction': serializer.toJson<String?>(windDirection),
      'temperature': serializer.toJson<double?>(temperature),
      'notes': serializer.toJson<String>(notes),
    };
  }

  RecordViewData copyWith({
    int? id,
    DateTime? startTimestamp,
    DateTime? endTimestamp,
    int? applicatorId,
    Value<String?> applicatorName = const Value.absent(),
    int? customerId,
    Value<String?> customerName = const Value.absent(),
    bool? customerInformedOfRei,
    String? fieldName,
    String? crop,
    double? totalArea,
    double? pricePerAcre,
    double? sprayVolume,
    Value<double?> windSpeedBefore = const Value.absent(),
    Value<double?> windSpeedAfter = const Value.absent(),
    Value<String?> windDirection = const Value.absent(),
    Value<double?> temperature = const Value.absent(),
    String? notes,
  }) => RecordViewData(
    id: id ?? this.id,
    startTimestamp: startTimestamp ?? this.startTimestamp,
    endTimestamp: endTimestamp ?? this.endTimestamp,
    applicatorId: applicatorId ?? this.applicatorId,
    applicatorName:
        applicatorName.present ? applicatorName.value : this.applicatorName,
    customerId: customerId ?? this.customerId,
    customerName: customerName.present ? customerName.value : this.customerName,
    customerInformedOfRei: customerInformedOfRei ?? this.customerInformedOfRei,
    fieldName: fieldName ?? this.fieldName,
    crop: crop ?? this.crop,
    totalArea: totalArea ?? this.totalArea,
    pricePerAcre: pricePerAcre ?? this.pricePerAcre,
    sprayVolume: sprayVolume ?? this.sprayVolume,
    windSpeedBefore:
        windSpeedBefore.present ? windSpeedBefore.value : this.windSpeedBefore,
    windSpeedAfter:
        windSpeedAfter.present ? windSpeedAfter.value : this.windSpeedAfter,
    windDirection:
        windDirection.present ? windDirection.value : this.windDirection,
    temperature: temperature.present ? temperature.value : this.temperature,
    notes: notes ?? this.notes,
  );
  @override
  String toString() {
    return (StringBuffer('RecordViewData(')
          ..write('id: $id, ')
          ..write('startTimestamp: $startTimestamp, ')
          ..write('endTimestamp: $endTimestamp, ')
          ..write('applicatorId: $applicatorId, ')
          ..write('applicatorName: $applicatorName, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('customerInformedOfRei: $customerInformedOfRei, ')
          ..write('fieldName: $fieldName, ')
          ..write('crop: $crop, ')
          ..write('totalArea: $totalArea, ')
          ..write('pricePerAcre: $pricePerAcre, ')
          ..write('sprayVolume: $sprayVolume, ')
          ..write('windSpeedBefore: $windSpeedBefore, ')
          ..write('windSpeedAfter: $windSpeedAfter, ')
          ..write('windDirection: $windDirection, ')
          ..write('temperature: $temperature, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startTimestamp,
    endTimestamp,
    applicatorId,
    applicatorName,
    customerId,
    customerName,
    customerInformedOfRei,
    fieldName,
    crop,
    totalArea,
    pricePerAcre,
    sprayVolume,
    windSpeedBefore,
    windSpeedAfter,
    windDirection,
    temperature,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecordViewData &&
          other.id == this.id &&
          other.startTimestamp == this.startTimestamp &&
          other.endTimestamp == this.endTimestamp &&
          other.applicatorId == this.applicatorId &&
          other.applicatorName == this.applicatorName &&
          other.customerId == this.customerId &&
          other.customerName == this.customerName &&
          other.customerInformedOfRei == this.customerInformedOfRei &&
          other.fieldName == this.fieldName &&
          other.crop == this.crop &&
          other.totalArea == this.totalArea &&
          other.pricePerAcre == this.pricePerAcre &&
          other.sprayVolume == this.sprayVolume &&
          other.windSpeedBefore == this.windSpeedBefore &&
          other.windSpeedAfter == this.windSpeedAfter &&
          other.windDirection == this.windDirection &&
          other.temperature == this.temperature &&
          other.notes == this.notes);
}

class RecordView extends ViewInfo<RecordView, RecordViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  RecordView(this.attachedDatabase, [this._alias]);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startTimestamp,
    endTimestamp,
    applicatorId,
    applicatorName,
    customerId,
    customerName,
    customerInformedOfRei,
    fieldName,
    crop,
    totalArea,
    pricePerAcre,
    sprayVolume,
    windSpeedBefore,
    windSpeedAfter,
    windDirection,
    temperature,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'record_view';
  @override
  Map<SqlDialect, String> get createViewStatements => {
    SqlDialect.sqlite:
        'CREATE VIEW record_view AS SELECT record.id, record.start_timestamp, record.end_timestamp, record.applicator_id, applicator.name AS applicator_name, record.customer_id, customer.name AS customer_name, record.customer_informed_of_rei, record.field_name, record.crop, record.total_area, record.price_per_acre, record.spray_volume, record.wind_speed_before, record.wind_speed_after, record.wind_direction, record.temperature, record.notes FROM record LEFT JOIN applicator ON record.applicator_id = applicator.id LEFT JOIN customer ON record.customer_id = customer.id ORDER BY record.start_timestamp DESC',
  };
  @override
  RecordView get asDslTable => this;
  @override
  RecordViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecordViewData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      startTimestamp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}start_timestamp'],
          )!,
      endTimestamp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}end_timestamp'],
          )!,
      applicatorId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}applicator_id'],
          )!,
      applicatorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}applicator_name'],
      ),
      customerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}customer_id'],
          )!,
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      ),
      customerInformedOfRei:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}customer_informed_of_rei'],
          )!,
      fieldName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}field_name'],
          )!,
      crop:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}crop'],
          )!,
      totalArea:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}total_area'],
          )!,
      pricePerAcre:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}price_per_acre'],
          )!,
      sprayVolume:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}spray_volume'],
          )!,
      windSpeedBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wind_speed_before'],
      ),
      windSpeedAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wind_speed_after'],
      ),
      windDirection: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wind_direction'],
      ),
      temperature: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature'],
      ),
      notes:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}notes'],
          )!,
    );
  }

  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<DateTime> startTimestamp =
      GeneratedColumn<DateTime>(
        'start_timestamp',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
      );
  late final GeneratedColumn<DateTime> endTimestamp = GeneratedColumn<DateTime>(
    'end_timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
  );
  late final GeneratedColumn<int> applicatorId = GeneratedColumn<int>(
    'applicator_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<String> applicatorName = GeneratedColumn<String>(
    'applicator_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<bool> customerInformedOfRei =
      GeneratedColumn<bool>(
        'customer_informed_of_rei',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("customer_informed_of_rei" IN (0, 1))',
        ),
      );
  late final GeneratedColumn<String> fieldName = GeneratedColumn<String>(
    'field_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<String> crop = GeneratedColumn<String>(
    'crop',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<double> totalArea = GeneratedColumn<double>(
    'total_area',
    aliasedName,
    false,
    type: DriftSqlType.double,
  );
  late final GeneratedColumn<double> pricePerAcre = GeneratedColumn<double>(
    'price_per_acre',
    aliasedName,
    false,
    type: DriftSqlType.double,
  );
  late final GeneratedColumn<double> sprayVolume = GeneratedColumn<double>(
    'spray_volume',
    aliasedName,
    false,
    type: DriftSqlType.double,
  );
  late final GeneratedColumn<double> windSpeedBefore = GeneratedColumn<double>(
    'wind_speed_before',
    aliasedName,
    true,
    type: DriftSqlType.double,
  );
  late final GeneratedColumn<double> windSpeedAfter = GeneratedColumn<double>(
    'wind_speed_after',
    aliasedName,
    true,
    type: DriftSqlType.double,
  );
  late final GeneratedColumn<String> windDirection = GeneratedColumn<String>(
    'wind_direction',
    aliasedName,
    true,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
    'temperature',
    aliasedName,
    true,
    type: DriftSqlType.double,
  );
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  @override
  RecordView createAlias(String alias) {
    return RecordView(attachedDatabase, alias);
  }

  @override
  Query? get query => null;
  @override
  Set<String> get readTables => const {'record', 'applicator', 'customer'};
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final Applicator applicator = Applicator(this);
  late final Customer customer = Customer(this);
  late final Record record = Record(this);
  late final Pesticide pesticide = Pesticide(this);
  late final RecordPesticide recordPesticide = RecordPesticide(this);
  late final RecordView recordView = RecordView(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    applicator,
    customer,
    record,
    pesticide,
    recordPesticide,
    recordView,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'record',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('record_pesticide', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pesticide',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('record_pesticide', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $ApplicatorCreateCompanionBuilder =
    ApplicatorCompanion Function({
      Value<int> id,
      required String name,
      required String licenseNumber,
    });
typedef $ApplicatorUpdateCompanionBuilder =
    ApplicatorCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> licenseNumber,
    });

class $ApplicatorFilterComposer extends Composer<_$AppDatabase, Applicator> {
  $ApplicatorFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licenseNumber => $composableBuilder(
    column: $table.licenseNumber,
    builder: (column) => ColumnFilters(column),
  );
}

class $ApplicatorOrderingComposer extends Composer<_$AppDatabase, Applicator> {
  $ApplicatorOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licenseNumber => $composableBuilder(
    column: $table.licenseNumber,
    builder: (column) => ColumnOrderings(column),
  );
}

class $ApplicatorAnnotationComposer
    extends Composer<_$AppDatabase, Applicator> {
  $ApplicatorAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get licenseNumber => $composableBuilder(
    column: $table.licenseNumber,
    builder: (column) => column,
  );
}

class $ApplicatorTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Applicator,
          ApplicatorData,
          $ApplicatorFilterComposer,
          $ApplicatorOrderingComposer,
          $ApplicatorAnnotationComposer,
          $ApplicatorCreateCompanionBuilder,
          $ApplicatorUpdateCompanionBuilder,
          (
            ApplicatorData,
            BaseReferences<_$AppDatabase, Applicator, ApplicatorData>,
          ),
          ApplicatorData,
          PrefetchHooks Function()
        > {
  $ApplicatorTableManager(_$AppDatabase db, Applicator table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $ApplicatorFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $ApplicatorOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $ApplicatorAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> licenseNumber = const Value.absent(),
              }) => ApplicatorCompanion(
                id: id,
                name: name,
                licenseNumber: licenseNumber,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String licenseNumber,
              }) => ApplicatorCompanion.insert(
                id: id,
                name: name,
                licenseNumber: licenseNumber,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $ApplicatorProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Applicator,
      ApplicatorData,
      $ApplicatorFilterComposer,
      $ApplicatorOrderingComposer,
      $ApplicatorAnnotationComposer,
      $ApplicatorCreateCompanionBuilder,
      $ApplicatorUpdateCompanionBuilder,
      (
        ApplicatorData,
        BaseReferences<_$AppDatabase, Applicator, ApplicatorData>,
      ),
      ApplicatorData,
      PrefetchHooks Function()
    >;
typedef $CustomerCreateCompanionBuilder =
    CustomerCompanion Function({
      Value<int> id,
      required String name,
      required String streetAddress,
      required String city,
      required String state,
      required String zipCode,
    });
typedef $CustomerUpdateCompanionBuilder =
    CustomerCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> streetAddress,
      Value<String> city,
      Value<String> state,
      Value<String> zipCode,
    });

class $CustomerFilterComposer extends Composer<_$AppDatabase, Customer> {
  $CustomerFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get streetAddress => $composableBuilder(
    column: $table.streetAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get zipCode => $composableBuilder(
    column: $table.zipCode,
    builder: (column) => ColumnFilters(column),
  );
}

class $CustomerOrderingComposer extends Composer<_$AppDatabase, Customer> {
  $CustomerOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get streetAddress => $composableBuilder(
    column: $table.streetAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get zipCode => $composableBuilder(
    column: $table.zipCode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $CustomerAnnotationComposer extends Composer<_$AppDatabase, Customer> {
  $CustomerAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get streetAddress => $composableBuilder(
    column: $table.streetAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get zipCode =>
      $composableBuilder(column: $table.zipCode, builder: (column) => column);
}

class $CustomerTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Customer,
          CustomerData,
          $CustomerFilterComposer,
          $CustomerOrderingComposer,
          $CustomerAnnotationComposer,
          $CustomerCreateCompanionBuilder,
          $CustomerUpdateCompanionBuilder,
          (CustomerData, BaseReferences<_$AppDatabase, Customer, CustomerData>),
          CustomerData,
          PrefetchHooks Function()
        > {
  $CustomerTableManager(_$AppDatabase db, Customer table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $CustomerFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $CustomerOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $CustomerAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> streetAddress = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String> zipCode = const Value.absent(),
              }) => CustomerCompanion(
                id: id,
                name: name,
                streetAddress: streetAddress,
                city: city,
                state: state,
                zipCode: zipCode,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String streetAddress,
                required String city,
                required String state,
                required String zipCode,
              }) => CustomerCompanion.insert(
                id: id,
                name: name,
                streetAddress: streetAddress,
                city: city,
                state: state,
                zipCode: zipCode,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $CustomerProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Customer,
      CustomerData,
      $CustomerFilterComposer,
      $CustomerOrderingComposer,
      $CustomerAnnotationComposer,
      $CustomerCreateCompanionBuilder,
      $CustomerUpdateCompanionBuilder,
      (CustomerData, BaseReferences<_$AppDatabase, Customer, CustomerData>),
      CustomerData,
      PrefetchHooks Function()
    >;
typedef $RecordCreateCompanionBuilder =
    RecordCompanion Function({
      Value<int> id,
      required DateTime startTimestamp,
      required DateTime endTimestamp,
      required int applicatorId,
      required int customerId,
      required bool customerInformedOfRei,
      required String fieldName,
      required String crop,
      required double totalArea,
      required double pricePerAcre,
      required double sprayVolume,
      Value<double?> windSpeedBefore,
      Value<double?> windSpeedAfter,
      Value<String?> windDirection,
      Value<double?> temperature,
      required String notes,
    });
typedef $RecordUpdateCompanionBuilder =
    RecordCompanion Function({
      Value<int> id,
      Value<DateTime> startTimestamp,
      Value<DateTime> endTimestamp,
      Value<int> applicatorId,
      Value<int> customerId,
      Value<bool> customerInformedOfRei,
      Value<String> fieldName,
      Value<String> crop,
      Value<double> totalArea,
      Value<double> pricePerAcre,
      Value<double> sprayVolume,
      Value<double?> windSpeedBefore,
      Value<double?> windSpeedAfter,
      Value<String?> windDirection,
      Value<double?> temperature,
      Value<String> notes,
    });

class $RecordFilterComposer extends Composer<_$AppDatabase, Record> {
  $RecordFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTimestamp => $composableBuilder(
    column: $table.startTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTimestamp => $composableBuilder(
    column: $table.endTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get applicatorId => $composableBuilder(
    column: $table.applicatorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get customerInformedOfRei => $composableBuilder(
    column: $table.customerInformedOfRei,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldName => $composableBuilder(
    column: $table.fieldName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get crop => $composableBuilder(
    column: $table.crop,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalArea => $composableBuilder(
    column: $table.totalArea,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pricePerAcre => $composableBuilder(
    column: $table.pricePerAcre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sprayVolume => $composableBuilder(
    column: $table.sprayVolume,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get windSpeedBefore => $composableBuilder(
    column: $table.windSpeedBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get windSpeedAfter => $composableBuilder(
    column: $table.windSpeedAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get windDirection => $composableBuilder(
    column: $table.windDirection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $RecordOrderingComposer extends Composer<_$AppDatabase, Record> {
  $RecordOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTimestamp => $composableBuilder(
    column: $table.startTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTimestamp => $composableBuilder(
    column: $table.endTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get applicatorId => $composableBuilder(
    column: $table.applicatorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get customerInformedOfRei => $composableBuilder(
    column: $table.customerInformedOfRei,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldName => $composableBuilder(
    column: $table.fieldName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get crop => $composableBuilder(
    column: $table.crop,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalArea => $composableBuilder(
    column: $table.totalArea,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pricePerAcre => $composableBuilder(
    column: $table.pricePerAcre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sprayVolume => $composableBuilder(
    column: $table.sprayVolume,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get windSpeedBefore => $composableBuilder(
    column: $table.windSpeedBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get windSpeedAfter => $composableBuilder(
    column: $table.windSpeedAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get windDirection => $composableBuilder(
    column: $table.windDirection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $RecordAnnotationComposer extends Composer<_$AppDatabase, Record> {
  $RecordAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTimestamp => $composableBuilder(
    column: $table.startTimestamp,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get endTimestamp => $composableBuilder(
    column: $table.endTimestamp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get applicatorId => $composableBuilder(
    column: $table.applicatorId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get customerInformedOfRei => $composableBuilder(
    column: $table.customerInformedOfRei,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fieldName =>
      $composableBuilder(column: $table.fieldName, builder: (column) => column);

  GeneratedColumn<String> get crop =>
      $composableBuilder(column: $table.crop, builder: (column) => column);

  GeneratedColumn<double> get totalArea =>
      $composableBuilder(column: $table.totalArea, builder: (column) => column);

  GeneratedColumn<double> get pricePerAcre => $composableBuilder(
    column: $table.pricePerAcre,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sprayVolume => $composableBuilder(
    column: $table.sprayVolume,
    builder: (column) => column,
  );

  GeneratedColumn<double> get windSpeedBefore => $composableBuilder(
    column: $table.windSpeedBefore,
    builder: (column) => column,
  );

  GeneratedColumn<double> get windSpeedAfter => $composableBuilder(
    column: $table.windSpeedAfter,
    builder: (column) => column,
  );

  GeneratedColumn<String> get windDirection => $composableBuilder(
    column: $table.windDirection,
    builder: (column) => column,
  );

  GeneratedColumn<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $RecordTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Record,
          RecordData,
          $RecordFilterComposer,
          $RecordOrderingComposer,
          $RecordAnnotationComposer,
          $RecordCreateCompanionBuilder,
          $RecordUpdateCompanionBuilder,
          (RecordData, BaseReferences<_$AppDatabase, Record, RecordData>),
          RecordData,
          PrefetchHooks Function()
        > {
  $RecordTableManager(_$AppDatabase db, Record table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $RecordFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $RecordOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $RecordAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> startTimestamp = const Value.absent(),
                Value<DateTime> endTimestamp = const Value.absent(),
                Value<int> applicatorId = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<bool> customerInformedOfRei = const Value.absent(),
                Value<String> fieldName = const Value.absent(),
                Value<String> crop = const Value.absent(),
                Value<double> totalArea = const Value.absent(),
                Value<double> pricePerAcre = const Value.absent(),
                Value<double> sprayVolume = const Value.absent(),
                Value<double?> windSpeedBefore = const Value.absent(),
                Value<double?> windSpeedAfter = const Value.absent(),
                Value<String?> windDirection = const Value.absent(),
                Value<double?> temperature = const Value.absent(),
                Value<String> notes = const Value.absent(),
              }) => RecordCompanion(
                id: id,
                startTimestamp: startTimestamp,
                endTimestamp: endTimestamp,
                applicatorId: applicatorId,
                customerId: customerId,
                customerInformedOfRei: customerInformedOfRei,
                fieldName: fieldName,
                crop: crop,
                totalArea: totalArea,
                pricePerAcre: pricePerAcre,
                sprayVolume: sprayVolume,
                windSpeedBefore: windSpeedBefore,
                windSpeedAfter: windSpeedAfter,
                windDirection: windDirection,
                temperature: temperature,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime startTimestamp,
                required DateTime endTimestamp,
                required int applicatorId,
                required int customerId,
                required bool customerInformedOfRei,
                required String fieldName,
                required String crop,
                required double totalArea,
                required double pricePerAcre,
                required double sprayVolume,
                Value<double?> windSpeedBefore = const Value.absent(),
                Value<double?> windSpeedAfter = const Value.absent(),
                Value<String?> windDirection = const Value.absent(),
                Value<double?> temperature = const Value.absent(),
                required String notes,
              }) => RecordCompanion.insert(
                id: id,
                startTimestamp: startTimestamp,
                endTimestamp: endTimestamp,
                applicatorId: applicatorId,
                customerId: customerId,
                customerInformedOfRei: customerInformedOfRei,
                fieldName: fieldName,
                crop: crop,
                totalArea: totalArea,
                pricePerAcre: pricePerAcre,
                sprayVolume: sprayVolume,
                windSpeedBefore: windSpeedBefore,
                windSpeedAfter: windSpeedAfter,
                windDirection: windDirection,
                temperature: temperature,
                notes: notes,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $RecordProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Record,
      RecordData,
      $RecordFilterComposer,
      $RecordOrderingComposer,
      $RecordAnnotationComposer,
      $RecordCreateCompanionBuilder,
      $RecordUpdateCompanionBuilder,
      (RecordData, BaseReferences<_$AppDatabase, Record, RecordData>),
      RecordData,
      PrefetchHooks Function()
    >;
typedef $PesticideCreateCompanionBuilder =
    PesticideCompanion Function({
      Value<int> id,
      required String name,
      required String registrationNumber,
    });
typedef $PesticideUpdateCompanionBuilder =
    PesticideCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> registrationNumber,
    });

class $PesticideFilterComposer extends Composer<_$AppDatabase, Pesticide> {
  $PesticideFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get registrationNumber => $composableBuilder(
    column: $table.registrationNumber,
    builder: (column) => ColumnFilters(column),
  );
}

class $PesticideOrderingComposer extends Composer<_$AppDatabase, Pesticide> {
  $PesticideOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get registrationNumber => $composableBuilder(
    column: $table.registrationNumber,
    builder: (column) => ColumnOrderings(column),
  );
}

class $PesticideAnnotationComposer extends Composer<_$AppDatabase, Pesticide> {
  $PesticideAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get registrationNumber => $composableBuilder(
    column: $table.registrationNumber,
    builder: (column) => column,
  );
}

class $PesticideTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          Pesticide,
          PesticideData,
          $PesticideFilterComposer,
          $PesticideOrderingComposer,
          $PesticideAnnotationComposer,
          $PesticideCreateCompanionBuilder,
          $PesticideUpdateCompanionBuilder,
          (
            PesticideData,
            BaseReferences<_$AppDatabase, Pesticide, PesticideData>,
          ),
          PesticideData,
          PrefetchHooks Function()
        > {
  $PesticideTableManager(_$AppDatabase db, Pesticide table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $PesticideFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $PesticideOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $PesticideAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> registrationNumber = const Value.absent(),
              }) => PesticideCompanion(
                id: id,
                name: name,
                registrationNumber: registrationNumber,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String registrationNumber,
              }) => PesticideCompanion.insert(
                id: id,
                name: name,
                registrationNumber: registrationNumber,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $PesticideProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      Pesticide,
      PesticideData,
      $PesticideFilterComposer,
      $PesticideOrderingComposer,
      $PesticideAnnotationComposer,
      $PesticideCreateCompanionBuilder,
      $PesticideUpdateCompanionBuilder,
      (PesticideData, BaseReferences<_$AppDatabase, Pesticide, PesticideData>),
      PesticideData,
      PrefetchHooks Function()
    >;
typedef $RecordPesticideCreateCompanionBuilder =
    RecordPesticideCompanion Function({
      required int recordId,
      required int pesticideId,
      required double rate,
      required String rateUnit,
      Value<int> rowid,
    });
typedef $RecordPesticideUpdateCompanionBuilder =
    RecordPesticideCompanion Function({
      Value<int> recordId,
      Value<int> pesticideId,
      Value<double> rate,
      Value<String> rateUnit,
      Value<int> rowid,
    });

class $RecordPesticideFilterComposer
    extends Composer<_$AppDatabase, RecordPesticide> {
  $RecordPesticideFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pesticideId => $composableBuilder(
    column: $table.pesticideId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rateUnit => $composableBuilder(
    column: $table.rateUnit,
    builder: (column) => ColumnFilters(column),
  );
}

class $RecordPesticideOrderingComposer
    extends Composer<_$AppDatabase, RecordPesticide> {
  $RecordPesticideOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pesticideId => $composableBuilder(
    column: $table.pesticideId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rateUnit => $composableBuilder(
    column: $table.rateUnit,
    builder: (column) => ColumnOrderings(column),
  );
}

class $RecordPesticideAnnotationComposer
    extends Composer<_$AppDatabase, RecordPesticide> {
  $RecordPesticideAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<int> get pesticideId => $composableBuilder(
    column: $table.pesticideId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<String> get rateUnit =>
      $composableBuilder(column: $table.rateUnit, builder: (column) => column);
}

class $RecordPesticideTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          RecordPesticide,
          RecordPesticideData,
          $RecordPesticideFilterComposer,
          $RecordPesticideOrderingComposer,
          $RecordPesticideAnnotationComposer,
          $RecordPesticideCreateCompanionBuilder,
          $RecordPesticideUpdateCompanionBuilder,
          (
            RecordPesticideData,
            BaseReferences<_$AppDatabase, RecordPesticide, RecordPesticideData>,
          ),
          RecordPesticideData,
          PrefetchHooks Function()
        > {
  $RecordPesticideTableManager(_$AppDatabase db, RecordPesticide table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $RecordPesticideFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $RecordPesticideOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $RecordPesticideAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> recordId = const Value.absent(),
                Value<int> pesticideId = const Value.absent(),
                Value<double> rate = const Value.absent(),
                Value<String> rateUnit = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecordPesticideCompanion(
                recordId: recordId,
                pesticideId: pesticideId,
                rate: rate,
                rateUnit: rateUnit,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int recordId,
                required int pesticideId,
                required double rate,
                required String rateUnit,
                Value<int> rowid = const Value.absent(),
              }) => RecordPesticideCompanion.insert(
                recordId: recordId,
                pesticideId: pesticideId,
                rate: rate,
                rateUnit: rateUnit,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $RecordPesticideProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      RecordPesticide,
      RecordPesticideData,
      $RecordPesticideFilterComposer,
      $RecordPesticideOrderingComposer,
      $RecordPesticideAnnotationComposer,
      $RecordPesticideCreateCompanionBuilder,
      $RecordPesticideUpdateCompanionBuilder,
      (
        RecordPesticideData,
        BaseReferences<_$AppDatabase, RecordPesticide, RecordPesticideData>,
      ),
      RecordPesticideData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $ApplicatorTableManager get applicator =>
      $ApplicatorTableManager(_db, _db.applicator);
  $CustomerTableManager get customer =>
      $CustomerTableManager(_db, _db.customer);
  $RecordTableManager get record => $RecordTableManager(_db, _db.record);
  $PesticideTableManager get pesticide =>
      $PesticideTableManager(_db, _db.pesticide);
  $RecordPesticideTableManager get recordPesticide =>
      $RecordPesticideTableManager(_db, _db.recordPesticide);
}
