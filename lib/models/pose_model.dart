class Pose {
  final String name;
  final String image;
  final String audio;
  final int duration;

  Pose({required this.name, required this.image, required this.audio, required this.duration});

  factory Pose.fromJson(Map<String, dynamic> json) {
    return Pose(
      name: json['name'],
      image: json['image'],
      audio: json['audio'],
      duration: json['duration'],
    );
  }
}
