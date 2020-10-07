/// A base class for exceptions thrown when decoding JSON.
abstract class BadKeyException implements Exception {
  BadKeyException._(this.map);

  /// The source [Map] that the unrecognized keys were found in.
  final Map map;

  /// A human-readable message corresponding to the error.
  String get message;
}

/// Exception thrown if there are unrecognized keys in a JSON map that was
/// provided during deserialization.
class UnrecognizedKeysException extends BadKeyException {
  /// The allowed keys for [map].
  final List<String> allowedKeys;

  /// The keys from [map] that were unrecognized.
  final List<String> unrecognizedKeys;

  @override
  String get message =>
      'Unrecognized keys: [${unrecognizedKeys.join(', ')}]; supported keys: '
      '[${allowedKeys.join(', ')}]';

  UnrecognizedKeysException(this.unrecognizedKeys, Map map, this.allowedKeys)
      : super._(map);
}

/// Exception thrown if there are missing required keys in a JSON map that was
/// provided during deserialization.
class MissingRequiredKeysException extends BadKeyException {
  /// The keys that [map] is missing.
  final List<String> missingKeys;

  @override
  String get message => 'Required keys are missing: ${missingKeys.join(', ')}.';

  MissingRequiredKeysException(this.missingKeys, Map map)
      : assert(missingKeys.isNotEmpty),
        super._(map);
}

/// Exception thrown if there are keys with disallowed `null` values in a JSON
/// map that was provided during deserialization.
class DisallowedNullValueException extends BadKeyException {
  final List<String> keysWithNullValues;

  DisallowedNullValueException(this.keysWithNullValues, Map map) : super._(map);

  @override
  String get message => 'These keys had `null` values, '
      'which is not allowed: $keysWithNullValues';
}
