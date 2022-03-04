import 'package:flutter/material.dart';

class TongQuanPage extends StatefulWidget {
  const TongQuanPage({Key? key}) : super(key: key);
  @override
  State<TongQuanPage> createState() => _TongQuanPageState();
}

class _TongQuanPageState extends State<TongQuanPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Center(child: Text("Tổng quan")),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            color: Colors.white,
            width: 100,
            height: 100,
            child: const Text("aaaaaaa"),
          ),
        ]))
      ],
    );
  }
}
