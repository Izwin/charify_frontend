
import 'package:charify_front/features/main/domain/repository/application_repository.dart';
import 'package:charify_front/features/main/presentation/bloc/single_application_event.dart';
import 'package:charify_front/features/main/presentation/bloc/single_application_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleApplicationBloc
    extends Bloc<SingleApplicationEvent, SingleApplicationState> {
  final ApplicationRepository applicationRepository;

  SingleApplicationBloc({required this.applicationRepository})
      : super(SingleApplicationState.initial()) {
    on<GetSingleApplicationEvent>(onGetSingleApplicationEvent);
  }

  void onGetSingleApplicationEvent(GetSingleApplicationEvent event,
      Emitter<SingleApplicationState> emit) async {
    var result =
        await applicationRepository.getApplicationById(event.applicationId);
    result.fold((l) {
      emit(state.copyWith(
          status: SingleApplicationStatus.error, errorMessage: l.errorMessage));
    }, (r) {
      emit(state.copyWith(
          status: SingleApplicationStatus.success, applicationEntity: r));
    });
  }
}
