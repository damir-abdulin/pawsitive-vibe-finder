import 'dart:convert';

import 'package:drift/drift.dart';

import '../entities/breed_images/breed_images_cache.dart';
import 'database.dart';

part 'breed_images_cache_dao.g.dart';

/// Data Access Object for breed images cache operations.
///
/// This DAO handles all database operations for breed images caching,
/// including LRU cache management and storage size tracking.
@DriftAccessor(tables: <Type>[BreedImagesCache])
class BreedImagesCacheDao extends DatabaseAccessor<AppDatabase>
    with _$BreedImagesCacheDaoMixin {
  /// Creates an instance of [BreedImagesCacheDao].
  BreedImagesCacheDao(super.db);

  /// Gets cached breed images by breed ID.
  Future<BreedImagesCacheEntity?> getCachedBreedImages(String breedId) async {
    try {
      final SimpleSelectStatement<
        $BreedImagesCacheTable,
        BreedImagesCacheEntity
      >
      query = select(breedImagesCache)
        ..where((BreedImagesCache tbl) => tbl.breedId.equals(breedId));

      final BreedImagesCacheEntity? result = await query.getSingleOrNull();

      if (result != null) {
        // Update last accessed time for LRU
        await _updateLastAccessedTime(result.id);
        
        return result;
      }

      return null;
    } catch (e) {
      // If table doesn't exist or other database error, return null
      return null;
    }
  }

  /// Saves breed images to cache.
  Future<void> saveBreedImages({
    required String breedId,
    required List<String> imageUrls,
    required int sizeInBytes,
  }) async {
    try {
      final String imageUrlsJson = jsonEncode(imageUrls);
      final DateTime now = DateTime.now();

      // Use replace to handle unique constraint properly
      await into(breedImagesCache).insert(
        BreedImagesCacheCompanion(
          breedId: Value<String>(breedId),
          imageUrls: Value<String>(imageUrlsJson),
          sizeInBytes: Value<int>(sizeInBytes),
          isFullyCached: const Value<bool>(true),
          createdAt: Value<DateTime>(now),
          lastAccessedAt: Value<DateTime>(now),
        ),
        mode: InsertMode.replace,
      );
    } catch (e) {
      // If there's still an error, rethrow it
      rethrow;
    }
  }

  /// Checks if breed images are cached.
  Future<bool> isBreedCached(String breedId) async {
    try {
      final SimpleSelectStatement<
        $BreedImagesCacheTable,
        BreedImagesCacheEntity
      >
      query = select(breedImagesCache)
        ..where((BreedImagesCache tbl) => tbl.breedId.equals(breedId));

      final BreedImagesCacheEntity? result = await query.getSingleOrNull();
     
      return result != null && result.isFullyCached;
    } catch (e) {
      // If table doesn't exist or other database error, return false
      return false;
    }
  }

  /// Gets total cache size in bytes.
  Future<int> getTotalCacheSize() async {
    try {
      // Use COALESCE to handle NULL values from SUM when table is empty
      final Expression<int> sumExpression = coalesce(<Expression<int>>[
        breedImagesCache.sizeInBytes.sum(),
        const Constant<int>(0),
      ]);

      final Selectable<TypedResult> query = selectOnly(breedImagesCache)
        ..addColumns(<Expression<Object>>[sumExpression]);

      final TypedResult result = await query.getSingle();
      final int? totalSize = result.read(sumExpression);
     
      return totalSize ?? 0;
    } catch (e) {
      // If the table doesn't exist or any other error occurs, return 0
      return 0;
    }
  }

  /// Clears all cached data.
  Future<void> clearAllCache() async {
    await delete(breedImagesCache).go();
  }

  /// Removes least recently used cache entries if cache exceeds size limit.
  Future<void> evictLeastRecentlyUsed(int maxCacheSizeBytes) async {
    try {
      final int currentCacheSize = await getTotalCacheSize();

      if (currentCacheSize <= maxCacheSizeBytes) {
        return; // Cache is within limits
      }

      // Get entries ordered by least recently used
      final SimpleSelectStatement<
        $BreedImagesCacheTable,
        BreedImagesCacheEntity
      >
      query = select(breedImagesCache)
        ..orderBy(<OrderClauseGenerator<$BreedImagesCacheTable>>[
          (BreedImagesCache tbl) => OrderingTerm.asc(tbl.lastAccessedAt),
        ]);

      final List<BreedImagesCacheEntity> entries = await query.get();

      int sizeToRemove = currentCacheSize - maxCacheSizeBytes;

      for (final BreedImagesCacheEntity entry in entries) {
        if (sizeToRemove <= 0) break;

        await (delete(
          breedImagesCache,
        )..where((BreedImagesCache tbl) => tbl.id.equals(entry.id))).go();

        sizeToRemove -= entry.sizeInBytes;
      }
    } catch (e) {
      // If there's an error accessing the cache, just ignore it
      // This can happen during initial setup or migration
      return;
    }
  }

  /// Gets list of cached image URLs for a breed.
  Future<List<String>?> getCachedImageUrls(String breedId) async {
    final BreedImagesCacheEntity? cacheEntry = await getCachedBreedImages(
      breedId,
    );

    if (cacheEntry != null) {
      try {
        final List<dynamic> decoded =
            jsonDecode(cacheEntry.imageUrls) as List<dynamic>;
       
        return decoded.cast<String>();
      } catch (e) {
        // If JSON decoding fails, return null
        return null;
      }
    }

    return null;
  }

  /// Updates the last accessed time for LRU management.
  Future<void> _updateLastAccessedTime(int cacheId) async {
    await (update(
      breedImagesCache,
    )..where((BreedImagesCache tbl) => tbl.id.equals(cacheId))).write(
      BreedImagesCacheCompanion(
        lastAccessedAt: Value<DateTime>(DateTime.now()),
      ),
    );
  }
}
