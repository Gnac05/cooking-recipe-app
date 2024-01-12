import 'package:cooking_recipe_app/application/jsap-bloc/jsap_bloc.dart';
// import 'package:cooking_recipe_app/infrastructure/cooking-recipe/data-sources/data_source.dart';
// import 'package:cooking_recipe_app/application/cooking-recipe/cooking_recipe_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  // getIt.registerSingleton<DataSource>(DataSource());

  // getIt.registerSingleton<CookingRecipeBloc>(CookingRecipeBloc());

  getIt.registerFactory<JsapBloc>(() => JsapBloc());
}
