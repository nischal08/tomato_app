import 'package:flutter/material.dart';

class GeneralTextField extends StatelessWidget {
  const GeneralTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        
        decoration: InputDecoration(
          // filled: true,
          // fillColor: Colors.white.withOpacity(0.9),
          contentPadding: const EdgeInsets.only(
            // left: 14.0,
            // bottom: 8.0,
            top: 13.0,
          ),
          hintText: "Email Address",
          
          suffixIcon: Icon(Icons.check),
          prefixIcon: Icon(Icons.email),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 0.5),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
