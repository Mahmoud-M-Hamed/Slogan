import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slogan/styles/colors.dart';

extension EmptySize on num{
  SizedBox get ph => SizedBox(height: toDouble(),);
  SizedBox get pw => SizedBox(width: toDouble(),);
}


Widget defaultTextField({
  TextEditingController? textEditingController,
  FormFieldValidator<String>? validator,
  ValueChanged<String>? onSubmitted,
  ValueChanged<String>? onChanged,
  GestureTapCallback? onTap,
  VoidCallback? onPressedIconSuffix,
  TextInputType? keyboardType = TextInputType.emailAddress,
  bool obscureText = true,
  String? labelText,
  String? hintText,
  IconData? prefixIcon,
  IconData? suffixIcon,
  List<TextInputFormatter>? inputFormatters,
  double contentPaddingHorizontal = 20,
  double contentPaddingVertical = 20,
  double topLeft = 20,
  double topRight = 20,
  double bottomLeft = 20,
  double bottomRight = 20,
}) =>
    TextFormField(
      keyboardAppearance: Brightness.dark,
      inputFormatters: inputFormatters,
      controller: textEditingController,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            horizontal: contentPaddingHorizontal,
            vertical: contentPaddingVertical),
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: onPressedIconSuffix,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeft),
            topRight: Radius.circular(topRight),
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight),
          ),
        ),
      ),
    );

Widget defaultMaterialButton({
  required VoidCallback? onPressed,
  required Widget? child,
  VoidCallback? onLongPress,
  double? height,
  Color? color,
  Color? splashColor = mainColor,
  double? radius = 15,
  double? horizontal = 5,
  double? vertical = 5,
  double? elevation = 5,
}) =>
    MaterialButton(
      onPressed: onPressed,
      height: height,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius!),
      ),
      padding:
          EdgeInsets.symmetric(horizontal: horizontal!, vertical: vertical!),
      splashColor: splashColor,
      elevation: elevation,
      onLongPress: onLongPress,
      child: child,
    );
