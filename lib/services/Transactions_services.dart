import 'package:contabilidadapp/orm/models.dart';

class TransactionsService{
  int idtr;
  String name;
  double price;
  int typxRelation;
  int seatingRelation;
  TransactionsService({
    this.idtr,
    this.name,
    this.price,
    this.typxRelation,
    this.seatingRelation
  });

  Future<int> newTransaction(){
    final transaction = Transaction(
      idtr: null,
      name: name,
      price: (price != null) ? price: 0,
      TypxIdt: this.typxRelation,
      SeatingIds: this.seatingRelation
    ).save();

    return transaction;
  }

  Future<int> updatePriceTransaction(){
     final transaction = Transaction(
      idtr: idtr,
      name: name,
      price: (price != null) ? price: 0,
      TypxIdt: this.typxRelation,
      SeatingIds: this.seatingRelation
    ).save();

    return transaction;
  }

  Future<List<Transaction>> getAllTransactionsBySeatingsIdAndType(String typex) async{
    List<Typx> type = await Typx().select().type.equals(typex).toList();
    List<int> typesId = [];

    type.forEach((Typx c){
      typesId.add(c.idt);
    });
    final List<Transaction> data = await Transaction().select().SeatingIds.equals(this.seatingRelation).and.TypxIdt.inValues(typesId).toList();
    data.forEach((Transaction c){
      print(c.name);
    });
    return data;
  }

  Future<Transaction> getMoneyByIdAndName() async{
    final List<Transaction> data = await Transaction().select().SeatingIds.equals(this.seatingRelation).and.name.equals(this.name).toList();
    return data.first;
  }


  Future<double> getSigmaOfType(String type) async{
    final List<Transaction> data = await Transaction().select(columnsToSelect: ["price"]).name.equals("$type").toList();
    double total = 0;
    data.forEach((Transaction c){
      total += c.price;
    });

    return total;
  }


  
}