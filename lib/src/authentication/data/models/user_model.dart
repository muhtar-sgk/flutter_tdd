import 'dart:convert';

import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

import '../../../../core/utils/typedef.dart';

class UserModel extends User {
  const UserModel({
    required super.avatar,
    required super.name,
    required super.createdAt, 
    required super.id
  });

  const UserModel.empty() 
    : this(
      id: '1',
      createdAt: '_empty.createdAt', 
      name: '_empty.name', 
      avatar: '_empty.avatar' 
  );

  factory UserModel.fromJson(String source) => UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map) : 
    this(
      avatar: map['avatar'] as String,
      id: map['id'] as String,
      createdAt: map['createdAt'] as String,
      name: map['name'] as String,
    );
  
  UserModel copyWith({
    String? avatar,
    String? id,
    String? createdAt,
    String? name
  }) {
    return UserModel(
      avatar: avatar ?? this.avatar, 
      name: name ?? this.name, 
      createdAt: createdAt ?? this.createdAt, 
      id: id ?? this.id
    );
  }
  
  DataMap toMap() => {
    'id': id,
    'avatar': avatar,
    'createdAt': createdAt,
    'name': name
  };

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props => [id];
}