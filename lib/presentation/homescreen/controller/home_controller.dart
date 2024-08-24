import 'package:edusko_media_app/apiclient/apiclient.dart';
import 'package:edusko_media_app/model/photo.dart';
import 'package:edusko_media_app/presentation/homescreen/model/home_model.dart';
import 'package:edusko_media_app/widget/colorconstant.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<bool> isLoading = false.obs;
  Rx<bool> isTrendLoading = false.obs;
  Rx<bool> isRecommendedLoading = false.obs;
  var marsPhotos = <MarsPhoto>[].obs;
  RxList<MarsPhoto> filteredPhotos = <MarsPhoto>[].obs;
   Rx<MarsPhoto?> postModelObj = Rx<MarsPhoto?>(null);
  var token;
  var error = ''.obs;
  final apiClient = ApiClient();
   var isAnimating = false.obs;
    var savedImages = <String>{}.obs;
  var isLiked = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPhotos();
  }

  void fetchPhotos() async {
    try {
      error('');
      isLoading.value = true;

      final response = await apiClient.fetchMarsPhotos();

      if (response.statusCode == 200) {
        List<dynamic> photosJson = response.body['photos'];

        if (photosJson.isEmpty) {
          error('No photos available ');
          marsPhotos.clear();
        } else {
          marsPhotos.value =
              photosJson.map((json) => MarsPhoto.fromJson(json)).toList();
        }
      } else {
        error('Failed to fetch photos. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      error("An error occured, check your connection: $e");
      print("Error fetching photos: $e");
    } finally {
      isLoading(false);
    }
  }

 
 void filterMarsPhotos({String? query}) {
    try {
      if (query != null && query.isNotEmpty) {
        filteredPhotos.value = marsPhotos.where((photo) {
          final roverName = photo.rover.name.toLowerCase();
          final cameraFullName = photo.camera?.fullName.toLowerCase() ?? '';
          return roverName.contains(query.toLowerCase()) || cameraFullName.contains(query.toLowerCase());
        }).toList();
      } else if (filteredPhotos.isEmpty) {
        Get.snackbar(
        'No Posts Found',
        'There are no posts matching your search query.',
        snackPosition: SnackPosition.TOP,
        duration:const  Duration(seconds: 10),
        backgroundColor: ColorConstant.gray300B2,
        colorText: ColorConstant.black900,
      );
    } else {
        filteredPhotos.value = List.from(marsPhotos); // Reset to all photos
      }
      error('');
      isLoading.value = false;
    } catch (e) {
      error('Something went wrong');
      print(e);
      isLoading.value = false;
    }
  }

   void setSelectedPost(MarsPhoto selectedImage) {
    postModelObj.value = selectedImage;
  }
  
  void handleLike() {
    if (isAnimating.value) return;
    isAnimating.value = true;
    isLiked.toggle();
  }

  void resetAnimation() {
    isAnimating.value = false;
  }

  void toggleSaveImage(String imageUrl) {
    if (savedImages.contains(imageUrl)) {
      savedImages.remove(imageUrl);
    } else {
      savedImages.add(imageUrl);
    }
  }

  bool isImageSaved(String imageUrl) {
    return savedImages.contains(imageUrl);
  }
}
