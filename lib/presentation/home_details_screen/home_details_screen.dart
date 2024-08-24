import 'package:edusko_media_app/model/photo.dart';
import 'package:edusko_media_app/presentation/homescreen/controller/home_controller.dart';
import 'package:edusko_media_app/widget/colorconstant.dart';
import 'package:edusko_media_app/widget/helpers.dart';
import 'package:edusko_media_app/widget/like_animation.dart';
import 'package:edusko_media_app/widget/sizeutill.dart';
import 'package:edusko_media_app/widget/textcustom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/widgets.dart';

class HomeDetails extends StatefulWidget {
  final MarsPhoto selectedImage;
  const HomeDetails({required this.selectedImage});

  @override
  State<HomeDetails> createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  var isPressed = true;
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: GestureDetector(
            onTap: () {
              controller.handleLike();
            },
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                mainImageWidget(height),
                Obx(
                  () => AnimatedOpacity(
                    duration: Duration(milliseconds: 200),
                    opacity: controller.isAnimating.value ? 1 : 0,
                    child: LikeAnimation(
                      child: Icon(
                        Icons.favorite,
                        size: 100,
                        color: Colors.red,
                      ),
                      isAnimating: controller.isAnimating.value,
                      duration: Duration(milliseconds: 400),
                      iconlike: false,
                      End: controller.resetAnimation,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: height / 2.3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                    ),
                    child:
                        Expanded(child: bottomContent(widget.selectedImage))),
              ],
            ),
          ),
        ));
  }

  //mainImage
  Widget mainImageWidget(height) => Container(
        height: height / 2,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.selectedImage.imgSrc),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 48, left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            IconButton(
                 icon: Obx(() => Icon(
                   controller.isImageSaved(widget.selectedImage.imgSrc)
                     ? Icons.bookmark
                    : Icons.bookmark_border,
                  color: controller.isImageSaved(widget.selectedImage.imgSrc)
                      ? Colors.blue
                      : Colors.white,
                       size: 28,
                    )),
                   onPressed: () {
                       controller.toggleSaveImage(widget.selectedImage.imgSrc);
                       Get.snackbar(
                       'Success',
                       "Image has been saved",
                         snackPosition: SnackPosition.TOP,
                         backgroundColor: ColorConstant.gray300B2,
                         colorText: ColorConstant.black900,
                            );
                                            },
                    ),
            ],
          ),
        ),
      );

  Widget bottomContent(MarsPhoto selectedImage) => SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextCustom(
                  text: widget.selectedImage.rover.name,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: ColorConstant.black900,
                  isTitle: true,
                ),
                Text(
                  selectedImage.rover.status,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  selectedImage.rover.cameras.first.fullName,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: Colors.grey,
                      size: 16,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      timeago.format(widget.selectedImage.earthDate),
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                        splashRadius: 11,
                        onPressed: () {},
                        icon: Image.asset('assets/images/camera.jpg',
                            height: 17)),
                    Text(
                      "${widget.selectedImage.rover.totalPhotos}",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    IconButton(
                        splashRadius: 11,
                        onPressed: () {
                           controller.handleLike();
                        },
                         icon: Obx(
                           () => Icon(
                           controller.isLiked.value 
                            ? Icons.favorite
                            : Icons.favorite_border,
                       color: controller.isLiked.value
                            ? Colors.red
                              : Colors.black,
                             size: 16,
                             ),
                         ),),
                    Text(
                      "Likes",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 100,
                  child: Column(children: [
                    TextCustom(
                      text: "Lists of Rover cameras",
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: ColorConstant.black900,
                      isTitle: true,
                    ),
                    SizedBox(height: 5),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: widget.selectedImage.rover.cameras.length,
                        itemBuilder: (context, index) {
                          final cameras =
                              widget.selectedImage.rover.cameras[index];
                          return Container(
                            height: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  Helpers.randomPictureUrl()))),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      cameras.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 10,
                                ),

                                //Paragraph
                                Text(
                                  cameras.fullName,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13.5,
                                  ),
                                  textAlign: TextAlign.left,
                                  maxLines: 8,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ]),
                )
              ],
            ),
          ),
        ),
      );
}
