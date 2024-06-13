import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/generated/l10n.dart';

class CustomFormField extends StatefulWidget {
  final bool isSuffixIcon;
  final bool isPassWord;
  final String hintText;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final String? data;
  final double? radius;
  final bool? isPhone;

  final String? Function(String?)? validator;

  const CustomFormField({
    Key? key,
    required this.isSuffixIcon,
    required this.isPassWord,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    required this.validator,
    this.data,
    this.isPhone,
    this.radius,
  }) : super(key: key);

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _obscureText = true;
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    if (widget.data != null && widget.controller.text.isEmpty) {
      widget.controller.text = widget.data!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity * 0.9,
      child: TextFormField(
        readOnly: widget.isSuffixIcon && !widget.isPassWord,
        keyboardType: widget.isPassWord
            ? TextInputType.text
            : widget.isPhone == null
                ? TextInputType.emailAddress
                : TextInputType.phone,
        validator: widget.validator,
        controller: widget.controller,
        style: const TextStyle(color: Colors.black),
        obscureText: widget.isPassWord ? _obscureText : false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(23.0),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffE4E4E5)),
            borderRadius:
                BorderRadius.all(Radius.circular(widget.radius ?? 0.0)),
          ),
          filled: true,
          fillColor: const Color(0xffF9FAFB),
          prefixIcon: Icon(widget.prefixIcon,
              color: Colors.grey,
              size: widget.radius != null ? 20 : widget.radius),
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff407CE2)),
            borderRadius:
                BorderRadius.all(Radius.circular(widget.radius ?? 0.0)),
          ),
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
                  : PopupMenuButton<String>(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_selectedGender ?? S.of(context).normalPatient),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      itemBuilder: (context) => <String>[
                        S.of(context).normalPatient,
                        S.of(context).careGiver,
                        S.of(context).careReceiver,
                      ].map((String value) {
                        return PopupMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onSelected: (newValue) {
                        setState(() {
                          _selectedGender = newValue;
                          widget.controller.text = newValue;
                        });
                      },
                    )
              : null,
        ),
      ),
    );
  }
}
