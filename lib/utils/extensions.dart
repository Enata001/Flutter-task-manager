import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/models/userdata.dart';

extension Messenger on BuildContext {
  messenger({
    required String title,
    required String description,
    required IconData icon,
  }) {
    //Custom SnackBar for error messages
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(this).primaryColor,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    description,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        duration: Durations.extralong4,
      ),
    );
  }
}
extension UserInfo on SharedPreferences{
  Userdata? getUserdata(){
    String? userDataString = getString('user_data');
    return Userdata.fromString(userDataString);
  }
}