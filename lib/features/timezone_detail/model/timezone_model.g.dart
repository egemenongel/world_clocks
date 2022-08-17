// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timezone_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimezoneModel _$TimezoneModelFromJson(Map<String, dynamic> json) =>
    TimezoneModel(
      abbreviation: json['abbreviation'] as String?,
      clientIp: json['client_ip'] as String?,
      datetime: json['datetime'] as String?,
      dayOfWeek: json['day_of_week'] as int?,
      dayOfYear: json['day_of_year'] as int?,
      dst: json['dst'] as bool?,
      dstFrom: json['dst_from'] as String?,
      dstOffset: json['dst_offset'] as int?,
      dstUntil: json['dst_until'] as String?,
      rawOffset: json['raw_offset'] as int?,
      timezone: json['timezone'] as String?,
      unixtime: json['unixtime'] as int?,
      utcDatetime: json['utc_datetime'] as String?,
      utcOffset: json['utc_offset'] as String?,
      weekNumber: json['week_number'] as int?,
    );
