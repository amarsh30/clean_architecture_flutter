import 'package:flutter/material.dart';

class DetailUsersPage extends StatelessWidget {
  final int userId;
  const DetailUsersPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Users $userId')),
      body: Card(
        margin: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                  'https://reqres.in/img/faces/1-image.jpg',
                ),
              ),
              SizedBox(height: 20.0),
              Text('ID: User 1', style: TextStyle(fontSize: 18.0)),
              Text(
                'Full Name: user1@example.com',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                'Email: user1@example.com',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
