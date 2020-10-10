import 'package:json_annotation/json_annotation.dart';
part 'date_range.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DateRange {
  DateTime fromDate;
  DateTime toDate;

  DateRange({
    this.fromDate,
    this.toDate,
  });

  factory DateRange.fromJson(Map<String, dynamic> json) =>
      _$DateRangeFromJson(json);
  Map<String, dynamic> toJson() => _$DateRangeToJson(this);
}
