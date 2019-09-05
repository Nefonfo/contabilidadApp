import 'package:contabilidadapp/orm/tables/Seating_Table.dart';
import 'package:contabilidadapp/orm/tables/Typx_Table.dart';
import 'package:sqfentity/sqfentity.dart';

class TransactionsTable extends SqfEntityTable {
TransactionsTable() {
// declare properties of EntityTable
tableName = "Transactions";
modelName = null; // If the modelName (class name) is null then EntityBase uses TableName instead of modelName
primaryKeyName = "idtr";

// declare fields
fields = [
  SqfEntityField("name", DbType.text), // el nombre de la cuenta
  SqfEntityField("price", DbType.real, defaultValue: "0"),
  SqfEntityFieldRelationship(TypxTable.getInstance, DeleteRule.CASCADE),
  SqfEntityFieldRelationship(SeatingTable.getInstance, DeleteRule.CASCADE),
];

super.init();
}
static SqfEntityTable _instance;
  static SqfEntityTable get getInstance {
    if (_instance == null) {
      _instance = TransactionsTable();
    }
    return _instance;
  }
}