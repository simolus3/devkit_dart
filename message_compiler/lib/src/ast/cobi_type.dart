import 'package:message_compiler/src/parser/type_parser.dart';

abstract class CobiType {

  String get name;

  /// Writes the body of a parsing function with the signature
  /// RepresentedType _$parseRepresentedType(dynamic data)
  void writeBodyOfParsingFunction(TypeParser parser, StringBuffer buf);

  void writeBodyOfSerializer(TypeParser parser, StringBuffer buf);
}

class NativeBoolType extends CobiType {

  final String name = "CobiBool";

  static final NativeBoolType _instance = NativeBoolType._();
  NativeBoolType._();

  factory NativeBoolType() => _instance;

  @override
  void writeBodyOfParsingFunction(TypeParser parser, StringBuffer buf) {
    buf.writeln("return data as bool;");
  }

  @override
  void writeBodyOfSerializer(TypeParser parser, StringBuffer buf) {
    buf.writeln("return data;");
  }

}

class NativeIntType extends CobiType {

  final String name = "CobiInt";

  static final NativeIntType _instance = NativeIntType._();
  NativeIntType._();

  factory NativeIntType() => _instance;

  @override
  void writeBodyOfParsingFunction(TypeParser parser, StringBuffer buf) {
    buf.writeln("return data as int;");
  }

  @override
  void writeBodyOfSerializer(TypeParser parser, StringBuffer buf) {
    buf.writeln("return data;");
  }

}

class NativeStringType extends CobiType {

  final String name = "CobiString";

  static final NativeStringType _instance = NativeStringType._();
  NativeStringType._();

  factory NativeStringType() => _instance;

  @override
  void writeBodyOfParsingFunction(TypeParser parser, StringBuffer buf) {
    buf.writeln("return data as String;");
  }

  @override
  void writeBodyOfSerializer(TypeParser parser, StringBuffer buf) {
    buf.writeln("return data;");
  }
}

class NativeDoubleType extends CobiType {

  final String name = "CobiDouble";

  static final NativeDoubleType _instance = NativeDoubleType._();
  NativeDoubleType._();

  factory NativeDoubleType() => _instance;

  @override
  void writeBodyOfParsingFunction(TypeParser parser, StringBuffer buf) {
    buf.writeln("return data as double;");
  }

  @override
  void writeBodyOfSerializer(TypeParser parser, StringBuffer buf) {
    buf.writeln("return data;");
  }

}