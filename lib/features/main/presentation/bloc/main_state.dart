import 'package:charify_front/features/main/domain/entity/application_entity.dart';
import 'package:charify_front/features/main/domain/entity/category_entity.dart';

enum MainStatus {
  initial,
  loading,
  successfullyGotCategories,
  successfullyGotApplications,
  error,
}

class MainState {
  final MainStatus status;
  final String? errorMessage;

  final List<CategoryEntity>? categories;
  final Map<CategoryEntity, List<ApplicationEntity>>? applicationsByCategory;
  final List<ApplicationEntity>? lastApplications;

  final int categoryPage;
  final int applicationsPage;

  final CategoryEntity? filterByCategory;
  final bool isUrgentFilter;
  final String? searchFilter;

  MainState._(
      {required this.status,
      this.errorMessage,
      this.categories,
      this.applicationsByCategory,
      this.lastApplications,
      this.categoryPage = 1,
      this.applicationsPage = 1,
      this.filterByCategory,
      this.isUrgentFilter = false,
      this.searchFilter});

  factory MainState.initial() => MainState._(status: MainStatus.initial);

  MainState copyWith(
      {MainStatus? status,
      String? errorMessage,
      List<CategoryEntity>? categories,
      Map<CategoryEntity, List<ApplicationEntity>>? applicationsByCategory,
      List<ApplicationEntity>? lastApplications,
      int? categoryPage,
      int? applicationsPage,
      CategoryEntity? filterByCategory,
      bool nullifyFilterByCategory = false,
      String? searchFilter,
      bool? isUrgentFilter}) {
    return MainState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
      applicationsByCategory:
          applicationsByCategory ?? this.applicationsByCategory,
      lastApplications: lastApplications ?? this.lastApplications,
      categoryPage: categoryPage ?? this.categoryPage,
      applicationsPage: applicationsPage ?? this.applicationsPage,
      searchFilter: searchFilter ?? this.searchFilter,
      isUrgentFilter: isUrgentFilter ?? this.isUrgentFilter,
      filterByCategory: nullifyFilterByCategory
          ? null
          : filterByCategory ?? this.filterByCategory,
    );
  }
}
