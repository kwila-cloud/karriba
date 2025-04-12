import 'package:drift/drift.dart';
import 'package:drift_sqflite/drift_sqflite.dart';

part 'database.g.dart';

@DriftDatabase(include: {'schema.drift'})
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openDatabase());

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        // This is similar to the `onUpgrade` callback from sqflite. When
        // migrating to drift, it should contain your existing migration logic.
        // You can access the raw database by using `customStatement`
        if (from < 2) {
          // Create the record table if it doesn't exist
          await customStatement('''
            CREATE TABLE IF NOT EXISTS record (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              timestamp INTEGER NOT NULL,
              applicator_id INTEGER NOT NULL,
              customer_id INTEGER NOT NULL,
              customer_informed_of_rei INTEGER NOT NULL,
              field_name TEXT NOT NULL
            )
            ''');
        }
        if (from < 3) {
          // Add the environmental condition fields
          await customStatement('''
            ALTER TABLE record ADD COLUMN wind_speed_before REAL;
          ''');
          await customStatement('''
            ALTER TABLE record ADD COLUMN wind_speed_after REAL;
          ''');
          await customStatement('''
            ALTER TABLE record ADD COLUMN wind_direction TEXT;
          ''');
          await customStatement('''
            ALTER TABLE record ADD COLUMN temperature REAL;
          ''');
        }
        if (from < 4) {
          // Create the pesticides related tables if they don't exist
          await customStatement('''
            CREATE TABLE IF NOT EXISTS pesticide (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              registration_number TEXT NOT NULL
            )
            ''');
          await customStatement('''
            CREATE TABLE IF NOT EXISTS record_pesticide (
              record_id INTEGER NOT NULL,
              pesticide_id INTEGER NOT NULL,
              rate REAL NOT NULL,
              rate_unit TEXT NOT NULL,
              PRIMARY KEY (record_id, pesticide_id),
              FOREIGN KEY (record_id) REFERENCES record(id) ON DELETE CASCADE,
              FOREIGN KEY (pesticide_id) REFERENCES pesticide(id) ON DELETE CASCADE
            )
            ''');
        }
        if (from < 5) {
          await customStatement('''
            ALTER TABLE record ADD COLUMN crop TEXT NOT NULL DEFAULT '';
          ''');
          await customStatement('''
            ALTER TABLE record ADD COLUMN total_area REAL NOT NULL DEFAULT 0;
          ''');
          await customStatement('''
            ALTER TABLE record ADD COLUMN price_per_acre REAL NOT NULL DEFAULT 0;
          ''');
          await customStatement('''
            ALTER TABLE record ADD COLUMN spray_volume REAL NOT NULL DEFAULT 0;
          ''');
          await customStatement('''
            ALTER TABLE record ADD COLUMN notes TEXT NOT NULL DEFAULT '';
          ''');
        }
        if (from < 6) {
          await customStatement('''
            ALTER TABLE record RENAME COLUMN timestamp TO start_timestamp;
          ''');
          await customStatement('''
            ALTER TABLE record ADD COLUMN end_timestamp INTEGER NOT NULL DEFAULT 0;
          ''');
          await customStatement('''
            UPDATE record SET end_timestamp = start_timestamp WHERE end_timestamp = 0;
          ''');
        }
        if (from < 7) {
          await customStatement('''
            CREATE VIEW record_view AS
                SELECT 
                    record.id,
                    record.start_timestamp,
                    record.end_timestamp,
                    record.applicator_id,
                    applicator.name as applicator_name,
                    record.customer_id,
                    customer.name AS customer_name,
                    record.customer_informed_of_rei,
                    record.field_name,
                    record.crop,
                    record.total_area,
                    record.price_per_acre,
                    record.spray_volume,
                    record.wind_speed_before,
                    record.wind_speed_after,
                    record.wind_direction,
                    record.temperature,
                    record.notes
                FROM record
                LEFT JOIN applicator ON record.applicator_id = applicator.id
                LEFT JOIN customer ON record.customer_id = customer.id
                ORDER BY record.start_timestamp DESC;
          ''');
        }
      },
      beforeOpen: (details) async {
        // This is a good place to enable pragmas you expect, e.g.
        await customStatement('pragma foreign_keys = ON;');
      },
    );
  }

  static QueryExecutor _openDatabase() {
    return SqfliteQueryExecutor.inDatabaseFolder(path: 'karriba.db');
  }
}
