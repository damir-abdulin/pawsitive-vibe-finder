import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../domain/domain.dart';
import '../entities/entities.dart';
import 'favorite_dog_dao.dart';

part 'database.g.dart';

@DriftDatabase(tables: <Type>[FavoriteDogs], daos: <Type>[FavoriteDogDao])
/// The main database class for the application.
///
/// This class is responsible for managing the database connection and providing
/// access to the DAOs (Data Access Objects).
class AppDatabase extends _$AppDatabase {
  /// Creates an instance of the [AppDatabase].
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory dbFolder = await getApplicationDocumentsDirectory();
    final File file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
