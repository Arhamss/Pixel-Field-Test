import 'package:equatable/equatable.dart';
import 'package:pixelfield_test/features/product/domain/models/product_model.dart';

/// Filter criteria for querying products offline
class ProductFilter extends Equatable {
  const ProductFilter({
    this.searchQuery,
    this.distillery,
    this.region,
    this.country,
    this.type,
    this.status,
    this.collectionName,
    this.minAge,
    this.maxAge,
    this.sortBy = ProductSortBy.name,
    this.sortAscending = true,
  });

  final String? searchQuery;
  final String? distillery;
  final String? region;
  final String? country;
  final String? type;
  final BottleStatus? status;
  final String? collectionName;
  final int? minAge;
  final int? maxAge;
  final ProductSortBy sortBy;
  final bool sortAscending;

  bool get hasFilters =>
      searchQuery != null ||
      distillery != null ||
      region != null ||
      country != null ||
      type != null ||
      status != null ||
      collectionName != null ||
      minAge != null ||
      maxAge != null;

  ProductFilter copyWith({
    String? searchQuery,
    String? distillery,
    String? region,
    String? country,
    String? type,
    BottleStatus? status,
    String? collectionName,
    int? minAge,
    int? maxAge,
    ProductSortBy? sortBy,
    bool? sortAscending,
  }) {
    return ProductFilter(
      searchQuery: searchQuery ?? this.searchQuery,
      distillery: distillery ?? this.distillery,
      region: region ?? this.region,
      country: country ?? this.country,
      type: type ?? this.type,
      status: status ?? this.status,
      collectionName: collectionName ?? this.collectionName,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      sortBy: sortBy ?? this.sortBy,
      sortAscending: sortAscending ?? this.sortAscending,
    );
  }

  /// Clear a specific filter field
  ProductFilter clearField(ProductFilterField field) {
    switch (field) {
      case ProductFilterField.searchQuery:
        return ProductFilter(
          distillery: distillery,
          region: region,
          country: country,
          type: type,
          status: status,
          collectionName: collectionName,
          minAge: minAge,
          maxAge: maxAge,
          sortBy: sortBy,
          sortAscending: sortAscending,
        );
      case ProductFilterField.distillery:
        return ProductFilter(
          searchQuery: searchQuery,
          region: region,
          country: country,
          type: type,
          status: status,
          collectionName: collectionName,
          minAge: minAge,
          maxAge: maxAge,
          sortBy: sortBy,
          sortAscending: sortAscending,
        );
      case ProductFilterField.region:
        return ProductFilter(
          searchQuery: searchQuery,
          distillery: distillery,
          country: country,
          type: type,
          status: status,
          collectionName: collectionName,
          minAge: minAge,
          maxAge: maxAge,
          sortBy: sortBy,
          sortAscending: sortAscending,
        );
      case ProductFilterField.country:
        return ProductFilter(
          searchQuery: searchQuery,
          distillery: distillery,
          region: region,
          type: type,
          status: status,
          collectionName: collectionName,
          minAge: minAge,
          maxAge: maxAge,
          sortBy: sortBy,
          sortAscending: sortAscending,
        );
      case ProductFilterField.type:
        return ProductFilter(
          searchQuery: searchQuery,
          distillery: distillery,
          region: region,
          country: country,
          status: status,
          collectionName: collectionName,
          minAge: minAge,
          maxAge: maxAge,
          sortBy: sortBy,
          sortAscending: sortAscending,
        );
      case ProductFilterField.status:
        return ProductFilter(
          searchQuery: searchQuery,
          distillery: distillery,
          region: region,
          country: country,
          type: type,
          collectionName: collectionName,
          minAge: minAge,
          maxAge: maxAge,
          sortBy: sortBy,
          sortAscending: sortAscending,
        );
      case ProductFilterField.collectionName:
        return ProductFilter(
          searchQuery: searchQuery,
          distillery: distillery,
          region: region,
          country: country,
          type: type,
          status: status,
          minAge: minAge,
          maxAge: maxAge,
          sortBy: sortBy,
          sortAscending: sortAscending,
        );
      case ProductFilterField.ageRange:
        return ProductFilter(
          searchQuery: searchQuery,
          distillery: distillery,
          region: region,
          country: country,
          type: type,
          status: status,
          collectionName: collectionName,
          sortBy: sortBy,
          sortAscending: sortAscending,
        );
    }
  }

  /// Clear all filters
  ProductFilter clearAll() {
    return ProductFilter(
      sortBy: sortBy,
      sortAscending: sortAscending,
    );
  }

  @override
  List<Object?> get props => [
        searchQuery,
        distillery,
        region,
        country,
        type,
        status,
        collectionName,
        minAge,
        maxAge,
        sortBy,
        sortAscending,
      ];
}

enum ProductSortBy {
  name,
  age,
  distillery,
  region,
  status,
}

enum ProductFilterField {
  searchQuery,
  distillery,
  region,
  country,
  type,
  status,
  collectionName,
  ageRange,
}
