// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Movie` (`id` INTEGER, `title` TEXT, `backPoster` TEXT, `poster` TEXT, `overview` TEXT, `releaseDate` TEXT, `isFavourite` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _movieInsertionAdapter = InsertionAdapter(
            database,
            'Movie',
            (Movie item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'backPoster': item.backPoster,
                  'poster': item.poster,
                  'overview': item.overview,
                  'releaseDate': item.releaseDate,
                  'isFavourite': item.isFavourite == null
                      ? null
                      : (item.isFavourite! ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Movie> _movieInsertionAdapter;

  @override
  Future<List<Movie>> findAllMovie() async {
    return _queryAdapter.queryList('SELECT * FROM Movie',
        mapper: (Map<String, Object?> row) => Movie(
            row['id'] as int?,
            row['title'] as String?,
            row['backPoster'] as String?,
            row['poster'] as String?,
            row['overview'] as String?,
            row['releaseDate'] as String?,
            row['isFavourite'] == null
                ? null
                : (row['isFavourite'] as int) != 0));
  }

  @override
  Stream<List<String>> findAllMovieName() {
    return _queryAdapter.queryListStream('SELECT name FROM Movie',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        queryableName: 'Movie',
        isView: false);
  }

  @override
  Stream<Movie?> findMovieByReleaseDate(String releaseDate) {
    return _queryAdapter.queryStream(
        'SELECT * FROM Movie WHERE releaseDate = ?1',
        mapper: (Map<String, Object?> row) => Movie(
            row['id'] as int?,
            row['title'] as String?,
            row['backPoster'] as String?,
            row['poster'] as String?,
            row['overview'] as String?,
            row['releaseDate'] as String?,
            row['isFavourite'] == null
                ? null
                : (row['isFavourite'] as int) != 0),
        arguments: [releaseDate],
        queryableName: 'Movie',
        isView: false);
  }

  @override
  Future<void> updateFavouriteById(
    int id,
    bool isFavourite,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Movie set isFavourite=?2 where id=?1',
        arguments: [id, isFavourite ? 1 : 0]);
  }

  @override
  Future<void> insertMovie(Movie person) async {
    await _movieInsertionAdapter.insert(person, OnConflictStrategy.replace);
  }
}
