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

  SeatingServices.first({
    @required this.date
  });

  SeatingServices.delete();

  Future<int> firstSeating(){
    if( date == null){
      return Future.delayed(Duration(seconds: 1), () => -1);
    }
    final seating = Seating(
      alias: "Primer Asiento",
      date: date.toString()
    ).save();

    return seating;
  }

  Future<int> newSeating() {
    if(this.alias == null || date == null){
      return Future.delayed(Duration(seconds: 1), () => -1);
    }
    final seating = Seating(
      alias: this.alias,
      date: date.toString()
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

  Future<bool> deleteAllDataBase(){

    final transactions = Transaction().select().delete();
    final types = Typx().select().delete();
    final seating = Seating().select().delete();

    return Future.delayed(Duration(seconds: 1), () => true);
  }

}