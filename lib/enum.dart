import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

enum PageViewModelHeight { infinty }

enum PageViewModelWidth { infinty }

extension PageViewModelHeightExtension on PageViewModelHeight {
  double value(BuildContext context) {
    switch (this) {
      case PageViewModelHeight.infinty:
        return MediaQuery.of(context).size.height;
    }
  }
}

extension PageViewMOdelWidthExtension on PageViewModelWidth {
  double value(BuildContext context) {
    switch (this) {
      case PageViewModelWidth.infinty:
        return MediaQuery.of(context).size.width;
    }
  }
}
