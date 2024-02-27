import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // this byte data will be used to render the image
  Int8List? _bytes;

  // get byte data from an image url
  void _getBytes(imageUrl) async {
    final ByteData data =
        await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl);
    setState(() {
      _bytes = data.buffer.asInt8List();

      // see how byte date of the image looks like
      print(_bytes);
    });
  }

  @override
  void initState() {
    // call the _getBytes() function
    _getBytes(
        'https://www.kindacode.com/wp-content/uploads/2022/07/KindaCode.jpg');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KindaCode.com')),
      body: Center(
          child: _bytes == null
              ? const CircularProgressIndicator()
              : Image.memory(
                  Uint8List.fromList(_bytes!),
                  width: 340,
                  height: 260,
                  fit: BoxFit.cover,
                )),
    );
  }
}
