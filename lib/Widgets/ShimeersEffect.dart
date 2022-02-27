import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

Widget ShimmersEffectWidget() {
  return Column(children: [
    for (int i = 0; i < 10; i++)
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Container(
            child: Shimmer.fromColors(
                child: Container(
                    width: Get.width / 1, height: 40, color: Colors.blue),
                baseColor: Colors.black12,
                highlightColor: Colors.white)),
      )
  ]);
}
