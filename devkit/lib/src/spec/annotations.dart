class CobiStruct {

  const CobiStruct._();

}
const CobiStruct cobiEntity = CobiStruct._();

class FromValue {

  // When changing this, also adapt the parser!
  final String serializedVal;

  /**
   * When annotated on an enum field, marks the string value associated with
   * that specific entry.
   * When annotated on a field in a cobi struct, marks the json key associated
   * with that specific field.
   */
  const FromValue(this.serializedVal);

}