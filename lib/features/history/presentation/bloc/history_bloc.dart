
import 'package:charify_front/features/history/domain/repository/history_repository.dart';
import 'package:charify_front/features/history/presentation/bloc/history_event.dart';
import 'package:charify_front/features/history/presentation/bloc/history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository historyRepository;

  HistoryBloc({required this.historyRepository})
      : super(HistoryState.initial()) {
    on<LoadDonationsEvent>(onLoadDonationsEvent);
  }

  void onLoadDonationsEvent(
      LoadDonationsEvent event, Emitter<HistoryState> emit) async {
    emit(state.copyWith(status: HistoryStatus.loading));
    if (event.refresh) {
      emit(state.copyWith(
        page: 1,
        donations: [],
      ));
    }
    var result = await historyRepository.getDonations(page: state.page);
    result.fold((l) {
      emit(state.copyWith(
          status: HistoryStatus.error, errorMessage: l.errorMessage));
    }, (r) {
      emit(state.copyWith(
          status: HistoryStatus.success,
          donations: [...state.donations ?? [], ...r]));
    });
  }
}
