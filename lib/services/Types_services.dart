

import 'package:contabilidadapp/orm/models.dart';
import 'package:contabilidadapp/orm/tables/Typx_Table.dart';

class TypesService {
  int idt;
  String type, subType, natural;

  TypesService(int idt, String type, String subType, natural){
    this.idt = idt;
    this.type = type;
    this.subType = subType;
    this.natural = natural;
  }
  TypesService.onlyId(int idt){
    this.idt = idt;
    this.type ="";
    this.subType = "";
    this.natural = "";
  }

  Future <dynamic> newType() async{
    final type = await Typx(
      idt: this.idt,
      type: this.type,
      subType: this.subType,
      natural: this.natural
    ).save();
    return type;
  }

  Future <dynamic> deleteType() async{
    
    final type = await Typx().select().idt.equals(this.idt).delete(true);
    return type;
  }

}