import 'package:contabilidadapp/orm/models.dart';
import 'package:contabilidadapp/services/Transactions_services.dart';
import 'package:contabilidadapp/services/Types_services.dart';
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

  Future<int> firstSeating() async{
    if( date == null){
      return Future.delayed(Duration(seconds: 1), () => -1);
    }
    final seating = await Seating(
      alias: "Primer Asiento",
      date: date.toString()
    ).save();

    TypesServices serviceTypxProtocol = new TypesServices();
    List<Typx> typesAll= await serviceTypxProtocol.selectAll();

    typesAll.forEach((Typx typx){
      TransactionsService serviceTrans = new TransactionsService(
        idtr: null,
        name: typx.name,
        price: 0,
        seatingRelation: seating,
        typxRelation: typx.idt
      );
      serviceTrans.newTransaction();
    });

    return seating;
  }

  Future<int> newSeating() async{
    if(this.alias == null || date == null){
      return Future.delayed(Duration(seconds: 1), () => -1);
    }
    final seating = await Seating(
      alias: this.alias,
      date: date.toString()
    ).save();

    TypesServices serviceTypxProtocol = new TypesServices();
    List<Typx> typesAll= await serviceTypxProtocol.selectAll();

    typesAll.forEach((Typx typx){
      TransactionsService serviceTrans = new TransactionsService(
        idtr: null,
        name: typx.name,
        price: 0,
        seatingRelation: seating,
        typxRelation: typx.idt
      );
      serviceTrans.newTransaction();
    });
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