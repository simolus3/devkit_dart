import 'package:analyzer/dart/element/element.dart';
import 'package:message_compiler/src/ast/enum.dart';
import 'package:message_compiler/src/parser/type_parser.dart';
import 'package:message_compiler/src/utils/annnotations.dart';

class EnumParser {

  final ClassElement candidate;
  final TypeParser parser;

  EnumParser(this.candidate, this.parser);

  bool shouldTryParsing() {
    return hasAnnotation(candidate, "CobiStruct") && candidate.isEnum;
  }

  ParsedCobiEnum parse() {
    final properties = new List<EnumValue>();

    for (final field in candidate.fields) {
      // taken from https://github.com/google/built_value.dart/blob/07d6374f2ed06a6f31079fbc838b8305caeea693/built_value_generator/lib/src/enum_source_field.dart#L57
      if (field.isSynthetic || field.type != candidate.type)
        continue;

      String serializedValue;
      if (hasAnnotation(field, "FromValue")) {
        serializedValue = findAnnotation(field, "FromValue").getField("serializedVal")
            .toStringValue();
      } else {
        serializedValue = field.displayName;
      }

      properties.add(EnumValue(field, serializedValue));
    }

    return new ParsedCobiEnum(candidate, properties);
  }

}