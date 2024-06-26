import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/themes.dart';
import '../widgets/scalable_image.dart';

class CardBack extends StatelessWidget {
  const CardBack({
    required this.isLinked,
    this.shopName,
    this.imageFileList,
    this.openTime,
    this.holiday,
    this.address,
    this.url,
    super.key,
  });

  final bool isLinked;
  final String? shopName;
  final List<File>? imageFileList;
  final String? openTime;
  final String? holiday;
  final String? address;
  final String? url;

  @override
  Widget build(BuildContext context) {
    if (!isLinked) {
      return Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.only(
            top: 48,
            bottom: 40,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }

    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 48,
              bottom: 40,
              left: 16,
              right: 16,
            ),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  shopName ?? '',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(),
                ),
                (imageFileList != null && imageFileList!.isNotEmpty)
                    ? SizedBox(
                        height: 220,
                        child: Scrollbar(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imageFileList!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: ScalableImage(
                                    imageFile: imageFileList![index],
                                    height: 200,
                                    width: 200,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Container(
                        height: 200,
                        width: 300,
                        color: Themes.gray[200],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.image_outlined),
                            const Gap(4),
                            Text(
                              '画像がありません',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (openTime != null)
                      Text(
                        openTime!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    if (holiday != null)
                      Text(
                        '$holiday定休',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(),
                ),
                if (address != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.pin_drop_outlined, size: 18),
                      ),
                      Expanded(
                        child: Text(
                          address!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                if (url != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.link_outlined, size: 18),
                      ),
                      Expanded(
                        child: Text(
                          url!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Themes.gray[200],
                          border: Border.all(),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            '店舗を選び直す',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
