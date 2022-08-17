import 'package:json_annotation/json_annotation.dart';
import 'package:world_clocks/core/utils/base/base_model.dart';

part 'timezone_model.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class TimezoneModel extends BaseModel {
  String? abbreviation;
  String? clientIp;
  String? datetime;
  int? dayOfWeek;
  int? dayOfYear;
  bool? dst;
  String? dstFrom;
  int? dstOffset;
  String? dstUntil;
  int? rawOffset;
  String? timezone;
  int? unixtime;
  String? utcDatetime;
  String? utcOffset;
  int? weekNumber;

  TimezoneModel(
      {this.abbreviation,
      this.clientIp,
      this.datetime,
      this.dayOfWeek,
      this.dayOfYear,
      this.dst,
      this.dstFrom,
      this.dstOffset,
      this.dstUntil,
      this.rawOffset,
      this.timezone,
      this.unixtime,
      this.utcDatetime,
      this.utcOffset,
      this.weekNumber});

  @override
  fromJson(Map<String, dynamic> json) {
    return _$TimezoneModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
