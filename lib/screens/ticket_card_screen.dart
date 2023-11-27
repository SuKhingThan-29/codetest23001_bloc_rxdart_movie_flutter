import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sukhingthan_mobile_code_test_23001/bloc/get_general_bloc.dart';
import 'package:sukhingthan_mobile_code_test_23001/bloc/get_ticket_card_bloc.dart';
import 'package:sukhingthan_mobile_code_test_23001/widgets/ticket_card_item.dart';

import '../models/general.dart';
import '../models/ticket.dart';
import '../styles/colors.dart';
import '../widgets/general_item.dart';

class TicketCardScreen extends StatefulWidget {
  const TicketCardScreen({Key? key}) : super(key: key);

  @override
  TicketCardScreenState createState() => TicketCardScreenState();
}

class TicketCardScreenState extends State<TicketCardScreen> {

  @override
  void initState() {
    super.initState();
    ticketBloc.updateGeneralItems(); // Fetch or update the General items
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ticketBloc.subject.stream,
        builder: (context, AsyncSnapshot<List<Ticket>> snapshot) {
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

  Widget _buildSuccessWidget(List<Ticket> generalList) {
    print("GeneralList: ${generalList.length}");
    return Container(
      margin: const EdgeInsets.all(10),
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: generalList.length, // Number of items in the grid
        itemBuilder: (BuildContext context, int index) {
          return TicketCardItem(generalList[index]);
        },
      ),
    );

  }

}