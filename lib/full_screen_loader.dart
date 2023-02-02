import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({
    super.key,
    required this.barrierColor,
    this.blurSigma = 1,
  });

  final Color barrierColor;
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurSigma,
            sigmaY: blurSigma,
          ),
          child: ModalBarrier(
            color: barrierColor,
            dismissible: false,
          ),
        ),
        SafeArea(
          child: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Platform.isIOS ? 8 : 12),
              ),
              child: Padding(
                padding: EdgeInsets.all(Platform.isIOS ? 8 : 16),
                child: const SizedBox.square(
                  dimension: 24,
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
