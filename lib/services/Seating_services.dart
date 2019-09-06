import 'package:contabilidadapp/orm/models.dart';
import 'package:flutter/widgets.dart';

class SeatingServices{
  int ids;
  String alias;
  DateTime date;

  SeatingServices({
    this.ids,
    this.alias,
    this.date
  });

  SeatingServices.first();

  Future<int> firstSeating(){
    final seating = Seating(
      alias: "Primer Asiento",
      date: DateTime.now().toString()
    ).save();

    return seating;
  }

  Future<int> newSeating() {
    final seating = Seating(
      alias: this.alias,
      date: DateTime.now().toString()
    ).save();
    return seating;
  }

  Future<int> updateSeating(){
    final seating = Seating(
      ids: ids,
      alias: alias,
      date: date.toString()
    ).save();

    return seating;
  }

  Future<dynamic> deleteSeatingById(){
    final seating = (this.ids == 0) ? null : Seating().select().ids.equals(this.ids).delete(); 
    return seating;
  }

  Future<List<Seating>> selectAll(){
    final seating = Seating().select().toList();
    return seating;
  }

}