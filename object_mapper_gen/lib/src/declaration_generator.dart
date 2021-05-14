import 'package:analyzer/dart/element/element.dart';

// ignore: implementation_imports
import 'package:analyzer/src/dart/constant/value.dart';
// ignore: implementation_imports
import 'package:analyzer/src/dart/element/type.dart';
import 'modify.dart';

class DeclarationGenerator {
  String generateForField(FieldElement field) {
    String marking = "late";

    if (field.isFinal) {
      marking += " final";
    }
    return "$marking ${field.type} ${field.name};";
  }

  String generateForMapFunction(FieldElement field, Modify modify) {
    String type = field.type.toString();
    if (field.type.isDartCoreList) {
      type = (field.type as InterfaceTypeImpl).typeArguments.first.getDisplayString(withNullability: true);
    }

    String declaration =
        'map<$type>("${modify.key ?? field.name}", ${field.name}, (v) => ${field.name} = v as ${field.type},';
    if (modify.transform != null) {
      declaration += "${modify.transform},";
    }
    declaration += ");";
    return declaration;
  }

  String generateForUserDefinedObject(DartObjectImpl object) {
    String declaration = "${object.type.toString()}(";
    final invocation = object.getInvocation()!;

    // Add positional args
    invocation.positionalArguments.forEach((arg) {
      final value = generateForValue(arg);
      declaration += "$value,";
    });

    // Add named args
    invocation.namedArguments.forEach((named, arg) {
      final value = generateForValue(arg);
      declaration += "$named:$value,";
    });

    declaration += ")";
    return declaration;
  }

  String generateForValue(DartObjectImpl object) {
    if (object.isBool) {
      return object.toBoolValue()! ? "true" : "false";
    }

    if (object.isInt) {
      return "${object.toIntValue()}";
    }

    if (object.isNull) {
      return "null";
    }

    if (object.isUserDefinedObject) {
      return "${generateForUserDefinedObject(object)}";
    }

    return "";
  }
}
