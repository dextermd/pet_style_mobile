import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final String name;
  final String? image;

  const UserInfo({
    super.key,
    required this.name,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Text(" \u{1F44B} Привет!"),
      subtitle: Text(name),
      trailing: CircleAvatar(
          radius: 30,
          backgroundImage: image != null
              ? NetworkImage(image ?? '')
              : const AssetImage('assets/images/default_profile.png')
                  as ImageProvider),
    );
  }
}
