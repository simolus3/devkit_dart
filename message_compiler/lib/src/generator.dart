import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:message_compiler/src/parser/type_parser.dart';
import 'package:message_compiler/src/utils/annnotations.dart';
import 'package:source_gen/source_gen.dart';

class CobiGenerator extends Generator {

  Future<String> generate(LibraryReader library, BuildStep step) async {
    final parser = TypeParser();

    // library.classElements doesn't include enums
    final classes = library.element.units.expand((unit) {
      return unit.types.cast<ClassElement>() + unit.enums;
    });
    for (final clazz in classes) {
      if (hasAnnotation(clazz, "CobiStruct")) {
        parser.findOrParse(clazz.type);
      }
    }

    if (parser.foundTypes.isEmpty)
      return null;

    StringBuffer buffer = StringBuffer();
    parser.foundTypes.forEach((dartType, cobiType) {
      // DartType _$parseCobiType(dynamic data) {
      buffer.writeln(dartType.displayName +
          " " + parser.getNameOfParsingFunction(cobiType) +
          "(dynamic data) {");

      cobiType.writeBodyOfParsingFunction(parser, buffer);

      buffer.writeln("}");

      // dynamic _$writeCobiType(dynamic data) {
      buffer.writeln("dynamic " + parser.getNameOfWritingFunction(cobiType) +
          "(dynamic data) {");

      cobiType.writeBodyOfSerializer(parser, buffer);

      buffer.writeln("}");
    });

    /*
      dynamic parseWithPath(JsObject payload, String path) {
        final type = channels[path];

        if (type == Type1) {
          return _$parseType1(payload)
        }
        ...
      }
     */
    buffer.writeln("dynamic parseWithPath(dynamic payload, String path) {");
    buffer.writeln("final type = channels[path];");

    parser.foundTypes.forEach((dartType, cobiType) {
      buffer.writeln("if (type == ${dartType.displayName}) {");
      buffer.writeln(
          "return ${parser.getNameOfParsingFunction(cobiType)}(payload);");
      buffer.writeln("}");
    });
    buffer.writeln("}");

    // Also create a method to write stuff
    buffer.writeln("dynamic writeWithPath(dynamic payload, String path) {");
    buffer.writeln("final type = channels[path];");

    parser.foundTypes.forEach((dartType, cobiType) {
      buffer.writeln("if (type == ${dartType.displayName}) {");
      buffer.writeln(
          "return ${parser.getNameOfWritingFunction(cobiType)}(payload);");
      buffer.writeln("}");
    });

    buffer.writeln("}");

    return buffer.toString();
  }
}
