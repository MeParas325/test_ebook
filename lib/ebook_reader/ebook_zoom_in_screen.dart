import 'package:flutter/material.dart';

class EbookZoomInScreen extends StatefulWidget {
  final double currentPageIndex;
  final List<Widget> widgets;
  const EbookZoomInScreen({
    super.key,
    required this.currentPageIndex,
    required this.widgets,
  });

  @override
  State<EbookZoomInScreen> createState() => _EbookZoomInScreenState();
}

class _EbookZoomInScreenState extends State<EbookZoomInScreen> {
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(
        initialPage: widget.currentPageIndex.toInt(), viewportFraction: 1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AspectRatio(
        aspectRatio: 0.85,
        child: PageView.builder(
            controller: pageController,
            itemCount: widget.widgets.length,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context, index);
                  },
                  child: widget.widgets[index],
                ),
              );
            }),
      ),
    );
  }
}
