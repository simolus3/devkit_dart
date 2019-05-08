import 'package:message_compiler/src/parser/type_parser.dart';

import 'cobi_type.dart';
import 'package:analyzer/dart/element/element.dart';

class ParsedCobiEnum extends CobiType {

  @override
  String get name => declaration.displayName;

  final ClassElement declaration;
  final List<EnumValue> values;

  ParsedCobiEnum(this.declaration, this.values);

  @override
  void writeBodyOfParsingFunction(TypeParser parser, StringBuffer buf) {
    for (final val in values) {
      buf.writeln("if (data == \"${val.serializedName}\") {");
      buf.writeln("return ${declaration.displayName}.${val.declaration.displayName};");
      buf.writeln("}");
    }

    buf.writeln("throw Exception(\"Unknown value for "
        "${declaration.displayName}: \$data\");");
  }

  @override
  void writeBodyOfSerializer(TypeParser parser, StringBuffer buf) {
    for (final val in values) {
      buf.writeln("if (data == ${declaration.displayName}.${val.declaration.displayName}) {");
      buf.writeln("return \"${val.serializedName}\";");
      buf.writeln("}");
    }
  }

}

class EnumValue {

  final FieldElement declaration;
  final String serializedName;

  EnumValue(this.declaration, this.serializedName);

}