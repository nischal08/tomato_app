import 'package:flutter/material.dart';

class GeneralTextField extends StatelessWidget {
  final String labelText;
  final IconData? suffixIcon;
  final IconData preferIcon;
  final bool obscureText;
  VoidCallback? onClickPsToggle;
  final TextInputType keywordType;
  final Function validate;
  final Function onFieldSubmit;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final Function onSave;
  final TextEditingController? controller;

  GeneralTextField({
    Key? key,
    required this.labelText,
    required this.suffixIcon,
    required this.preferIcon,
    required this.obscureText,
    this.onClickPsToggle,
    required this.keywordType,
    required this.validate,
    required this.onFieldSubmit,
    required this.textInputAction,
    this.focusNode,
    required this.onSave,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onSaved: (newValue) => onSave(newValue),
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: (newValue) => onFieldSubmit(newValue),
      validator: (value) => validate(value),
      keyboardType: keywordType,
      // controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          top: 13.0,
        ),
        hintText: labelText,
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: onClickPsToggle,
                icon: Icon(
                  suffixIcon,
                ),
              )
            : null,
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
