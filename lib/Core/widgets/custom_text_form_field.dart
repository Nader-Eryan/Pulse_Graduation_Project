import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomFormField extends StatefulWidget {
  final bool isSuffixIcon;
  final bool isPassWord;
  final String hintText;
  final TextEditingController controller;
  final IconData? prefixIcon;

  final String? Function(String?)? validator;

  const CustomFormField({
    Key? key,
    required this.isSuffixIcon,
    required this.isPassWord,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    required this.validator,
  }) : super(key: key);

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity * 0.9,
      child: TextFormField(
        keyboardType:
            widget.isPassWord ? TextInputType.text : TextInputType.emailAddress,
        validator: widget.validator,
        controller: widget.controller,
        style: const TextStyle(color: Colors.black),
        obscureText: widget.isPassWord ? _obscureText : false,
        // inputFormatters: widget.hintText.contains('email')
        //     ? [
        //         FilteringTextInputFormatter.allow(RegExp(
        //             r'''^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'''))
        //       ]
        //     : widget.hintText.contains('password')
        //         ? [
        //             FilteringTextInputFormatter.allow(RegExp(
        //                 r'''^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).{8,20}$'''))
        //           ]
        //         : [FilteringTextInputFormatter.allow(RegExp('[^a-zA-Z]'))],
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(23.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE4E4E5)),
          ),
          filled: true,
          fillColor: const Color(0xffF9FAFB),
          prefixIcon: Icon(widget.prefixIcon, color: Colors.grey),
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
                  : null
              : null,
        ),
      ),
    );
  }
}
