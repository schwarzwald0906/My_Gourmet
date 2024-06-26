import 'dart:io';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'card_back.dart';
import 'card_front.dart';

class ImageDetailCard extends StatefulWidget {
  const ImageDetailCard({
    super.key,
    required this.index,
    required this.heroIndex,
    required this.heroImageFile,
    required this.imageFile,
    required this.shopName,
    required this.dateTime,
    required this.address,
  });

  final int index;
  final int heroIndex;
  final File heroImageFile;
  final File imageFile;
  final String shopName;
  final DateTime dateTime;
  final String address;

  @override
  State<ImageDetailCard> createState() => _ImageDetailCardState();
}

class _ImageDetailCardState extends State<ImageDetailCard> {
  File get imageFile => widget.imageFile;

  String get shopName => widget.shopName;

  DateTime get dateTime => widget.dateTime;

  String get formattedDate =>
      '${dateTime.year}/${dateTime.month}/${dateTime.day}';

  String get address => widget.address;

  @override
  Widget build(BuildContext context) {
    final heroImageFile =
        (widget.index == widget.heroIndex) ? widget.heroImageFile : null;

    return FlipCard(
      fill: Fill.fillBack,
      front: CardFront(
        heroImageFile: heroImageFile,
        imageFile: imageFile,
        shopName: shopName,
        dateTime: dateTime,
        address: address,
      ),
      back: CardBack(
        isLinked: true,
        shopName: shopName,
        imageFileList: [imageFile, imageFile, imageFile, imageFile],
        holiday: '土曜',
        address: address,
        url: 'https://example.com',
      ),
    );
  }
}
