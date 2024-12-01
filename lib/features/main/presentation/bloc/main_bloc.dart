
import 'package:charify_front/features/main/domain/repository/application_repository.dart';
import 'package:charify_front/features/main/domain/repository/category_repository.dart';
import 'package:charify_front/features/main/presentation/bloc/main_event.dart';
import 'package:charify_front/features/main/presentation/bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final ApplicationRepository applicationRepository;
  final CategoryRepository categoryRepository;

  MainBloc(
      {required this.applicationRepository, required this.categoryRepository})
      : super(MainState.initial()) {
    on<GetCategoriesEvent>(onGetCategoriesEvent);
    on<LoadApplicationsEvent>(onLoadApplicationsEvent);
    on<ToggleFilterByCategoryEvent>(onToggleFilterByCategoryEvent);
    on<SetIsUrgentFilterEvent>(onSetIsUrgentFilterEvent);
    on<SetSearchFilterEvent>(onSetSearchFilterEvent,
        transformer: (events, mapper) {
      return events
          .debounceTime(const Duration(milliseconds: 500))
          .flatMap(mapper);
    });
    on<ClearFiltersEvent>(onClearFiltersEvent);
  }

  void onGetCategoriesEvent(
      GetCategoriesEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(status: MainStatus.loading));
    var result = await categoryRepository.getCategories();
    result.fold((l) {
      emit(state.copyWith(
          status: MainStatus.error, errorMessage: l.errorMessage));
    }, (r) {
      emit(state.copyWith(
          categories: r, status: MainStatus.successfullyGotCategories));
    });
  }

  void onLoadApplicationsEvent(
      LoadApplicationsEvent event, Emitter<MainState> emit) async {
    if (state.categories?.isEmpty ??
        false || state.status == MainStatus.loading) {
      return;
    }
    emit(state.copyWith(status: MainStatus.loading));

    if (event.refresh) {
      emit(state.copyWith(
        applicationsByCategory: {},
        lastApplications: [],
        applicationsPage: 1,
        categoryPage: 1,
      ));
    }

    if (state.isUrgentFilter ||
        state.filterByCategory != null ||
        (state.searchFilter?.isNotEmpty ?? false)) {
      var result = await applicationRepository.getApplications(
          search: state.searchFilter,
          categoryId: state.filterByCategory?.id,
          isUrgent: state.isUrgentFilter,
          page: state.applicationsPage);
      result.fold((l) {
        emit(state.copyWith(
            status: MainStatus.error, errorMessage: l.errorMessage));
      }, (r) {
        emit(state.copyWith(
            status: MainStatus.successfullyGotApplications,
            lastApplications: [...state.lastApplications ?? [], ...r],
            applicationsPage: state.applicationsPage + 1));
      });
    } else {
      for (int i = 0; i < 3; i++) {
        if (state.categoryPage - 1 >= state.categories!.length) {
          break;
        }
        var result = await applicationRepository.getApplications(
          categoryId: state.categories![state.categoryPage - 1].id,
          limit: 2,
          page: 1,
        );
        result.fold((l) {}, (r) {
          if (r.isNotEmpty) {
            emit(state.copyWith(
                status: MainStatus.successfullyGotApplications,
                applicationsByCategory: {
                  ...state.applicationsByCategory ?? {},
                  state.categories![state.categoryPage - 1]: r,
                },
                categoryPage: state.categoryPage + 1));
          } else {
            emit(state.copyWith(
              status: MainStatus.successfullyGotApplications,
              categoryPage: state.categoryPage + 1,
            ));
          }
        });
      }

      var result = await applicationRepository.getApplications(
          page: state.applicationsPage);
      result.fold((l) {
        emit(state.copyWith(
            status: MainStatus.error, errorMessage: l.errorMessage));
      }, (r) {
        emit(state.copyWith(
            status: MainStatus.successfullyGotApplications,
            lastApplications: [...state.lastApplications ?? [], ...r],
            applicationsPage: state.applicationsPage + 1));
      });
    }
  }

  void onToggleFilterByCategoryEvent(
      ToggleFilterByCategoryEvent event, Emitter<MainState> emit) async {
    if (state.filterByCategory == event.categoryEntity) {
      emit(state.copyWith(nullifyFilterByCategory: true));
    } else {
      emit(state.copyWith(filterByCategory: event.categoryEntity));
    }
    add(LoadApplicationsEvent(refresh: true));
  }

  void onSetIsUrgentFilterEvent(
      SetIsUrgentFilterEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(isUrgentFilter: event.isUrgent));
    add(LoadApplicationsEvent(refresh: true));
  }

  void onSetSearchFilterEvent(
      SetSearchFilterEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(searchFilter: event.search));
    add(LoadApplicationsEvent(refresh: true));
  }

  void onClearFiltersEvent(
      ClearFiltersEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(isUrgentFilter: false, nullifyFilterByCategory: true));
    add(LoadApplicationsEvent(refresh: true));
  }
}
