import 'package:drift/drift.dart';

/// Drift table for caching breed images locally.
///
/// This table stores metadata about cached breed images to support
/// offline functionality and cache management as defined in User Story 2.
@DataClassName('BreedImagesCacheEntity')
class BreedImagesCache extends Table {
  /// Primary key - auto-incrementing ID.
  IntColumn get id => integer().autoIncrement()();

  /// The breed identifier (e.g., 'hound', 'bulldog').
  TextColumn get breedId => text().withLength(min: 1, max: 50)();

  /// JSON string containing the list of image URLs.
  TextColumn get imageUrls => text()();

  /// Timestamp when the cache entry was created.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Timestamp when the cache entry was last accessed (for LRU).
  DateTimeColumn get lastAccessedAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// Size of the cached data in bytes.
  IntColumn get sizeInBytes => integer().withDefault(const Constant<int>(0))();

  /// Whether all images for this breed are fully cached.
  BoolColumn get isFullyCached =>
      boolean().withDefault(const Constant<bool>(false))();

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
    <Column<Object>>{breedId}, // Each breed can only have one cache entry
  ];
}
