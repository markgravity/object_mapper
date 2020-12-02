import '../../../lib/object_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fromJson', () {
    final transform = DateStringTransform();

    // null
    var date = transform.fromJson(null);
    expect(date, null);

    // full date string
    date = transform.fromJson('1998-02-01T09:00:00.000Z');
    expect(date, DateTime.utc(1998, 2, 1, 9, 0, 0));

    // empty
    date = transform.fromJson('');
    expect(date, null);

    // wrong string
    date = transform.fromJson('wrong');
    expect(date, null);
  });

  test('toJson', () {
    final transform = DateStringTransform();

    // full date string
    var date = DateTime.utc(1998, 2, 1, 9, 0, 0);
    expect(transform.toJson(date), '1998-02-01T09:00:00.000Z');
  });
}
