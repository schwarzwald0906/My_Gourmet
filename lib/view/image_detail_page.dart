import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/themes.dart';
import '../features/photo/photo.dart';
import '../features/store/store.dart';
import '../features/store/store_controller.dart';
import 'image_detail/image_detail_card.dart';

class ImageDetailPage extends ConsumerStatefulWidget {
  const ImageDetailPage({
    super.key,
    // TODO(anyone): 不要なタイミングで削除
    required this.index,
    required this.photo,
  });

  static const String routeName = '/image_detail';
  static const String routePath = '/image_detail';

  final int index;
  final Photo photo;

  @override
  ConsumerState<ImageDetailPage> createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends ConsumerState<ImageDetailPage> {
  late final PageController _pageController;
  late Future<Store?> _storeFuture;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: widget.index, viewportFraction: 0.9);
    _storeFuture = _fetchStore();
  }

  Future<Store?> _fetchStore() async {
    final storeController = ref.read(storeControllerProvider);
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final storeId = widget.photo.storeId;

    if (storeId.isEmpty) {
      throw Exception('Store ID is null or empty');
    }

    return storeController.getStoreById(
      userId: userId,
      storeId: storeId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Themes.mainOrange[50],
              ),
            ),
            FutureBuilder<Store?>(
              future: _storeFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(
                    child: Text('No store information available'),
                  );
                } else {
                  final store = snapshot.data!;
                  return PageView.builder(
                    controller: _pageController,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          left: 4,
                          right: 4,
                        ),
                        child: ImageDetailCard(
                            photoUrl: widget.photo.url,
                            storeName: store.name,
                            dateTime: DateTime.now(),
                            address: store.address,
                            storeUrl: store.website,
                            storeImageUrls: store.imageUrls,),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
