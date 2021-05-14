import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:object_mapper/annotations.dart';
import 'package:source_gen/source_gen.dart';
import 'declaration_generator.dart';
import 'modify.dart';

class MappableGenerator extends GeneratorForAnnotation<MappableAnnotation> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    final classElement = element as ClassElement;
    final generator = DeclarationGenerator();
    final content = StringBuffer();

    content.writeln("Mappable.factories[${classElement.name}] = () => ${classElement.name}();");
    content.writeln("mixin _Mappable implements Mappable {");
    classElement.fields.forEach((field) {
      final modify = Modify.fromElement(field);
      if (modify.skip) {
        return;
      }

      content.writeln("  ${generator.generateForField(field)}");
    });
    content.writeln();
    content.writeln("  @override");
    content.writeln("  void mapping(Mapper map) {");
    classElement.fields.forEach((field) {
      final modify = Modify.fromElement(field);
      if (modify.skip) {
        return;
      }
      content.writeln('    ${generator.generateForMapFunction(field, modify)}');
    });
    content.writeln("  }");
    content.writeln();
    content.writeln("  Map<String, dynamic> toJson() {");
    content.writeln("    return Mapper().toJson(this);");
    content.writeln("  }");
    content.writeln();
    content.writeln("  T clone<T extends Mappable>() {");
    content.writeln("    final json = toJson();");
    content.writeln("    return Mapper.fromJson(json).toObject<T>()!;");
    content.writeln("  }");
    content.writeln();
    content.writeln("  String toJsonString() {");
    content.writeln("    return Mapper().toJsonString(this);");
    content.writeln("  }");
    content.writeln("}");

    return content.toString();
  }
}
