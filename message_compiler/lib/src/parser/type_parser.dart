import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:message_compiler/src/ast/cobi_type.dart';
import 'package:message_compiler/src/parser/enum_parser.dart';
import 'package:message_compiler/src/parser/struct_parser.dart';

class TypeParser {

  final Map<DartType, CobiType> foundTypes = new Map();

  CobiType findOrParse(DartType type) {
    return foundTypes.putIfAbsent(type, () {
      bool fromCoreLib = type.element.library.isDartCore;

      if (fromCoreLib && type.displayName == "int") {
        return NativeIntType();
      } else if (fromCoreLib && type.displayName == "num") {
        return NativeDoubleType();
      } else if (fromCoreLib && type.displayName == "String") {
        return NativeStringType();
      } else if (fromCoreLib && type.displayName == "bool") {
        return NativeBoolType();
      }

      // Can be an enum or a struct now, who knows
      if (type.element is ClassElement) {
        ClassElement declaration = type.element;

        if (declaration.isEnum) {
          final parser = EnumParser(declaration, this);
          if (parser.shouldTryParsing())
            return parser.parse();
        } else {
          final parser = StructParser(declaration, this);
          if (parser.shouldTryParsing())
            return parser.parse();
        }
      }

      // If we got until here, something is wrong because we don't know how to
      // map this dart type to an cobi type.
      throw Exception("Unknown type: $type");
    });
  }

  String getNameOfParsingFunction(CobiType type) {
    return "_\$parse${type.name}";
  }

  String getNameOfWritingFunction(CobiType type) {
    return "_\$write${type.name}";
  }

}