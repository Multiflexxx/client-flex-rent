import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'date_range.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DateRange extends Equatable {
  final DateTime fromDate;
  final DateTime toDate;

  DateRange({
    this.fromDate,
    this.toDate,
  });

  factory DateRange.fromJson(Map<String, dynamic> json) =>
      _$DateRangeFromJson(json);
  Map<String, dynamic> toJson() => _$DateRangeToJson(this);

  @override
  List<Object> get props => [fromDate, toDate];
}
