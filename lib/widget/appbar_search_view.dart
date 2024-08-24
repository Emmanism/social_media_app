import 'package:edusko_media_app/widget/custom_image_view.dart';
import 'package:edusko_media_app/widget/custom_search_view.dart';
import 'package:edusko_media_app/widget/sizeutill.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppbarSearchview extends StatelessWidget {
  AppbarSearchview(
      {Key? key,
      this.hintText,
      this.controller,
      this.margin,
      this.onSubmitted,
      this.onTap})
      : super(
          key: key,
        );

  String? hintText;

  TextEditingController? controller;

  EdgeInsetsGeometry? margin;

  Function(String)? onSubmitted;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: margin ?? getPadding(top: 5, right: 10),
        child: CustomSearchView(
          onSubmitted: onTap,
          width: getHorizontalSize(
            295,
          ),
          height: getVerticalSize(45),
          focusNode: FocusNode(),
          autofocus: false,
          controller: controller,
          hintText: hintText,
          prefix: Container(
            margin: getMargin(
              left: 19,
              top: 9,
              right: 10,
              bottom: 9,
            ),
            child: CustomImageView(
              svgPath: "assets/images/img_search.svg",
            ),
          ),
          prefixConstraints: BoxConstraints(
            maxHeight: getVerticalSize(
              33,
            ),
          ),
          suffix: GestureDetector(
            child: Container(
              margin: getMargin(
                left: 30,
                top: 6,
                right: 12,
                bottom: 6,
              ),
              
            ),
          ),
          suffixConstraints: BoxConstraints(
            maxHeight: getVerticalSize(
              37,
            ),
          ),
        ),
      ),
    );
  }
}
