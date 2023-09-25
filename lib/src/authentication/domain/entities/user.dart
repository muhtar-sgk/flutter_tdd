import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String id;
  final String name;
  final String createdAt;
  final String avatar;

  const User({required this.id, required this.name, required this.createdAt, required this.avatar});

  const User.empty()
    : this(
      createdAt: '_empty.createdAt',
      name: '_empty.name', 
      avatar: '_empty.avatar',
      id: '1'
    );

  @override
  List<Object?> get props => [id, name, createdAt];
}