import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/DarkState.dart';
import 'package:news_app/network/local/cache_helper.dart';

class DarkCubit extends Cubit<ChangeTheme>
{
  DarkCubit() : super(AppChangeModeState());

  static DarkCubit get(context) => BlocProvider.of(context);


  bool isDark = false;

  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null)
    {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CachHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}