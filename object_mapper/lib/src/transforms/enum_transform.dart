import '../enumerable.dart';
import '../transformable.dart';
import '../raw_representable.dart';

class EnumTransform<Object extends Enumerable, JSON> with Transformable<Object?, JSON?> {
  const EnumTransform();

  @override
  Object? fromJson(value) {
    if (value == null || !(value is JSON)) return null;
    return RawRepresentable(Object, value) as Object;
  }

  @override
  JSON? toJson(Object? value) {
    if (value == null) return null;
    return value.rawValue;
  }
}
