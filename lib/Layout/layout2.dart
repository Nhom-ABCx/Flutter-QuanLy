import 'package:flutter/material.dart';

import '../Widgets/build_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Center(child: Text("Tiêu đề")),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverList(
              delegate: SliverChildListDelegate([
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: customContainerDeco(),
              child: const Text("aa"),
            ),
          ])),
        ),
      ],
    );
  }
}
