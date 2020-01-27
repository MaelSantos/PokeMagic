import 'package:poke_magic/model/evolution.dart';

class Evolutions {
  List<Evolution> evolution;

  //(427-9) 210,222,225,226,227,230,231,238,251 dando erro

  Evolutions({this.evolution});

  Evolutions.fromJson(Map<String, dynamic> json) {
    evolution = List();
    for (int i = 1; i <= 428; i++)
      if (i != 210 &&
          i != 222 &&
          i != 225 &&
          i != 226 &&
          i != 227 &&
          i != 230 &&
          i != 231 &&
          i != 238 &&
          i != 251) if (json['$i'] != null)
        evolution.add(Evolution.fromJson(json['$i']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.evolution != null) {
      for (int i = 1; i <= evolution.length; i++)
        data['$i'] = this.evolution[i].toJson();
    }
    return data;
  }
}
