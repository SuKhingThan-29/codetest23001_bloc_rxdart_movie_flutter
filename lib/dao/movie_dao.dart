// dao/person_dao.dart

import 'package:floor/floor.dart';

import '../models/movie.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM Movie')
  Future<List<Movie>> findAllMovie();

  @Query('SELECT name FROM Movie')
  Stream<List<String>> findAllMovieName();

  @Query('SELECT * FROM Movie WHERE releaseDate = :releaseDate')
  Stream<Movie?> findMovieByReleaseDate(String releaseDate);

  @Query('UPDATE Movie set isFavourite=:isFavourite where id=:id')
  Future<void> updateFavouriteById(int id,bool isFavourite);


  @Insert(onConflict:OnConflictStrategy.replace)
  Future<void> insertMovie(Movie person);
}