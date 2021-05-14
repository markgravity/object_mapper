import 'mappable.dart';

abstract class RawRepresentable<RawValue> {
  RawValue get rawValue;

  factory RawRepresentable(Type type, RawValue rawValue) {
    var constructor = Mappable.factories[type];
    assert(constructor != null);
    return constructor!(rawValue);
  }
}
