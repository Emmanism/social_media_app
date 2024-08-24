import 'package:edusko_media_app/widget/colorconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

enum InputType {
  name,
  username,
  email,
  password,
  number,
  text,
}

class InputField extends StatefulWidget {
  final String placeholder;
  final Function(String text) onChanged;
  final bool hasError;
  final dynamic type;
  final Widget? prefix;
  final double? height;
  final Widget? suffix;
  final int maxLength;
  final String response;
  final Color? color;
  final String helper;
  final int? maline;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final bool isValidateText;

  const InputField({
    super.key,
    this.type = InputType.name,
    this.hasError = false,
    this.prefix,
    this.suffix,
    this.height,
    this.response = "",
    this.color,
    this.helper = "",
    this.maline,
    this.textInputAction = TextInputAction.done,
    this.maxLength = 30,
    this.isValidateText = true,
    required this.onChanged,
    required this.placeholder,
    required this.controller,
  });

  @override
  InputFieldState createState() => InputFieldState();
}

class InputFieldState extends State<InputField> {
  final FocusNode focusNode = FocusNode();
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    bool validator(String input) {
      RegExp regex = RegExp(r".*");

      switch (widget.type) {
        case InputType.name:
          regex = RegExp(r"^[a-zA-Z ]+$");
        case InputType.username:
          regex = RegExp(r"^[a-zA-Z0-9_]+$");
        case InputType.email:
          regex =
              RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b');
        case InputType.password:
          regex = RegExp(
              r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
        case InputType.number:
          regex = RegExp(r'^\d+$');
        case InputType.text:
          regex = RegExp(r".+");
      }

      if (input.isEmpty | !widget.isValidateText) {
        return true;
      }

      return regex.hasMatch(input);
    }

    bool obscureText() {
      if (widget.type == InputType.password) {
        return true;
      }
      return false;
    }

    TextInputType inputType() {
      switch (widget.type) {
        case InputType.name:
          return TextInputType.name;
        case InputType.username:
          return TextInputType.name;
        case InputType.email:
          return TextInputType.emailAddress;
        case InputType.password:
          return TextInputType.visiblePassword;
        case InputType.number:
          return TextInputType.number;
        case InputType.text:
          return TextInputType.text;
      }
      return TextInputType.text;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: widget.height ?? 50.0,
          child: TextFormField(
              textInputAction: widget.textInputAction,
              controller: widget.controller,
              focusNode: focusNode,
              autofocus: false,
              obscureText: obscureText(),
              obscuringCharacter: "*",
              keyboardType: inputType(),
              maxLines: widget.maline ?? 1,
              textAlignVertical: TextAlignVertical.bottom,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: [
                LengthLimitingTextInputFormatter(widget.maxLength),
              ],
              validator: (value) {
                if (validator(value!)) {
                  return null;
                } else {
                  return "Invalid Email!";
                }
              },
              decoration: InputDecoration(
                  prefixIcon: widget.prefix,
                  suffixIcon: widget.suffix,
                  filled: true,
                  fillColor: widget.color ?? Colors.white,
                  hintText: widget.placeholder,
                  hintStyle: TextStyle(
                       // fontFamily: CustomTheme.of(context).titleMediumFamily,
                        color: ColorConstant.black900,
                        letterSpacing: 0,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                        color: ColorConstant.secundary, width: 2.0),
                  ),
                  errorStyle: const TextStyle(
                      // There's provision for a custom error text
                      // This is set to 0 to hide the error text
                      // shown as a result of the form validation
                      fontSize: 0.0),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                        color: Colors.red, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                        color: Colors.red, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  )),
              style: TextStyle(
                  //  fontFamily: CustomTheme.of(context).titleMediumFamily,
                     color: ColorConstant.black900,
                    letterSpacing: 0,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
              onChanged: (input) {
                setState(() {
                  hasError = !validator(input);
                });
                widget.onChanged(input);
              },
              onTap: () {
                focusNode.requestFocus();
              },
              onTapOutside: (_) {
                focusNode.unfocus();
              },
              onEditingComplete: () {
                focusNode.unfocus();
              }),
        ),
        Visibility(
          visible: widget.helper.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.helper,
              textAlign: TextAlign.start,
              style:  TextStyle(
                  //  fontFamily: CustomTheme.of(context).bodySmallFamily,
                    letterSpacing: 0,
                    fontSize: 14.0,
                    color: Colors.black
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
