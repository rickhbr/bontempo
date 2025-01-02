import 'package:bontempo/blocs/clothing/clothing_bloc.dart';
import 'package:bontempo/models/clothing_model.dart';

class ClothesEditArguments {
  final ClothingModel? clothing;
  final ClothingBloc? clothingBloc;
  ClothesEditArguments({this.clothing, this.clothingBloc});
}
