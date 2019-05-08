import 'package:analyzer/dart/element/element.dart';
import 'package:message_compiler/src/ast/struct.dart';
import 'package:message_compiler/src/parser/type_parser.dart';
import 'package:message_compiler/src/utils/annnotations.dart';

class StructParser {

  final ClassElement candidate;
  final TypeParser parser;

  StructParser(this.candidate, this.parser);

  bool shouldTryParsing() {
    return hasAnnotation(candidate, "CobiStruct") && !candidate.isEnum;
  }

  ParsedCobiStruct parse() {
    final properties = new List<StructProperty>();

    for (final field in candidate.fields) {
      String jsonKey;
      if (hasAnnotation(field, "FromValue")) {
        jsonKey = findAnnotation(field, "FromValue").getField("serializedVal")
            .toStringValue();
      } else {
        jsonKey = field.displayName;
      }
      
      properties.add(new StructProperty(field, jsonKey,
          parser.findOrParse(field.type)));
    }

    return new ParsedCobiStruct(candidate, properties);
  }

}