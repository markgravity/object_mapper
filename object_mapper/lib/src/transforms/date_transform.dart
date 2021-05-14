import '../transformable.dart';
import '../enumerable.dart';

class DateUnit extends Enumerable<int> {
  @override
  final int rawValue;

  @override
  const DateUnit({required this.rawValue});

  //
  static const seconds = DateUnit(rawValue: 1000);
  static const milliseconds = DateUnit(rawValue: 1);

  double addScale(double interval) {
    return interval * rawValue;
  }

  double removeScale(double interval) {
    return interval / rawValue;
  }
}

class DateTransform implements Transformable<DateTime?, double?> {
  final DateUnit unit;
  const DateTransform({this.unit = DateUnit.seconds});

  //
  @override
  DateTime? fromJson(value) {
    try {
      if (value == null) return null;
      if (value is String) return DateTime.parse(value);
      if (value is int) value = value.toDouble();
      if (value < 0) return null;

      return DateTime.fromMillisecondsSinceEpoch(unit.addScale(value).toInt());
    }
    catch (e) {
      return null;
    }
  }

  @override
  double? toJson(DateTime? value) {
    if (value == null) return null;

    return unit.removeScale(value.millisecondsSinceEpoch.toDouble());
  }
}
