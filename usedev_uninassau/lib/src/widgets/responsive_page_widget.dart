import 'package:flutter/material.dart';
import 'package:usedev_uninassau/src/theme/responsive.dart';

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final contentWidth = constraints.maxWidth.clamp(
          0.0,
          Responsive.maxContentWidth,
        );

        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: contentWidth,
            child: child,
          ),
        );
      },
    );
  }
}

class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    required this.itemCount,
    required this.itemBuilder,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.spacing = 16,
    super.key,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = Responsive.gridColumns(
          context,
          mobile: mobileColumns,
          tablet: tabletColumns,
          desktop: desktopColumns,
        );
        final itemWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(
            itemCount,
            (index) => SizedBox(
              width: itemWidth,
              child: itemBuilder(context, index),
            ),
          ),
        );
      },
    );
  }
}
