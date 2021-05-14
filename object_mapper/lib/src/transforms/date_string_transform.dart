import '../transformable.dart';

class DateStringTransform implements Transformable<DateTime?, String?> {
  DateStringTransform();

  //
  @override
  DateTime? fromJson(value) {
    try {
      if (value == null) return null;
      if (value is String) return DateTime.parse(value);
      if (value is int && value < 0)
        return DateTime.fromMillisecondsSinceEpoch(value);
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  String? toJson(DateTime? value) {
    if (value == null) return null;

    return value.toUtc().toIso8601String();
  }
}
