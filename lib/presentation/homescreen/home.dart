import 'package:edusko_media_app/model/photo.dart';
import 'package:edusko_media_app/presentation/homescreen/controller/home_controller.dart';
import 'package:edusko_media_app/presentation/homescreen/widget/list_histories.dart';
import 'package:edusko_media_app/presentation/homescreen/widget/list_view_post.dart';
import 'package:edusko_media_app/widget/appbar_search_view.dart';
import 'package:edusko_media_app/widget/colorconstant.dart';
import 'package:edusko_media_app/widget/custom_image_view.dart';
import 'package:edusko_media_app/widget/customloading.dart';
import 'package:edusko_media_app/widget/error.dart';
import 'package:edusko_media_app/widget/input_field.dart';
import 'package:edusko_media_app/widget/sizeutill.dart';
import 'package:edusko_media_app/widget/textcustom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final ScrollController _scrollController = ScrollController();

  HomeController controller = Get.put(HomeController());
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(
          text: 'Hi Gabby',
          fontWeight: FontWeight.w600,
          fontSize: 22,
          color: ColorConstant.secundary,
          isTitle: true,
        ),
        elevation: 0,
        leadingWidth: 60,
        actions: [
          IconButton(
              splashRadius: 20,
              onPressed: () {},
              icon: Image.asset('assets/images/camera.jpg', height: 26)),
          IconButton(
              splashRadius: 20,
              onPressed: () {},
              icon: Image.asset('assets/images/send.png', height: 26)),
        ],
      ),
      body: SafeArea(child: Obx(() {
        if (controller.isLoading.value) {
          return Container(
              height: 200,
              child: Center(
                  child: CustomLoadingWidget(
                animationController: animationController,
              )));
        } else if (controller.error.value.isNotEmpty) {
          return ResponsiveErrorWidget(
            errorMessage: controller.error.value,
            onRetry: () {
              controller.fetchPhotos();
            },
            fullPage: true,
          );
        } else {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                                    child:  InputField(
                                  type: InputType.username,
                                  placeholder: "Search your image",
                                  prefix: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 12.0),
                                    child: ClipOval(
                                      child: CustomImageView(
                                        svgPath: 'assets/images/img_search.svg',
                                        width: 12.0,
                                        height: 12.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  controller: searchController,
                                  onChanged: (String query) {
                                     controller.filterMarsPhotos(query: query); 
                                  },
                                ),
                                  ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    height: 130,
                    width: size.width,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.isTrendLoading.value
                          ? 5
                          : controller.marsPhotos.length,
                      itemBuilder: (context, index) {
                        final photo = controller.marsPhotos[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: ListHistories(photo: photo),
                        );
                      },
                    ),
                  ),

                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                     child: Container(
                      margin: const EdgeInsets.only(bottom: 5.0),
                      height: 900,
                       width: size.width,
                       decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white
                   ),
                   child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.isTrendLoading.value
                          ? 5
                          : controller.marsPhotos.length,
                      itemBuilder: (context, index) {
                        final photo = controller.marsPhotos[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                               vertical: 10),
                          child: ListViewPost(photo:photo),
                        );
                      },
                    )))

            ])));
        }
      })),
    );
  }
}
