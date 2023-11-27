import 'package:rxdart/rxdart.dart';

import '../models/general.dart';

class GeneralBloc {
  final BehaviorSubject<List<General>> _subject =
      BehaviorSubject<List<General>>();

  void updateGeneralItems() {
    _subject.sink.add(generalItemsList);
  }
  List<General> generalItemsList=[
    General(icon: "assets/general/map.png",name: "Map"),
    General(icon: "assets/general/inhabitants.png",name: "Inhabitants"),
    General(icon: "assets/general/show.png",name: "Shows"),
    General(icon: "assets/general/shopping.png",name: "Shopping"),
    General(icon: "assets/general/dine.png",name: "Dine"),
    General(icon: "assets/general/meet.png",name: "Meet and Greets"),
  ];
  dispose() {
    _subject.close();
  }

  BehaviorSubject<List<General>> get subject => _subject;
}

final generalBloc = GeneralBloc();
