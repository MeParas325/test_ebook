import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:test/ebook_reader/ebook_zoom_in_screen.dart';
import 'package:test/ebook_reader_widgets/paragraph_widget.dart';
import 'package:test/ebook_reader_widgets/strong_text_widget.dart';

class EbookReaderScreen extends StatefulWidget {
  const EbookReaderScreen({super.key});

  @override
  State<EbookReaderScreen> createState() => _EbookReaderScreenState();
}

class _EbookReaderScreenState extends State<EbookReaderScreen> {
  late PageController pageController;
  int _currentPage = 0;

  List<Widget> screens = [];
  double maxContainerHeight = 0.0;

  @override
  void initState() {
    super.initState();
    pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.75);
    WidgetsBinding.instance.addPostFrameCallback((_) => loadJsonData());
  }

  Future<void> loadJsonData() async {
    String jsonString = await rootBundle.loadString("assets/response.json");
    List<dynamic> jsonData = jsonDecode(jsonString);

    List<Widget> currentContainer = [];
    double currentContainerHeight = 0.0;

    for (int i = 0; i < jsonData.length; i++) {
      Widget widget;
      if (jsonData[i]["type"] == "p") {
        widget = ParagraphWidget(
          title: jsonData[i]["content"],
          fontSize: 14,
        );
      } else if (jsonData[i]['type'] == "strong") {
        widget = StrongTextWidget(text: jsonData[i]['content']);
      } else {
        continue;
      }

      double widgetHeight = await _calculateWidgetHeight(widget);

      if (currentContainerHeight + widgetHeight > maxContainerHeight) {
        // If the current container is full, add it to the screens and start a new container
        screens.add(Container(
          color: Colors.amber,
          child: SingleChildScrollView(
            child: Column(
              children: currentContainer,
            ),
          ),
        ));
        currentContainer = [widget];
        currentContainerHeight = widgetHeight;
      } else {
        currentContainer.add(widget);
        currentContainerHeight += widgetHeight;
      }
    }

    // Add the last container if it's not empty
    if (currentContainer.isNotEmpty) {
      screens.add(Container(
        color: Colors.amber,
        child: SingleChildScrollView(
          child: Column(
            children: currentContainer,
          ),
        ),
      ));
    }

    setState(() {});
  }

  Future<double> _calculateWidgetHeight(Widget widget) async {
    final key = GlobalKey();
    final completer = Completer<double>();

    final measurementWidget = Container(
      key: key,
      child: Material(
        child: widget,
      ),
    );

    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final size = overlay.size;

    final entry = OverlayEntry(
      builder: (context) => Positioned(
        top: size.height,
        child: measurementWidget,
      ),
    );

    Overlay.of(context).insert(entry);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = key.currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          completer.complete(renderBox.size.height);
        }
      }
      entry.remove();
    });

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    maxContainerHeight = MediaQuery.of(context).size.height - 150; // Adjust based on your layout

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: SizedBox(
            height: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.arrow_back_ios_new_outlined,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Icon(
                      Icons.menu_book_outlined,
                      size: 30,
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.book_outlined,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.font_download_off_outlined,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.remove_red_eye_outlined,
                      size: 35,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: screens.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return AspectRatio(
                          aspectRatio: 0.85,
                          child: PageView.builder(
                            controller: pageController,
                            itemCount: screens.length,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (pageController.page == index) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EbookZoomInScreen(
                                                  currentPageIndex:
                                                      pageController.page ?? 0,
                                                  widgets: screens),
                                        ),
                                      ).then((value) {
                                        setState(() {
                                          pageController
                                              .jumpToPage(value as int);
                                        });
                                      });
                                    } else {
                                      pageController.animateToPage(
                                        index,
                                        duration: Duration(
                                          milliseconds: 300,
                                        ),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                  child: screens[index],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.keyboard_arrow_left,
                        size: 30,
                      ),
                      Text(
                        "Random",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 30,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.view_compact_rounded,
                        size: 35,
                      ),
                      Expanded(
                        child: Slider(
                          value: 0,
                          max: 100,
                          divisions: 5,
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
}
