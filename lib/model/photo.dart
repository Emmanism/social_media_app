class MarsPhoto {
  final int id;
  final String imgSrc;
  final DateTime earthDate;
  final Rover rover;
  final CameraDetail? camera;

  MarsPhoto({
    required this.id,
    required this.imgSrc,
    required this.earthDate,
    required this.rover,
     this.camera,
  });

  factory MarsPhoto.fromJson(Map<String, dynamic> json) {
    return MarsPhoto(
      id: json['id'],
      imgSrc: json['img_src'],
      earthDate: DateTime.parse(json['earth_date']),
      rover: Rover.fromJson(json['rover']),
      camera: json['camera'] != null 
              ? CameraDetail.fromJson(json['camera']) 
              : null,
    );
  }
}
class Rover {
  final int id;
  final String name;
  final String landingDate;
  final String launchDate;
  final String status;
  final int maxSol;
  final String maxDate;
  final int totalPhotos;
  final List<Camera> cameras;

  Rover({
    required this.id,
    required this.name,
    required this.landingDate,
    required this.launchDate,
    required this.status,
    required this.maxSol,
    required this.maxDate,
    required this.totalPhotos,
    required this.cameras,
  });

  factory Rover.fromJson(Map<String, dynamic> json) {
    return Rover(
      id: json['id'],
      name: json['name'],
      landingDate: json['landing_date'],
      launchDate: json['launch_date'],
      status: json['status'],
      maxSol: json['max_sol'],
      maxDate: json['max_date'],
      totalPhotos: json['total_photos'],
      cameras: (json['cameras'] as List)
          .map((cameraJson) => Camera.fromJson(cameraJson))
          .toList(),
    );
  }

 
}


class Camera {
  final String name;
  final String fullName;

  Camera({
    required this.name,
    required this.fullName,
  });

  factory Camera.fromJson(Map<String, dynamic> json) {
    return Camera(
      name: json['name'],
      fullName: json['full_name'],
    );
  }
}

class CameraDetail {
  final int id;
  final String name;
  final int roverId;
  final String fullName;

  CameraDetail({
    required this.id,
    required this.name,
    required this.roverId,
    required this.fullName,
  });

  factory CameraDetail.fromJson(Map<String, dynamic> json) {
    return CameraDetail(
      id: json['id'],
      name: json['name'],
      roverId: json['rover_id'],
      fullName: json['full_name'],
    );
  }
}