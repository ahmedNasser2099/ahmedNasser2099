import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goshop/cubit/states.dart';

import '../models/searchModel/searchModel.dart';
import '../remoteNetwork/dioHelper.dart';
import '../remoteNetwork/endPoints.dart';
import '../shared/constants.dart';


class SearchCubit extends Cubit<ShopStates> {
  SearchCubit() : super(InitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void getSearchData(String searchText){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text':'$searchText',
        }
    ).then((value){
      searchModel = SearchModel.fromJson(value.data);
      print('Search '+searchModel!.status.toString());
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
      print(error.toString());
    });
  }
}