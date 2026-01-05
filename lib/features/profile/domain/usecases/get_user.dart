import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/profile/domain/entities/profile.dart';
import 'package:clean_architecture/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class GetUser {
  final ProfileRepository profileRepository;

  const GetUser(this.profileRepository);

  Future<Either<Failure, Profile>> execute(int id) async {
    return await profileRepository.getUser(id);
  }
}
