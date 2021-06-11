import 'package:flutter/material.dart';

class GeneralTextField extends StatelessWidget {
  final String labelText;
  final IconData? suffixIcon;
  final IconData preferIcon;
  final bool obscureText;

  const GeneralTextField({
    Key? key,
    required this.labelText,
    required this.suffixIcon,
    required this.preferIcon,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          top: 13.0,
        
        ),
        hintText: labelText,
        suffixIcon: Icon(suffixIcon),
        prefixIcon: Container(
       width: 25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(preferIcon),
              // Spacer(),
             Container(
                height: 30,
                width: 1,
                color: Colors.grey,
              )

            ],
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
          // borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 0.5),
          // borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
