import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final TextEditingController txtTimKiem;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.txtTimKiem,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.white54,
      ),
      width: double.infinity,
      height: 40,
      child: Center(
        child: TextField(
          controller: widget.txtTimKiem,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: widget.txtTimKiem.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      widget.txtTimKiem.clear();
                      widget.onChanged("");
                    },
                    icon: const Icon(Icons.close))
                : null,
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
