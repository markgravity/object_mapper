import 'raw_representable.dart';

abstract class Enumerable<T> implements RawRepresentable<T> {
	const Enumerable();

	@override
  	bool operator ==(Object other) {
		if (identical(this, other)) {
			return true;
		}
		return other is RawRepresentable &&
			this.rawValue == other.rawValue;
  	}
}