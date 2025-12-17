import 'package:equatable/equatable.dart';

/// Filter criteria for querying collections offline
class CollectionFilter extends Equatable {
  const CollectionFilter({
    this.searchQuery,
    this.collectionId,
    this.sortBy = CollectionSortBy.name,
    this.sortAscending = true,
  });

  final String? searchQuery;
  final String? collectionId;
  final CollectionSortBy sortBy;
  final bool sortAscending;

  bool get hasFilters => searchQuery != null || collectionId != null;

  CollectionFilter copyWith({
    String? searchQuery,
    String? collectionId,
    CollectionSortBy? sortBy,
    bool? sortAscending,
  }) {
    return CollectionFilter(
      searchQuery: searchQuery ?? this.searchQuery,
      collectionId: collectionId ?? this.collectionId,
      sortBy: sortBy ?? this.sortBy,
      sortAscending: sortAscending ?? this.sortAscending,
    );
  }

  CollectionFilter clearAll() {
    return CollectionFilter(
      sortBy: sortBy,
      sortAscending: sortAscending,
    );
  }

  @override
  List<Object?> get props => [
        searchQuery,
        collectionId,
        sortBy,
        sortAscending,
      ];
}

enum CollectionSortBy {
  name,
  productCount,
}
