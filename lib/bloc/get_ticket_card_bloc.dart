import 'package:rxdart/rxdart.dart';
import 'package:sukhingthan_mobile_code_test_23001/widgets/general_item.dart';

import '../models/general.dart';
import '../models/movie_response.dart';
import '../models/ticket.dart';
import '../repository/repository.dart';

class TicketCardBloc {
  final BehaviorSubject<List<Ticket>> _subject =
      BehaviorSubject<List<Ticket>>();

  void updateGeneralItems() {
    _subject.sink.add(generalItemsList);
  }
  List<Ticket> generalItemsList=[
    Ticket(icon: "assets/general/Icons1.png",name: "My e-ticket",descripion1: "There are not\n any yet.",descripion2: "Receive here"),
    Ticket(icon: "assets/general/Icons2.png",name: "Park hours",descripion1: "Today, 13 Feb\n 10am - 5pm",descripion2: "Plan my visit"),

  ];
  dispose() {
    _subject.close();
  }

  BehaviorSubject<List<Ticket>> get subject => _subject;
}

final ticketBloc = TicketCardBloc();
