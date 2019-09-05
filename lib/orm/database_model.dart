import 'package:contabilidadapp/orm/tables/Seating_Table.dart';
import 'package:contabilidadapp/orm/tables/Transactions_Table.dart';
import 'package:contabilidadapp/orm/tables/Typx_Table.dart';
import 'package:sqfentity/sqfentity.dart';

class DatabaseModel extends SqfEntityModel{
  DatabaseModel(){
    databaseName = "database.db";
    databaseTables = [
      SeatingTable.getInstance,
      TransactionsTable.getInstance,
      TypxTable.getInstance
    ];  
    bundledDatabasePath = null;
  }
  
}