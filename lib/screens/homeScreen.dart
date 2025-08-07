import 'package:flutter/material.dart';
import 'package:pose/models/pose_model.dart';
import 'package:pose/service/pose_loader.dart';
import 'package:pose/widgets/pose_item.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Pose> pose = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    final data = await PoseLoader.loadPoses();

    setState(() {
      pose = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Yoga Session App',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.yellow[100],
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: pose.length,
          itemBuilder: (context, index) {
            return PoseItem(pose: pose, index: index);
          },
        ),
      ),
    );
  }
}
