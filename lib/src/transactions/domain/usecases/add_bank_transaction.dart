import 'package:budget_manager/src/core/errors/failure.dart';
import 'package:budget_manager/src/transactions/data/repositories/bank_transactions_repository.dart';
import 'package:budget_manager/src/transactions/domain/entities/bank_transaction.dart';
import 'package:dartz/dartz.dart';

class AddBankTransaction {
  final BankTransactionsRepository repository;

  AddBankTransaction(this.repository);

  Future<Either<Failure, int>> call(
      {required BankTransaction bankTransaction}) async {
    return await repository.addBankTransaction(bankTransaction);
  }
}
