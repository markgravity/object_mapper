import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

// ignore: implementation_imports
import 'package:analyzer/src/dart/constant/value.dart';
import 'package:object_mapper/annotations.dart';
import 'declaration_generator.dart';

class Modify {
  const Modify({
    this.key,
    this.skip = false,
    this.transform,
  });

  factory Modify.fromElement(Element element) {
    final typeChecker = TypeChecker.fromRuntime(modify);

    // Return default
    if (!typeChecker.hasAnnotationOf(element)) {
      return Modify();
    }

    final annotation = typeChecker.firstAnnotationOf(element)!;

    // Get transform declaration
    final generator = DeclarationGenerator();
    String? transform;
    final transformObject = annotation.getField("transform") as DartObjectImpl?;
    if (transformObject != null) {
      transform = generator.generateForUserDefinedObject(transformObject);
    }

    return Modify(
      key: annotation.getField("key")!.toStringValue(),
      skip: annotation.getField("skip")!.toBoolValue()!,
      transform: transform,
    );
  }

  final String? key;

  final bool skip;

  final String? transform;
}
