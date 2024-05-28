import 'package:flutter/material.dart';

class EbookReaderAnnotationsScreen extends StatefulWidget {
  const EbookReaderAnnotationsScreen({Key? key}) : super(key: key);

  @override
  State<EbookReaderAnnotationsScreen> createState() =>
      _EbookReaderAnnotationsScreenState();
}

class _EbookReaderAnnotationsScreenState
    extends State<EbookReaderAnnotationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: const Color.fromARGB(255, 40, 39, 39),
        title: const Text(
          "Annotations",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900
          ),
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.filter_list),
          SizedBox(
            width: 25,
          ),
          Icon(Icons.share),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: const Center(
        child: Text("Center Text"),
      ),
    );
  }
}
