import 'package:budget_manager/src/core/errors/failure.dart';
import 'package:budget_manager/src/transactions/domain/entities/bank_transaction.dart';
import 'package:dartz/dartz.dart';

abstract class BankTransactionsRepository {
  Future<Either<Failure, List<BankTransaction>>> getAllBankTransactions();
  Future<Either<Failure, BankTransaction>> getBankTransaction(int id);
  Future<Either<Failure, int>> addBankTransaction(
      BankTransaction banktransaction);
  Future<Either<Failure, int>> updateBankTransaction(
      BankTransaction banktransaction);
  Future<Either<Failure, int>> deleteBankTransaction(int id);
}
