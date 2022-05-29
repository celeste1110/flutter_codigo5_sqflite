
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class InputTextFieldWidget extends StatelessWidget {
  String text;
  String icono;
  int? maxline;
  TextEditingController controller;
  InputTextFieldWidget({required this.text, required this.icono, this.maxline, required this.controller});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: TextField(
        toolbarOptions: ToolbarOptions(
          paste: true,
        ),
        controller: controller,
        style: GoogleFonts.poppins(
          color: Colors.white,
        ),
        maxLines: maxline,
        cursorColor: kSecondaryColor,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: GoogleFonts.poppins(
            color: Colors.white54,
            fontSize: 13,
          ),
          filled: true,
          fillColor: Color(0xff2A2D37),
          prefixIcon: SvgPicture.asset(
            'assets/images/$icono',
            color: Colors.white54,
            height: 12,
            fit: BoxFit.scaleDown,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
