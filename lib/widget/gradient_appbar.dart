import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  GradientAppBar({required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black54,
            Colors.black45,
            Colors.black38,
            Colors.black26,
            Colors.black12,
            Colors.black26.withOpacity(0.0),
          ],
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        // foregroundColor: Colors.white,
        elevation: 0,
        leading: Padding(padding: const EdgeInsets.all(8), child: InkWell(onTap: () {
          Navigator.pop(context);
        }, child: CircleAvatar(child: const Icon(Icons.arrow_back_ios_new_rounded), backgroundColor: Colors.white.withOpacity(0.4), foregroundColor: Colors.white,)),),
        centerTitle: true,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
