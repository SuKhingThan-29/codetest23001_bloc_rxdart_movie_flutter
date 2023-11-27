import 'package:floor/floor.dart';

@entity
class Movie {
  @primaryKey
  final int? id;
  //final num? popularity;
  final String? title;
  final String? backPoster;
  final String? poster;
  final String? overview;
  //final num? rating;
  final String? releaseDate;
  final bool? isFavourite;

  Movie(this.id, this.title, this.backPoster, this.poster,
      this.overview,  this.releaseDate,this.isFavourite);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"],
       // popularity = json["popularity"],
        title = json["title"],
        backPoster = json["backdrop_path"],
        poster = json["poster_path"],
        overview = json["overview"],
       // rating = json["vote_average"].toDouble(),
        isFavourite=false,
        releaseDate = json["release_date"];
}
