import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logger.dart';
import 'store.dart';

/// [Store]用コレクションのためのレファレンス
///
/// [Store]ドキュメントの操作にはこのレファレンスを経由すること。
/// fromFirestoreではドキュメントidを追加し、toFirestoreではドキュメントidを削除する。
/// 常にtoFirestoreを経由するために、ドキュメント更新時には
/// [DocumentReference.update]ではなく[DocumentReference.set]を用いる。
CollectionReference<Store> storesRef({required String userId}) {
  return FirebaseFirestore.instance.collection('stores').withConverter<Store>(
    fromFirestore: (snapshot, _) {
      final data = snapshot.data()!;
      return Store.fromJson(<String, dynamic>{
        ...data,
        'id': snapshot.id,
      });
    },
    toFirestore: (store, _) {
      final json = store.toJson()..remove('id');
      return json;
    },
  );
}

final storeRepositoryProvider = Provider((ref) => StoreRepository._());

class StoreRepository {
  StoreRepository._();

  Future<Store?> getStoreById({
    required String userId,
    required String storeId,
  }) async {
    try {
      final docSnapshot = await storesRef(userId: userId).doc(storeId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data();
      } else {
        return null;
      }
    } on Exception catch (e) {
      logger.e('Error fetching store: $e');
      return null;
    }
  }
}
