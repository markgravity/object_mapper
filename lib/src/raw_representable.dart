part of '../object_mapper.dart';

abstract class RawRepresentable<RawValue> {
  late final RawValue rawValue;

  factory RawRepresentable(Type type, RawValue rawValue) {
    var constructor = Mappable.factories[type];
    assert(constructor != null);
    return constructor!(rawValue);
  }
}
