import 'package:flutter/material.dart';
import 'package:pole_paris_app/bloc/bloc_exports.dart';

class UserPicture extends StatelessWidget {
  final double radius;
  const UserPicture({super.key, required this.radius});

  @override
  Widget build(BuildContext context) {
    precacheImage(
        const AssetImage('assets/img/placeholder-avatar.png'), context);
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final user = state.user!;
        return CircleAvatar(
          backgroundColor: Colors.white,
          radius: radius,
          foregroundImage: user.picture == null
              ? const AssetImage('assets/img/placeholder-avatar.png')
              : null,
          backgroundImage:
              user.picture == null ? null : NetworkImage(user.picture!),
        );
      },
    );
  }
}
