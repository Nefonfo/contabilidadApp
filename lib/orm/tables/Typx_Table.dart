import 'package:sqfentity/sqfentity.dart';

class TypxTable extends SqfEntityTable {
TypxTable() {
// declare properties of EntityTable
tableName = "Typx";
modelName = null; // If the modelName (class name) is null then EntityBase uses TableName instead of modelName
primaryKeyName = "idt";

// declare fields
fields = [
  SqfEntityField("name", DbType.text),
  SqfEntityField("type", DbType.text),  // Activos, pasivos, capital, resultados
  SqfEntityField("subType", DbType.text, defaultValue: null), // circulante, dif, etc
  SqfEntityField("natural", DbType.text),
];

super.init();
}
static SqfEntityTable _instance;
  static SqfEntityTable get getInstance {
    if (_instance == null) {
      _instance = TypxTable();
    }
    return _instance;
  }
}