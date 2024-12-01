import 'package:charify_front/features/main/domain/entity/category_entity.dart';

abstract class MainEvent{

}
class GetCategoriesEvent extends MainEvent{

}
class LoadApplicationsEvent extends MainEvent{
  final bool refresh;

  LoadApplicationsEvent({this.refresh = false});
}

class ToggleFilterByCategoryEvent extends MainEvent{
  final CategoryEntity? categoryEntity;

  ToggleFilterByCategoryEvent({required this.categoryEntity});
}

class SetIsUrgentFilterEvent extends MainEvent{
  final bool isUrgent ;

  SetIsUrgentFilterEvent({required this.isUrgent});
}

class SetSearchFilterEvent extends MainEvent{
  final String search;

  SetSearchFilterEvent({required this.search});
}

class ClearFiltersEvent extends MainEvent{

}