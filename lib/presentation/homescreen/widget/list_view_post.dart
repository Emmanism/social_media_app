import 'package:edusko_media_app/model/photo.dart';
import 'package:edusko_media_app/presentation/home_details_screen/home_details_screen.dart';
import 'package:edusko_media_app/presentation/homescreen/controller/home_controller.dart';
import 'package:edusko_media_app/widget/helpers.dart';
import 'package:edusko_media_app/widget/like_animation.dart';
import 'package:edusko_media_app/widget/textcustom.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';

class ListViewPost extends StatefulWidget {
  const ListViewPost({required this.photo});

  final MarsPhoto photo;

  @override
  State<ListViewPost> createState() => _ListViewPostState();
}

class _ListViewPostState extends State<ListViewPost> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final List<String> listImages = widget.photo.imgSrc.split(',');
    final time = timeago.format(widget.photo.earthDate);

    return InkWell(
      onTap: () {
        onTapDetail(widget.photo);
      },
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: CarouselSlider.builder(
            itemCount: listImages.length,
            options: CarouselOptions(
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              height: 350,
              scrollPhysics: const BouncingScrollPhysics(),
              autoPlay: false,
            ),
            itemBuilder: (context, i, realIndex) => Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(listImages[i]))),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(Helpers.randomPictureUrl()),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustom(
                                  text: widget.photo.rover.name,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              TextCustom(
                                  text:
                                      '${widget.photo.camera?.fullName} (${widget.photo.camera?.name})',
                                  fontSize: 15,
                                  color: Colors.white),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 2,
                right: 10,
                child: Text(
                  time,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
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
            ]))
      ]),
    );
  }

  onTapDetail(MarsPhoto selectedImage) {
    controller.setSelectedPost(selectedImage);
    Get.to(() => HomeDetails(selectedImage: selectedImage));
  }
}
