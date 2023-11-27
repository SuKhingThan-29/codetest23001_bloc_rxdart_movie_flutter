// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/movie_dao.dart';
import 'models/movie.dart';
import 'models/movie_detail.dart';
part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Movie])
abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDao;
}