import 'src/transformable.dart';
export 'src/transformable.dart';
const mappable = MappableAnnotation();

class MappableAnnotation {
  const MappableAnnotation();
}

class Test<T> {
  const Test(this.child);

  final T child;
}

// ignore: camel_case_types
class modify {
  const modify({
    this.key,
    this.skip = false,
    this.transform,
  });

  final String? key;
  final bool skip;
  final Transformable? transform;
}
