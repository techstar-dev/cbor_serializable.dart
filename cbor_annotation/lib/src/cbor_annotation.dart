/// Values for the automatic field renaming behavior for [CborSerializable].
enum FieldRename {
  /// Use the field name without changes.
  none,

  /// Encodes a field named `kebabCase` with a Cbor key `kebab-case`.
  kebab,

  /// Encodes a field named `snakeCase` with a Cbor key `snake_case`.
  snake,

  /// Encodes a field named `pascalCase` with a Cbor key `PascalCase`.
  pascal
}

class CborSerializable {
  /// Defines the automatic naming strategy when converting class field names
  /// into Cbor map keys.
  ///
  /// With a value [FieldRename.none] (the default), the name of the field is
  /// used without modification.
  ///
  /// See [FieldRename] for details on the other options.
  ///
  /// Note: the value for [CborKey.name] takes precedence over this option for
  /// fields annotated with [CborKey].
  final FieldRename fieldRename;

  /// Whether the generator should include fields with `null` values in the
  /// serialized output.
  ///
  /// If `true` (the default), all fields are written to Cbor, even if they are
  /// `null`.
  ///
  /// If a field is annotated with `CborKey` with a non-`null` value for
  /// `includeIfNull`, that value takes precedent.
  final bool includeIfNull;

  /// When `true` (the default), `null` fields are handled gracefully when
  /// encoding to Cbor and when decoding `null` and nonexistent values from
  /// Cbor.
  ///
  /// Setting to `false` eliminates `null` verification in the generated code,
  /// which reduces the code size. Errors may be thrown at runtime if `null`
  /// values are encountered, but the original class should also implement
  /// `null` runtime validation if it's critical.
  final bool nullable;

  /// Creates a new [CborSerializable] instance.
  const CborSerializable({
    this.fieldRename,
    this.includeIfNull,
    this.nullable,
  });

  /// An instance of [CborSerializable] with all fields set to their default
  /// values.
  static const defaults = CborSerializable(
    includeIfNull: true,
    nullable: true,
  );
}
