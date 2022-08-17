class ApiConstants {
  static const json = 'application/json';
  static const file = 'multipart/form-data';

  static const baseUrl = 'http://worldtimeapi.org/api';
  static const timezone = '/timezone';
  static selectedTimezone(String selected) => '$timezone/$selected';
}
