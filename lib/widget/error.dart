import 'package:edusko_media_app/widget/colorconstant.dart';
import 'package:edusko_media_app/widget/custom_button.dart';
import 'package:edusko_media_app/widget/sizeutill.dart';
import 'package:edusko_media_app/widget/textcustom.dart';
import 'package:flutter/material.dart';

class ResponsiveErrorWidget extends StatelessWidget {
  final String errorMessage;
   String? smallMessage;
  final String? buttonText;
  final VoidCallback onRetry;
  final bool fullPage;

  ResponsiveErrorWidget({
    required this.errorMessage,
     this.smallMessage,
    required this.onRetry,
    this.fullPage = false,
    this.buttonText = 'Try Again',
  });

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: ColorConstant.gray100,
        ),
        width: 330,
        height: 230, 
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 300,
                    child: TextCustom(text: errorMessage, fontSize: 15)
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    smallMessage ?? '',
                    textAlign: TextAlign.center,
                    style:TextStyle(
                     fontSize: getFontSize(
                         13,
                       ),
                     fontFamily: 'Satoshi',
                     fontWeight: FontWeight.w300,
                     color: ColorConstant.gray600
              ),
                  ),
                ),
                SizedBox(height: 20), // Responsive height
                CustomButtonTwo(
                  height: getVerticalSize(45),
                  width: getHorizontalSize(120),
                  text: buttonText,
                  onTap: onRetry,
                  padding: ButtonPaddingz.PaddingAll4,
                  fontStyle: ButtonFontStylez.SatoshiBold15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}