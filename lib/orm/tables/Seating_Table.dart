
import 'package:sqfentity/sqfentity.dart';

class SeatingTable extends SqfEntityTable {
SeatingTable() {
// declare properties of EntityTable
tableName = "Seating";
modelName = null; // If the modelName (class name) is null then EntityBase uses TableName instead of modelName
primaryKeyName = "ids";

// declare fields
fields = [
  SqfEntityField("alias", DbType.text),
  SqfEntityField("date", DbType.text),
];

super.init();
}
static SqfEntityTable _instance;
  static SqfEntityTable get getInstance {
    if (_instance == null) {
      _instance = SeatingTable();
    }
    return _instance;
  }
}