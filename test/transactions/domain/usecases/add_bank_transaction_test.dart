import 'package:budget_manager/src/transactions/data/repositories/bank_transactions_repository.dart';
import 'package:budget_manager/src/transactions/domain/entities/bank_transaction.dart';
import 'package:budget_manager/src/transactions/domain/usecases/add_bank_transaction.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'add_bank_transaction_test.mocks.dart';

// Generate the mock class with the following command:
// flutter pub run build_runner build
@GenerateMocks([BankTransactionsRepository])
void main() async {
  late MockBankTransactionsRepository mockRepository;
  late AddBankTransaction usecase;

  setUp(() {
    mockRepository = MockBankTransactionsRepository();
    usecase = AddBankTransaction(mockRepository);
  });

  group('AddBankTransaction', () {
    final bankTransaction = BankTransaction(
      id: 1,
      title: 'Title',
      amount: 100.0,
      datetime: DateTime(2024, 11, 02, 17, 57),
      description: 'Test Transaction',
      type: BankTransactionType.income,
    );

    test(
        'should return int (transaction ID) when the repository successfully adds the transaction',
        () async {
      // arrange
      when(mockRepository.addBankTransaction(bankTransaction))
          .thenAnswer((_) async => const Right(1));

      // act
      final result = await usecase(bankTransaction: bankTransaction);

      // assert
      expect(result, const Right(1));
      verify(mockRepository.addBankTransaction(bankTransaction));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
