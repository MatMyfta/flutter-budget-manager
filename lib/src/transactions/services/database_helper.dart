import 'package:budget_manager/src/transactions/domain/entities/bank_transaction.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "transactions.db";
  static const String _tableName = "transactions";

  // Column names
  static const String columnId = "id";
  static const String columnTitle = "title";
  static const String columnDescription = "description";
  static const String columnAmount = "amount";
  static const String columnIncome = "income";
  static const String columnDateTime = "datetime";

  static Future<Database> _getDb() async {
    return openDatabase(
      path.join(await getDatabasesPath(), _dbName),
      version: _version,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $_tableName($columnId INTEGER PRIMARY KEY, $columnTitle TEXT NOT NULL, $columnDescription TEXT, $columnAmount DOUBLE NOT NULL, $columnIncome TINYINT NOT NULL, $columnDateTime DATETIME NOT NULL);",
        );
      },
    );
  }

  // Utility function to get a reference to the database table
  static Future<Database> _getDatabase() => _getDb();

  // Generalized method to add an item to any table
  static Future<int> addItem(String table, Map<String, dynamic> data) async {
    final db = await _getDatabase();
    return await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Generalized method to update an item in any table
  static Future<int> updateItem(String table, Map<String, dynamic> data,
      String where, List<Object?> whereArgs) async {
    final db = await _getDatabase();
    return await db.update(
      table,
      data,
      where: where,
      whereArgs: whereArgs,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Generalized method to delete an item from any table
  static Future<int> deleteItem(
      String table, String where, List<Object?> whereArgs) async {
    final db = await _getDatabase();
    return await db.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  // Generalized method to retrieve items from any table
  static Future<List<Map<String, dynamic>>> getItems(String table,
      {String? where, List<Object?>? whereArgs}) async {
    final db = await _getDatabase();
    return await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  // Specific method to add a BankTransaction
  static Future<int> addBankTransaction(BankTransaction transaction) async {
    return await addItem(_tableName, transaction.toJson());
  }

  // Specific method to update a BankTransaction
  static Future<int> updateBankTransaction(BankTransaction transaction) async {
    return await updateItem(
        _tableName, transaction.toJson(), '$columnId = ?', [transaction.id]);
  }

  // Specific method to delete a BankTransaction
  static Future<int> deleteBankTransaction(BankTransaction transaction) async {
    return await deleteItem(_tableName, '$columnId = ?', [transaction.id]);
  }

  // Specific method to get all BankTransactions
  static Future<List<BankTransaction>> getAllBankTransactions() async {
    final transactions = await getItems(_tableName);
    return transactions.map((json) => BankTransaction.fromJson(json)).toList();
  }
}
