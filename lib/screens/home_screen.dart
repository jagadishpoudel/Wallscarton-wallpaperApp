import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'wallpaper_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<String> wallpaperUrls = [
    'https://cdn.pixabay.com/photo/2023/06/10/05/40/bulldog-8053202_1280.jpg',
    'https://cdn.pixabay.com/photo/2023/11/04/12/48/cat-8364830_1280.jpg',
    'https://cdn.pixabay.com/photo/2023/10/19/21/08/ai-generated-8327632_1280.jpg',
    'https://cdn.pixabay.com/photo/2022/09/24/15/34/french-bulldog-7476605_960_720.png',
    'https://cdn.pixabay.com/photo/2021/10/27/13/15/digital-graphicscat-6747298_1280.jpg',
    'https://cdn.pixabay.com/photo/2015/05/02/09/32/fire-749684_1280.jpg',
    'https://cdn.pixabay.com/photo/2020/06/06/12/34/cartoon-5266407_960_720.png',
    'https://cdn.pixabay.com/photo/2021/01/01/16/06/hand-5879027_1280.jpg',
    'https://cdn.pixabay.com/photo/2024/07/04/08/48/swing-8872109_1280.jpg',
    'https://cdn.pixabay.com/photo/2019/12/26/09/49/nature-4720090_960_720.jpg',
    'https://cdn.pixabay.com/photo/2022/06/17/13/36/man-7267949_960_720.jpg',
    'https://cdn.pixabay.com/photo/2023/05/30/22/01/mouse-8030076_960_720.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EDE5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text("Wallscarton"),
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border_purple500_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: wallpaperUrls.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        WallpaperDetailScreen(
                      imageUrl: wallpaperUrls[index],
                    ),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: wallpaperUrls[index],
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}