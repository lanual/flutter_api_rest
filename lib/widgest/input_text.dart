import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final bool oscure, isBorder;
  final double fontSize;
  final void Function(String) onChanged;
  final String Function(String) validator;
  const InputText({
    Key key,
    this.labelText = '',
    this.oscure = false,
    this.isBorder = true,
    this.fontSize = 15,
    this.onChanged,
    this.validator,
    @required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: this.onChanged,
      validator: validator,
      style: TextStyle(fontSize: this.fontSize),
      keyboardType: this.keyboardType,
      obscureText: this.oscure,
      decoration: InputDecoration(
        //suffix: Text('Forwot Password'),
        enabledBorder: isBorder
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black12,
                ),
              )
            : InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        labelText: this.labelText,
        labelStyle: TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
