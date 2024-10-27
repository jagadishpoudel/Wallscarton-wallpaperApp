import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallpaper_app/widget/gradient_appbar.dart';

class WallpaperDetailScreen extends StatefulWidget {
  final String imageUrl;

  WallpaperDetailScreen({required this.imageUrl});

  @override
  _WallpaperDetailScreenState createState() => _WallpaperDetailScreenState();
}

class _WallpaperDetailScreenState extends State<WallpaperDetailScreen> {
  bool isDownloading = false;
  double downloadProgress = 0.0;

  Future<void> _downloadImage() async {
    if (await Permission.storage.request().isGranted) {
      setState(() {
        isDownloading = true;
        downloadProgress = 0.0;
      });

      final response = await http.get(Uri.parse(widget.imageUrl));
      final documentDirectory = await getExternalStorageDirectory();
      final file = File('${documentDirectory!.path}/downloaded_wallpaper.jpg');

      for (int i = 0; i <= 100; i++) {
        await Future.delayed(const Duration(milliseconds: 20));
        setState(() {
          downloadProgress = i / 100;
        });
      }

      await file.writeAsBytes(response.bodyBytes);
      setState(() => isDownloading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Downloaded to ${file.path}")),
      );
    }
  }

  void _shareImage() {
    Share.share(widget.imageUrl, subject: 'Check out this wallpaper!');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(widget.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GradientAppBar(
          title: "Wallpaper Details",
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: isDownloading
                    ? Column(
                        children: [
                          const Text(
                            "Downloading...",
                            style: TextStyle(color: Colors.white),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 50.0),
                            child: LinearProgressIndicator(
                              value: downloadProgress,
                              backgroundColor: Colors.grey,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ],
                      )
                    : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _downloadImage,
                                icon: const Icon(CupertinoIcons.download_circle, size: 20,),
                                label: const Text("Download"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: 20, vertical: 12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12.0,),
                            ElevatedButton(
                              onPressed: _shareImage,
                              child: const Icon(CupertinoIcons.share, size: 18,),
                              // label: Text(""),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                // padding: EdgeInsets.symmetric(
                                //     horizontal: 20, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
