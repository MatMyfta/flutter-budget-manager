import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:budget_manager/src/transactions/domain/entities/bank_transaction.dart';
import 'package:budget_manager/src/transactions/services/database_helper.dart';
import 'database_helper_test.mocks.dart';

@GenerateMocks([Database])
void main() {
  late MockDatabase mockDatabase;

  setUp(() {
    // Initialize the FFI and set up the databaseFactory
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    mockDatabase = MockDatabase();
  });

  group('DatabaseHelper', () {
    final bankTransaction = BankTransaction(
      id: 1,
      title: 'Test Transaction',
      description: 'Test Description',
      amount: 100.0,
      type: BankTransactionType.income,
      datetime: DateTime(2024, 11, 02, 18, 20),
    );

    test('should add a bank transaction to the database', () async {
      // arrange
      when(mockDatabase.insert(
        any,
        any,
        conflictAlgorithm: ConflictAlgorithm.replace,
      )).thenAnswer((_) async => 1);

      // act
      final result = await DatabaseHelper.addBankTransaction(bankTransaction);

      // assert
      expect(result, 1);
    });

    test('should update a bank transaction in the database', () async {
      // arrange
      when(mockDatabase.update(
        any,
        any,
        where: anyNamed('where'),
        whereArgs: anyNamed('whereArgs'),
        conflictAlgorithm: ConflictAlgorithm.replace,
      )).thenAnswer((_) async => 1);

      // act
      final result =
          await DatabaseHelper.updateBankTransaction(bankTransaction);

      // assert
      expect(result, 1);
    });

    test('should delete a bank transaction from the database', () async {
      // arrange
      when(mockDatabase.delete(
        any,
        where: anyNamed('where'),
        whereArgs: anyNamed('whereArgs'),
      )).thenAnswer((_) async => 1);

      // act
      final result =
          await DatabaseHelper.deleteBankTransaction(bankTransaction);

      // assert
      expect(result, 1);
    });
  });
}
