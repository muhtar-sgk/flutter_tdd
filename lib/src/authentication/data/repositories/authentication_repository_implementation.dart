import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation implements AuthenticationRepository {

  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required String name, 
    required String avatar, 
    required String createdAt
  }) async {
    try {
      await _remoteDataSource.createUser(name: name, avatar: avatar, createdAt: createdAt);
      return const Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}