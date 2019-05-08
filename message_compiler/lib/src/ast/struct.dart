import 'package:message_compiler/src/parser/type_parser.dart';

import 'cobi_type.dart';

import 'package:analyzer/dart/element/element.dart';

class ParsedCobiStruct extends CobiType {

  @override
  String get name => declaration.displayName;

  final ClassElement declaration;
  final List<StructProperty> properties;

  ParsedCobiStruct(this.declaration, this.properties);

  @override
  void writeBodyOfParsingFunction(TypeParser parser, StringBuffer buf) {
    int i = 0;
    for (final p in properties) {
      // final a1 = _$parseCobiInt(data["myInt"]);
      buf.writeln("final a$i = ${parser.getNameOfParsingFunction(p.type)}"
          "(data[\"${p.jsonKey}\"]);");

      i++;
    }

    // return RbgColor(a0, a1, a2);
    final params = List.generate(i, (x) => "a$x", growable: false)
        .join(",");
    buf.writeln("return ${declaration.name}($params);");
  }

  @override
  void writeBodyOfSerializer(TypeParser parser, StringBuffer buf) {
    buf.writeln("final obj = new JsObject(context[\"Object\"]);");
    for (final p in properties) {
      final nameOfField = p.declaration.displayName;
      buf.writeln("obj[\"${p.jsonKey}\"] = "
          "${parser.getNameOfWritingFunction(p.type)}(data.$nameOfField);");
    }

    buf.writeln("return obj;");
  }


}

class StructProperty {

  final FieldElement declaration;
  final String jsonKey;
  final CobiType type;

  StructProperty(this.declaration, this.jsonKey, this.type);

}