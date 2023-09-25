import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  const tException = ApiFailure(message: 'message', statusCode: 500);

  group('createUser', () {
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';
    const createdAt = 'whatever.createdAt';

    test('CREATE USER - Should call RemoteDataSource.createUser', () async {
      // arrange
      when(() => remoteDataSource.createUser(
              name: any(named: 'name'),
              avatar: any(named: 'avatar'),
              createdAt: any(named: 'createdAt')))
          .thenAnswer((_) async => Future.value());

      // act
      final result = await repoImpl.createUser(
          name: name, avatar: avatar, createdAt: createdAt);

      // assert
      expect(result, equals(const Right(null)));
      verify(() => remoteDataSource.createUser(
          name: name, avatar: avatar, createdAt: createdAt)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('FAKE EXCEPTION - Should return a APIFailure', () async {
      when(() => remoteDataSource.createUser(
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
          createdAt: any(named: 'createdAt'))).thenThrow(tException);

      final result = await repoImpl.createUser(
          name: name, avatar: avatar, createdAt: createdAt);

      expect(
          result,
          equals(Left(ApiFailure(
              message: tException.message,
              statusCode: tException.statusCode))));
      });

      verify(() => remoteDataSource.createUser(
        name: name, 
        avatar: avatar, 
        createdAt: createdAt)
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
  });

  group('getUsers', () {
    test('GET USERS - Should call RemoteDatasource.getUsers', () async {
      when(() => remoteDataSource.getUsers()).thenAnswer(
        (_) async => [] 
      );

      final result = await repoImpl.getUsers();

      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('FAKE EXCEPTION - Should return a APIFailure', () async {
      when(() => remoteDataSource.getUsers()).thenThrow(tException);
      final result = await repoImpl.getUsers();
      expect(result, equals(Left(ApiFailure.fromException(tException as APIException))));
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
