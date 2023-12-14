import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controllers/auth_controller.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/login_screen.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  Widget build(BuildContext context) {

    return GetBuilder<AuthController>(builder: (auth) {
      return ListTile(
        onTap: () {
          if (enableOnTap) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditProfileScreen(),
              ),
            );
          }
        },
        leading: CircleAvatar(
          child: auth.user?.photo == null
              ? const Icon(Icons.person)
              : ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.memory(
              auth.imageBytes,
              fit: BoxFit.fill,
              height: 50,
              width: 50,
            ),
          ),

        ),
        title: Text(
          auth.fullName,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          auth.user?.email ?? '',
          style: const TextStyle(color: Colors.white),
        ),
        trailing: IconButton(
          onPressed: () async {
            await Get.find<AuthController>().clearAuthData();
            // TODO : solve this warning
            if (!context.mounted) return;

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()), (
                route) => false);
          },
          icon: const Icon(Icons.logout),
        ),
        tileColor: Colors.green,
      );
    });
  }


}