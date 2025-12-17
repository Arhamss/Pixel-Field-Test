import 'package:pixelfield_test/core/offline/collection_filter.dart';
import 'package:pixelfield_test/features/home/domain/models/collection_model.dart';
import 'package:pixelfield_test/utils/helpers/repository_response.dart';

abstract class CollectionRepository {
  Future<RepositoryResponse<List<CollectionModel>>> getCollections({
    CollectionFilter? filter,
  });

  Future<RepositoryResponse<CollectionModel>> getCollectionById(String id);

  /// Query collection products with optional search
  Future<RepositoryResponse<List<CollectionProductModel>>>
      getCollectionProducts({
    required String collectionId,
    String? searchQuery,
  });
}
