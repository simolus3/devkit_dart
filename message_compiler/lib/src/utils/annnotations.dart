import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';

bool hasAnnotation(Element element, String type) {
  return element.metadata.any(
          (a) => a.computeConstantValue().type.displayName == type);
}

DartObject findAnnotation(Element element, String type) {
  return element.metadata
      .singleWhere((a) => a.constantValue.type.displayName == type)
      .constantValue;
}