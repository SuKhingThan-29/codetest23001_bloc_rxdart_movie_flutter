import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../bloc/get_upcoming_movies_bloc.dart';
import '../models/movie.dart';
import '../styles/colors.dart';

class MoviesDetailScreen extends StatefulWidget {
  final Movie movie;
  const MoviesDetailScreen({super.key, required this.movie});

  @override
  State<MoviesDetailScreen> createState() => _MovicesDetailScreenState();
}

class _MovicesDetailScreenState extends State<MoviesDetailScreen> {
  bool isFavorited = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isFavorited = widget.movie.isFavourite!;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  void _toggleFavorite() {
    setState(() {
      isFavorited = !isFavorited;
      moviesBloc.setFavourite(widget.movie.id!, isFavorited);
      moviesBloc.getMovies();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: white,
            iconTheme: const IconThemeData(color: maroon),
            elevation: 0,
            expandedHeight: 200.0,
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.close,color: Colors.white,), // Customize your back icon here
              onPressed: () {
                Navigator.of(context).pop(); // Handle back button press
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "",
                // (widget.movie.title ?? "").length > 40
                //     ? "${widget.movie.title?.substring(0, 37)}..."
                //     : widget.movie.title ?? "",
                style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: maroon),
              ),
              background: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        "https://image.tmdb.org/t/p/original/${widget.movie.backPoster}",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            fit: BoxFit.cover, image: imageProvider),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: const [
                            0.0,
                            0.9
                          ],
                          colors: [
                            white.withOpacity(1.0),
                            white.withOpacity(0.0)
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(0.0),
            sliver: SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: _toggleFavorite,
                    ),
                    // Text(
                    //   widget.movie.rating.toString(),
                    //   style: const TextStyle(
                    //       fontSize: 14.0,
                    //       fontWeight: FontWeight.bold,
                    //       color: maroon),
                    // ),
                    // Container(
                    //   width: 1.5,
                    //   height: 14.0,
                    //   color: grey,
                    //   margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    // ),
                   // MovieInfo(id: widget.movie.id ?? 0)
                  ],
                ),
              ),
               Padding(
                padding: EdgeInsets.only(left: 14.0, top: 20.0),
                child: Text(
                  (widget.movie.title ?? "").length > 40
                      ? "${widget.movie.title?.substring(0, 37)}..."
                      : widget.movie.title ?? "",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28.0,),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 14.0, right: 14.0, top: 14.0),
                child: Text(
                  widget.movie.overview ?? "",
                  style: const TextStyle(color: black, fontSize: 12.0),
                ),
              ),

            ])),
          )
        ],
      ),
    );
  }
}
