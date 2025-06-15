import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../domain/domain.dart';
import '../entities/entities.dart';
import 'breed_images_cache_dao.dart';
import 'favorite_dog_dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: <Type>[FavoriteDogs, BreedImagesCache],
  daos: <Type>[FavoriteDogDao, BreedImagesCacheDao],
)
/// The main database class for the application.
///
/// This class is responsible for managing the database connection and providing
/// access to the DAOs (Data Access Objects).
class AppDatabase extends _$AppDatabase {
  /// Creates an instance of the [AppDatabase].
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // Create the new breed_images_cache table
          await m.createTable(breedImagesCache);
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory dbFolder = await getApplicationDocumentsDirectory();
    final File file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
