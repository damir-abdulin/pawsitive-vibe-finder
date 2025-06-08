import 'package:drift/drift.dart';

import '../../domain/domain.dart';

/// A type converter for the [BreedType] enum.
///
/// This converter allows Drift to store the [BreedType] enum as a [String]
/// in the database and convert it back to the enum type when read.
class BreedTypeConverter extends TypeConverter<BreedType, String> {
  /// Creates a const [BreedTypeConverter].
  const BreedTypeConverter();

  @override
  BreedType fromSql(String fromDb) {
    return BreedType.values.byName(fromDb);
  }

  @override
  String toSql(BreedType value) {
    return value.name;
  }
}

/// Defines the 'favorite_dogs' table for the Drift database.
///
/// This class represents the schema for the table that stores dogs
/// marked as favorites by the user.
@DataClassName('FavoriteDogEntity')
class FavoriteDogs extends Table {
  /// The URL of the dog's image, serving as the primary key.
  TextColumn get imageUrl => text()();

  /// The breed of the dog.
  TextColumn get breed => text().map(const BreedTypeConverter())();

  @override
  Set<Column<Object>>? get primaryKey => <Column<Object>>{imageUrl};
}
