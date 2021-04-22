part of '../../object_mapper.dart';

class DateUnit extends Enumerable<int> {
  @override
  late final int rawValue;
  DateUnit({required this.rawValue});

  //
  static final seconds = DateUnit(rawValue: 1000);
  static final milliseconds = DateUnit(rawValue: 1);

  double addScale(double interval) {
    return interval * rawValue;
  }

  double removeScale(double interval) {
    return interval / rawValue;
  }
}

class DateTransform implements Transformable<DateTime?, double?> {
  late DateUnit unit;
  DateTransform({DateUnit? unit}){
    this.unit = unit ?? DateUnit.seconds;
  }

  //
  @override
  DateTime? fromJson(value) {
    try {
      if (value == null) return null;
      if (value is String) return DateTime.parse(value);
      if (value is int) value = value.toDouble();
      if (value < 0) return null;

      return DateTime.fromMillisecondsSinceEpoch(unit.addScale(value).toInt());
    } catch (e) {
      return null;
    }
  }

  @override
  double? toJson(DateTime? value) {
    if (value == null) return null;

    return unit.removeScale(value.millisecondsSinceEpoch.toDouble());
  }
}
