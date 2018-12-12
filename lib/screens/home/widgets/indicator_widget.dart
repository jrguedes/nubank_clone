import 'dart:math';

import 'package:flutter/material.dart';

class IndicatorWidget extends AnimatedWidget {
  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color indicatorColor;
  final MaterialType indicatorType;
  final double indicatorSize;
  final double indicatorIncreaseSize;
  final double indicatorSpacing;
  final double indicatorOpacityNotSelected;

  IndicatorWidget(
      {this.controller,
      this.itemCount,
      this.onPageSelected,
      this.indicatorColor,
      this.indicatorType,
      this.indicatorSize,
      this.indicatorIncreaseSize,
      this.indicatorSpacing,
      this.indicatorOpacityNotSelected})
      : super(listenable: controller);

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildIndicator),
    );
  }

  Widget _buildIndicator(int index) {
    double selected = Curves.easeOut.transform(
      max(
        0.0,
        1.0 -
            ((controller.page?.round() ?? controller.initialPage) - index)
                .abs(),
      ),
    );

    double zoom = 1.0 + (indicatorIncreaseSize - 1.0) * selected;
    double opacity =
        1.0 + (indicatorOpacityNotSelected - 1.0) * selected > 0.8 ? 0.5 : 1.0;

    return Container(
      width: indicatorSpacing,
      child: Center(
        child: Material(
          color: indicatorColor.withOpacity(opacity),
          type: indicatorType,
          child: Container(
            width: indicatorSize * zoom,
            height: indicatorSize * zoom,
            child: InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }
}

enum IndicatorType { square, circle, linerProgress }
