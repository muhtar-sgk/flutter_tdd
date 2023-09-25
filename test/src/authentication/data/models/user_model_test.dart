import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();
  test('Should be a subclass of [User] entity', () {
    // assert
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('Should return a [UserModel] with the right data', () {
      // act
      final result = UserModel.fromMap(tMap);
      // assert
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('Should return a [UserModel] with the right data', () {
      // act
      final result = UserModel.fromJson(tJson);
      // assert
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('Should return a [Map] with the right data', () {
      // act
      final result = tModel.toMap();
      // assert
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('Should return a [Json] string with the right data', () {
      // act
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id": "1",
        "avatar": "_empty.avatar",
        "createdAt": "_empty.createdAt",
        "name": "_empty.name"
      });
      // assert
      expect(result, tJson);
    });
  });

  group('copyWith', () { 
    test('Should return a [UserModel] with different data', () {
      // act
      final result = tModel.copyWith(name: 'Paul');
      // assert
      expect(result.name, equals('Paul'));
    });
  });
}
