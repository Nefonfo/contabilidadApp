import 'package:contabilidadapp/constants/constants.dart' as constants;
import 'package:contabilidadapp/orm/models.dart';
import 'package:flutter/widgets.dart';

class TypesServices {
  int idt;
  String name, type, subType, natural;

  TypesServices(
      {this.idt,
       this.name,
       this.type,
       this.subType,
       this.natural});

  TypesServices.onlyId({@required this.idt}) : assert(idt != null);

  TypesServices.firstProtocol();

  Future<Null> fistProtocolInsert() async{
    for(Map<String,String> type in constants.types){
      TypesServices add = new TypesServices(
        name: type['name'],
        type: type['type'],
        subType: type['subType'],
        natural: type['natural']
      );
      add.newType();
    }
  }

  Future<int> newType() async {
    final type = await Typx(
            name: this.name,
            type: this.type,
            subType: this.subType,
            natural: this.natural)
        .save();
    return type;
  }

  Future<int> updateType() async {
    final type = await Typx(
            idt: this.idt,
            name: this.name,
            natural: this.natural,
            subType: this.subType,
            type: this.type)
        .save();
    return type;
  }

  Future<dynamic> deleteTypeById() async {
    final type = await Typx().select().idt.equals(this.idt).delete(true);
    return type;
  }

  Future<List<Typx>> selectAll() async {
    final type = await Typx().select().toList();
    return type;
  }

  Future<List<Typx>> selectWhere(String what, dynamic equals) async {
    dynamic type;
    switch (what) {
      case "idt":
         type = await Typx().select().idt.equals(equals).toList();
        break;
      case "name":
         type = await Typx().select().name.equals(equals).toList();
        break;
      case "type":
         type = await Typx().select().type.equals(equals).toList();
        break;
      case "subType":
         type = await Typx().select().subType.equals(equals).toList();
        break;
      case "natural":
         type = await Typx().select().natural.equals(equals).toList();
        break;
      case "default":
          type = await Typx().select().toList();
        break;
    }
    return type;
  }
}
