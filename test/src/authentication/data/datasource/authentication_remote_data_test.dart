import 'dart:convert';
import 'dart:html';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/utils/constant.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  group('createUesr', () {
    test('Should successfully with status code is 200 or 201', () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('User created successfully', 201));

      final methodCall = remoteDataSource.createUser;

      expect(methodCall(name: 'name', avatar: 'avatar', createdAt: 'createdAt'),
          Future.value());

      verify(() => client.post(Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode({
            'name': 'name',
            'avatar': 'avatar',
            'createdAt': 'createdAt'
          }))).called(1);

      verifyNoMoreInteractions(client);
    });

    test('Should throw exception when status code is not 200 or 201', () async {
      when(() => client.post(any(), body: any(named: 'body')))
        .thenAnswer((_) async => http.Response('Invalid email address', 400));
      });

      final methodCall = remoteDataSource.createUser;

      expect(() async => methodCall(name: 'name', avatar: 'avatar', createdAt: 'createdAt'),
        throwsA(const APIException(message: 'Invalid email address', statusCode: 400)));

    verify(() => client.post(Uri.https(kBaseUrl, kCreateUserEndpoint),
        body: jsonEncode({
          'name': 'name',
          'avatar': 'avatar',
          'createdAt': 'createdAt'
        }))).called(1);

    verifyNoMoreInteractions(client);
  });

  group('getUsers', () {
    const tUsers = [UserModel.empty()];

    test('GET USERS - Should return List<User>', () async {
      when(() => client.get(any())).thenAnswer((_) async => http.Response
      (jsonEncode([tUsers.first.toMap()]), 200));

      final result = await remoteDataSource.getUsers();

      expect(result, equals(tUsers));

      verify(() => client.get(
        Uri.https(kBaseUrl, kGetUsersEndpoint)
      )).called(1);

      verifyNoMoreInteractions(client);
    });

    test('GET USERS - Should throw API Exception when status code is not 200 or 201', () async {
      const tMessage = 'Server down';

      when(() => client.get(any())).thenAnswer((_) async => http.Response
        (tMessage, 500));
      
      final methodCall = remoteDataSource.getUsers;

      expect(() => methodCall, throwsA(
        const APIException(message: tMessage, statusCode: 500)
      ));

      verify(() => client.get(
        Uri.https(kBaseUrl, kGetUsersEndpoint)
      )).called(1);

      verifyNoMoreInteractions(client);

    });
  });
}
