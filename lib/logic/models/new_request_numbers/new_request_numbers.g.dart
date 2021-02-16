// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_request_numbers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewRequestNumbers _$NewRequestNumbersFromJson(Map<String, dynamic> json) {
  return NewRequestNumbers(
    numberOfNewRequests: json['number_of_new_requests'] as int,
    numberOfNewAcceptedRequests: json['number_of_new_accepted_requests'] as int,
    numberOfNewRejectedRequests: json['number_of_new_rejected_requests'] as int,
    totalNumberOfUpdates: json['total_number_of_updates'] as int,
  );
}

Map<String, dynamic> _$NewRequestNumbersToJson(NewRequestNumbers instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('number_of_new_requests', instance.numberOfNewRequests);
  writeNotNull(
      'number_of_new_accepted_requests', instance.numberOfNewAcceptedRequests);
  writeNotNull(
      'number_of_new_rejected_requests', instance.numberOfNewRejectedRequests);
  writeNotNull('total_number_of_updates', instance.totalNumberOfUpdates);
  return val;
}
