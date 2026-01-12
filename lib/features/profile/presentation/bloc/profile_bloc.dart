import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/profile/domain/entities/profile.dart';
import 'package:clean_architecture/features/profile/domain/usecases/get_all_user.dart';
import 'package:clean_architecture/features/profile/domain/usecases/get_user.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetAllUser getAllUser;
  final GetUser getUser;

  ProfileBloc({required this.getAllUser, required this.getUser}) : super(ProfileStateEmpty()) {
    on<ProfileEventGetAllUsers>((event, emit) async {
      emit(ProfileStateLoading());
      Either<Failure, List<Profile>> hasilGetAllUser = await getAllUser.execute(event.page);
      hasilGetAllUser.fold(
        (failure) {
          emit(ProfileStateError('Cannot get all users'));
        },
        (listProfile) {
          emit(ProfileStateLoadedAllUsers(listProfile));
        },
      );
    });
    on<ProfileEventGetDetailUsers>((event, emit) async {

       emit(ProfileStateLoading());
      Either<Failure, Profile> hasilGetUser = await getUser.execute(event.userId);
      hasilGetUser.fold(
        (failure) {
          emit(ProfileStateError('Cannot get all users'));
        },
        (rightHasilGetUser) {
          emit(ProfileStateLoadedUser(rightHasilGetUser));
        },
      );
    });
  }
}
