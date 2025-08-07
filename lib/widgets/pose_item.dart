import 'package:flutter/material.dart';

import '../models/pose_model.dart';
import '../screens/audio_screen.dart';

class PoseItem extends StatefulWidget {
  final List<Pose> pose;
  final int index;




  const PoseItem({super.key, required this.pose, required this.index});

  @override
  State<PoseItem> createState() => _PoseItemState();
}

class _PoseItemState extends State<PoseItem> {

  late int currentPostion ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPostion = widget.index;
  }

  @override
  Widget build(BuildContext context) {

  final currentPose = widget.pose[currentPostion];

    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AudioScreen(
                initialIndex: widget.index, poseList: widget.pose,
              ),
            ),
          );

        },
        child: Card(
          elevation: 10,
          shadowColor: Colors.grey.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  // Adjust the radius as needed
                  child: Image.asset(
                    currentPose.image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 10,),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentPose.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      currentPose.duration.toString()+" sec",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}
