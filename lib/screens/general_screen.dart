import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sukhingthan_mobile_code_test_23001/bloc/get_general_bloc.dart';

import '../models/general.dart';
import '../styles/colors.dart';
import '../widgets/general_item.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key}) : super(key: key);

  @override
  GeneralScreenState createState() => GeneralScreenState();
}

class GeneralScreenState extends State<GeneralScreen> {

  @override
  void initState() {
    super.initState();
    generalBloc.updateGeneralItems(); // Fetch or update the General items
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: generalBloc.subject.stream,
        builder: (context, AsyncSnapshot<List<General>> snapshot) {
          if (snapshot.hasData) {
            return _buildSuccessWidget(snapshot.data!);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error as String);
          } else {
            return _buildLoadingWidget();
          }
        });
  }
  Widget _buildErrorWidget(String error) {
    return Center(
      child: Text("Error occured: $error"),
    );
  }
  Widget _buildLoadingWidget() {
    return SizedBox(
      height: 220.0,
      width: MediaQuery.of(context).size.width,
      child: Shimmer.fromColors(
        baseColor: grey.withOpacity(0.3),
        highlightColor: grey.withOpacity(0.1),
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSuccessWidget(List<General> generalList) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: 140,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Number of columns
          crossAxisSpacing: 2.0, // Spacing between columns
          mainAxisSpacing: 2.0, // Spacing between rows
         // childAspectRatio: 2

        ),
        itemCount: generalList.length, // Number of items in the grid
        itemBuilder: (BuildContext context, int index) {
          return GeneralItem(generalList[index].icon, generalList[index].name);
        },
      ),
    );

  }

}