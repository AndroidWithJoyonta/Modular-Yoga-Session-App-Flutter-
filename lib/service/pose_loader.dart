import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pose/models/pose_model.dart';

class PoseLoader{

  static Future<List<Pose>> loadPoses() async {
    final String jsonString = await rootBundle.loadString('assets/poses.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList.map((json) => Pose.fromJson(json)).toList();
  }

}