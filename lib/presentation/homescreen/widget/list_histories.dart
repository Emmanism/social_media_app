import 'package:edusko_media_app/model/photo.dart';
import 'package:edusko_media_app/widget/textcustom.dart';
import 'package:flutter/material.dart';

class ListHistories extends StatefulWidget {
  final MarsPhoto photo;
  const ListHistories({required this.photo});

  @override
  State<ListHistories> createState() => _ListHistoriesState();
}

class _ListHistoriesState extends State<ListHistories> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(3.0),
          decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [Colors.pink, Colors.amber])),
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.photo.imgSrc))),
          ),
        ),
        const SizedBox(height: 5.0),
        TextCustom(text: widget.photo.rover.name, fontSize: 15)
      ],
    );
  }
}
