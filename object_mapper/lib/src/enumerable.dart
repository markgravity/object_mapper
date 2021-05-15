import 'raw_representable.dart';

abstract class Enumerable<T> implements RawRepresentable<T> {
  const Enumerable();

  // Return an enum case that has a rawValue equals to 'rawValue'
  static T factory<T extends Enumerable>(List<T> values, rawValue) {
    assert(values.length > 0, "The 'values' is empty");

    // other cases: String, bool
    return values.firstWhere((o) => o.rawValue == rawValue,);
  }
}
