import 'package:rxdart/rxdart.dart';

import '../database.dart';
import '../models/movie.dart';
import '../models/movie_response.dart';
import '../repository/repository.dart';

class UpcomingMoviesBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<MovieResponse> _subject =
  BehaviorSubject<MovieResponse>();
  List<Movie> movieList=[];

  getMovies() async {
    final database = await $FloorAppDatabase.databaseBuilder('movie_database.db').build();
    movieList.clear();
    movieList=await database.movieDao.findAllMovie();
    if(movieList.isEmpty){
      MovieResponse response = await _repository.getMovies();
      movieList=await setMovies(response.movies);
    }
    MovieResponse movieResponse=MovieResponse(movieList, "error");
    _subject.sink.add(movieResponse);


  }
  setFavourite(int id,bool isFavourite)async{
    final database = await $FloorAppDatabase.databaseBuilder(
        'movie_database.db').build();
    final movieDao = database.movieDao;
    await movieDao.updateFavouriteById(id,isFavourite);

  }
  Future<List<Movie>>setMovies(List<Movie> movies)async {
    final database = await $FloorAppDatabase.databaseBuilder(
        'movie_database.db').build();
    final movieDao = database.movieDao;
    for (var i in movies) {
      await movieDao.insertMovie(i);
    }
    movieList = await database.movieDao.findAllMovie();
    return movieList;
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final moviesBloc = UpcomingMoviesBloc();
