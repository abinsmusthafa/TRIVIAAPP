import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
          children: Iterable<int>.generate(6).toList().map((item) {
            return YoutubeShimmer(
             isRectBox: true,
             hasBottomBox: false,
            );
          }).toList()),
    );
  }
}
