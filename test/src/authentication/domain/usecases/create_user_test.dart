import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';

import 'authentication_repository.mock.dart';

void main() {
  late CreateUser usecases;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecases = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test('Should call the [AuthRepo.createUser]', () async {
    // arrange
    when(() => repository.createUser(
      name: any(named: 'name'), 
      avatar: any(named: 'avatar'), 
      createdAt: any(named: 'createdAt'))
    ).thenAnswer((_) async => const Right(null));
    // act
    final result = await usecases(params);
    // assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repository.createUser(
        name: params.name, 
        avatar: params.avatar, 
        createdAt: params.createdAt)
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}