import 'package:flutter/material.dart';

import '../../../Widgets/build_widgets.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
