import 'package:flutter/material.dart';
import 'package:sukhingthan_mobile_code_test_23001/screens/general_screen.dart';
import 'package:sukhingthan_mobile_code_test_23001/screens/ticket_card_screen.dart';
import 'package:sukhingthan_mobile_code_test_23001/widgets/movies_playing.dart';
import 'package:sukhingthan_mobile_code_test_23001/widgets/upcoming_movies.dart';

import '../styles/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Adjust the width as needed
            Spacer(),
            Image.asset(
              "assets/general/logo.png",  // Replace with your image asset path
              width: 70,  // Adjust the width as needed
              height: 70,  // Adjust the height as needed
            ),
            Spacer(),
            Image.asset(
              "assets/general/Leading-icon.png",  // Replace with your image asset path
              width: 24,  // Adjust the width as needed
              height: 24,  // Adjust the height as needed
            ),
          ],
        )
        ),

      body: ListView(
        children:  [
          MoviesPlaying(),
          GeneralScreen(),
          TicketCardScreen(),
          UpComingMovies(),
        ],
      ),
      //body: GeneralScreen(),
    );
  }
}
