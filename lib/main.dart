// ignore_for_file: non_constant_identifier_names, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var yt = YoutubeExplode();
  GlobalKey key = GlobalKey();

  int _counter = 0;

  void screnshot() async {
    Future(() async {
      RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 1.304);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      await File("./youtube.png").writeAsBytes(pngBytes);
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    YoutubeData youtubeData = YoutubeData(
      id_channel: "UC928-F8HenjZD1zNdMY42vA",
      caption: "Hello World From Azkadev",
      powered: "Powered By Azkadev",
    );
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: RepaintBoundary(
                key: key,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    width: 1280,
                    height: 720,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 187, 186, 186),
                    ),
                    child: FutureBuilder(
                      future: yt.channels.get(youtubeData.id_channel),
                      builder: (context, snapshot) {
                        late String title_channel = "";
                        late Widget profile_image = const SizedBox(
                          height: 150,
                          width: 150,
                          child: CircularProgressIndicator(),
                        );
                        if (snapshot.data != null) {
                          title_channel = snapshot.data!.title;
                          profile_image = ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              snapshot.data!.logoUrl,
                              fit: BoxFit.fill,
                              height: 150,
                              width: 150,
                            ),
                          );
                        }
                        // print(snapshot.data!.logoUrl);
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 15,
                                    ),
                                    child: profile_image,
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Stack(
                                      children: [
                                        // Stroked text as border.
                                        Text(
                                          youtubeData.caption,
                                          style: TextStyle(
                                            fontSize: 60,
                                            fontFamily: "Keep Me",
                                            foreground: Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 2.5
                                              ..color = Colors.black,
                                          ),
                                        ),
                                        // Solid text as fill.
                                        Text(
                                          youtubeData.caption,
                                          style: const TextStyle(
                                            fontSize: 60,
                                            fontFamily: "Keep Me",
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(
                                          5,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                                      child: Text(
                                        title_channel,
                                        style: const TextStyle(
                                          fontSize: 40,
                                          fontFamily: "Exxaros",
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Stack(
                                      children: [
                                        Text(
                                          youtubeData.powered,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Keep Me",
                                            foreground: Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 5
                                              ..color = Colors.black,
                                          ),
                                        ),
                                        // Solid text as fill.
                                        Text(
                                          youtubeData.powered,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Keep Me",
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: screnshot,
        tooltip: 'Increment',
        child: const Icon(
          Icons.screenshot,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class YoutubeData {
  late String id_channel;
  late String caption;
  late String powered;
  YoutubeData({
    required this.id_channel,
    required this.caption,
    required this.powered,
  });
}
