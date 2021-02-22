// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_request_numbers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewRequestNumbers _$NewRequestNumbersFromJson(Map<String, dynamic> json) {
  return NewRequestNumbers(
    lessorsNumberOfNewRequests: json['lessors_number_of_new_requests'] as int,
    lesseesNumberOfNewAcceptedRequests:
        json['lessees_number_of_new_accepted_requests'] as int,
    lesseesNumberOfNewRejectedRequests:
        json['lessees_number_of_new_rejected_requests'] as int,
    lesseesTotalNumberOfUpdates: json['lessees_total_number_of_updates'] as int,
  );
}

Map<String, dynamic> _$NewRequestNumbersToJson(NewRequestNumbers instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'lessors_number_of_new_requests', instance.lessorsNumberOfNewRequests);
  writeNotNull('lessees_number_of_new_accepted_requests',
      instance.lesseesNumberOfNewAcceptedRequests);
  writeNotNull('lessees_number_of_new_rejected_requests',
      instance.lesseesNumberOfNewRejectedRequests);
  writeNotNull(
      'lessees_total_number_of_updates', instance.lesseesTotalNumberOfUpdates);
  return val;
}
