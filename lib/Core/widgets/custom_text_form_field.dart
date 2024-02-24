import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomFormField extends StatefulWidget {
  final bool isSuffixIcon;
  final bool isPassWord;
  final String hintText;
  final TextEditingController controller;
  final IconData? prefixIcon;

  final String? Function(String?)? validator;

  const CustomFormField({
    super.key,
    required this.isSuffixIcon,
    required this.isPassWord,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    required this.validator,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _obscureText = true;
  String? _selectedGender;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity * 0.9,
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        style: const TextStyle(color: Colors.black),
        obscureText: widget.isPassWord ? _obscureText : false,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xffF9FAFB),
          prefixIcon: Icon(widget.prefixIcon),
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF407CE2))),
          suffixIcon: widget.isSuffixIcon
              ? widget.isPassWord
                  ? IconButton(
                      icon: FaIcon(
                        _obscureText
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : DropdownButton<String>(
                      hint: const Text('Enter your role'),
                      value: _selectedGender,
                      items:
                          <String>['patient', 'Guardian '].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                    )
              : null, //
        ),
      ),
    );
  }
}
