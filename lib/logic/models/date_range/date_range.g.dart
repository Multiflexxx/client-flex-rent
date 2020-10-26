// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_range.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateRange _$DateRangeFromJson(Map<String, dynamic> json) {
  return DateRange(
    fromDate: json['from_date'] == null
        ? null
        : DateTime.parse(json['from_date'] as String),
    toDate: json['to_date'] == null
        ? null
        : DateTime.parse(json['to_date'] as String),
    blockedByLessor: json['blocked_by_lessor'] as bool,
  );
}

Map<String, dynamic> _$DateRangeToJson(DateRange instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('from_date', instance.fromDate?.toIso8601String());
  writeNotNull('to_date', instance.toDate?.toIso8601String());
  writeNotNull('blocked_by_lessor', instance.blockedByLessor);
  return val;
}
