import 'package:charify_front/features/main/domain/entity/donation_entity.dart';

enum HistoryStatus { initial, loading, success, error }

class HistoryState {
  final HistoryStatus status;
  final String? errorMessage;

  final List<DonationEntity>? donations;

  final int page;

  HistoryState._(
      {required this.status, this.errorMessage, this.donations, this.page = 1});

  factory HistoryState.initial() =>
      HistoryState._(status: HistoryStatus.initial);

  HistoryState copyWith(
      {HistoryStatus? status,
      String? errorMessage,
      List<DonationEntity>? donations,
      int? page}) {
    return HistoryState._(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        page: page ?? this.page,
        donations: donations ?? this.donations);
  }
}
