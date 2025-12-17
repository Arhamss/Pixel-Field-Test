import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelfield_test/core/di/injector.dart';
import 'package:pixelfield_test/features/home/domain/repository/collection_repository.dart';
import 'package:pixelfield_test/features/home/presentation/cubit/collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit({
    CollectionRepository? repository,
  })  : _repository = repository ?? Injector.resolve<CollectionRepository>(),
        super(const CollectionState());

  final CollectionRepository _repository;

  Future<void> loadCollections() async {
    emit(state.copyWith(collections: state.collections.toLoading()));

    final response = await _repository.getCollections();

    if (response.isSuccess && response.data != null) {
      emit(
        state.copyWith(
          collections: state.collections.toLoaded(data: response.data),
        ),
      );
    } else {
      emit(
        state.copyWith(
          collections: state.collections.toFailure(
            error: response.message ?? 'Failed to load collections',
          ),
        ),
      );
    }
  }

  Future<void> refreshCollections() async {
    await loadCollections();
  }
}
