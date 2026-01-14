import 'package:clean_architecture/features/profile/domain/entities/profile.dart';
import 'package:clean_architecture/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:clean_architecture/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailUsersPage extends StatelessWidget {
  final int userId;
  const DetailUsersPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Users $userId')),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: myinjection<ProfileBloc>()
          ..add(ProfileEventGetDetailUsers(userId)),
        builder: (context, state) {
          if (state is ProfileStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileStateError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is ProfileStateLoadedUser) {
            Profile profile = state.detailUser;
            return Card(
              margin: const EdgeInsets.all(20.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(profile.profileImageUrl),
                    ),
                    SizedBox(height: 20.0),
                    Text('ID: ${profile.id}', style: TextStyle(fontSize: 18.0)),
                    Text(
                      'Full Name: ${profile.fullName}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      'Email: ${profile.email}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text(" EMPTY USERS"));
          }
        },
      ),
    );
  }
}
