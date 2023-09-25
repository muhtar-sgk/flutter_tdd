import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/authentication_repository.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultVoid call(CreateUserParams params) async => _repository.createUser(
      name: params.name, avatar: params.avatar, createdAt: params.createdAt);
}

class CreateUserParams extends Equatable {
  final String name;
  final String avatar;
  final String createdAt;

  const CreateUserParams(
      {required this.name, required this.avatar, required this.createdAt});
  
  const CreateUserParams.empty()
    : this(
      name: '_empty.name',
      avatar: '_empty.avatar',
      createdAt: '_empty.createdAt'
    );

  @override
  List<Object?> get props => [name, avatar, createdAt];
}
