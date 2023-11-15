import 'package:cooking_recipe_app/data/data_source.dart';
import 'package:cooking_recipe_app/presentation/bloc/cooking_recipe_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<DataSource>(DataSource());

  getIt.registerSingleton<CookingRecipeBloc>(CookingRecipeBloc());
}