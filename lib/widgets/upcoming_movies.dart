import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../bloc/get_upcoming_movies_bloc.dart';
import '../models/movie.dart';
import '../models/movie_response.dart';
import '../screens/movies_detail_screen.dart';
import '../styles/colors.dart';

class UpComingMovies extends StatefulWidget {
  const UpComingMovies({super.key});

  @override
  State<UpComingMovies> createState() => _UpComingMoviesState();
}

class _UpComingMoviesState extends State<UpComingMovies> {
  @override
  void initState() {
    super.initState();
    moviesBloc.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: moviesBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          return _buildSuccessWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error as String);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: grey.withOpacity(0.3),
          highlightColor: grey.withOpacity(0.1),
          child: Container(
            width: 120,
            height: 18,
            margin: const EdgeInsets.only(left: 14.0),
            decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        SizedBox(
          height: 260.0,
          child: Shimmer.fromColors(
            baseColor: grey.withOpacity(0.3),
            highlightColor: grey.withOpacity(0.1),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120.0,
                        height: 180.0,
                        decoration: const BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: 120,
                        height: 14,
                        decoration: const BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Text("Error occured: $error"),
    );
  }
  bool isFavorited = false;

  void _toggleFavorite(int id) {
    setState(() {
      isFavorited = !isFavorited;
      moviesBloc.setFavourite(id, isFavorited);
      moviesBloc.getMovies();

    });
  }
  Widget _buildSuccessWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 14.0, top: 14.0),
          child: Text(
            "Upcoming Shows",
            style: TextStyle(
                color: black, fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        SizedBox(
          height: 260.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 14.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MoviesDetailScreen(movie: movies[index])));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((movies[index].poster ?? "").isEmpty)
                          Container(
                            width: 120.0,
                            height: 180.0,
                            decoration: BoxDecoration(
                              color: grey.withOpacity(0.1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              shape: BoxShape.rectangle,
                            ),
                          )
                        else
                          Stack(
                            children: [
                              Container(
                                width: 120.0,
                                height: 180.0,
                                decoration: BoxDecoration(
                                  color: grey.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                    image: NetworkImage("https://image.tmdb.org/t/p/w200/${movies[index].poster}"),
                                    fit: BoxFit.cover, // Ensure the image covers the entire container
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: IconButton(
                                  icon: Icon(
                                    movies[index].isFavourite==true ? Icons.favorite : Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                  onPressed: (){
                                    _toggleFavorite(movies[index].id!);
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 0,
                                right: 0,
                                child: SizedBox(
                                  width: 120, // Adjust the width as needed
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0),
                                      ),
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        height:30,
                                        child: Text(
                                          movies[index].title ?? "",
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            height: 1.4,
                                            color: Colors.white,
                                            fontSize: 11.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
