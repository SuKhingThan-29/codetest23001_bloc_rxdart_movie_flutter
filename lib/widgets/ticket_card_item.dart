import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/ticket.dart';
import '../styles/colors.dart';

class TicketCardItem extends StatelessWidget {
  const TicketCardItem(this.ticket, {super.key}
      );
  final Ticket ticket;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: Card(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child:Text(ticket.name,style:TextStyle(color: Colors.black,fontSize: 12),),),

                Container(
                  margin: EdgeInsets.all(5),
                  child: Image.asset(
                    ticket.icon,
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              child:Text(ticket.descripion1,style:TextStyle(color: ticket.name=="My e-ticket"?Colors.grey:Colors.black,fontSize: 16),),),
            Spacer(),
            Container(
              margin: EdgeInsets.all(10),
              child:Text(ticket.descripion2,style:TextStyle(color: Colors.red,fontSize: 12),),)

          ],
        ),
      ),
    );
  }
}