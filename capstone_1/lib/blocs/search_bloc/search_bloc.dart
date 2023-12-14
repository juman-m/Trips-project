import 'package:capstone_1/blocs/search_bloc/search_event.dart';
import 'package:capstone_1/blocs/search_bloc/search_state.dart';
import 'package:capstone_1/models/user.dart';
import 'package:capstone_1/services/supabase_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchRequestEvent>((event, emit) async {
      emit(LoadingState());
      final List<UserModel> usersList = await getSearchUser(event.query);
      final currentUserId = Supabase.instance.client.auth.currentUser!.id;
      for (var element in usersList) {
        var check =
            await isFollowed(currentUserId, element.user_uuid.toString());
        if (check == false) {
          element.followState = false;
        } else if (check == true) {
          element.followState = true;
        }
      }
      emit(ResultResponseState(response: usersList));
    });

    on<ClearSearchEvent>((event, emit) async {
      emit(ClearSearchState());
    });

    on<FollowEvent>((event, emit) async {
      emit(LoadingState());
      final currentUserId = Supabase.instance.client.auth.currentUser!.id;
      final check =
          await isFollowed(currentUserId, event.user.user_uuid.toString());
      final List<UserModel> usersList = await getSearchUser(event.query);


      if (check == false) {
        
        for (var element in usersList) {
          if (element.user_uuid == event.user.user_uuid) {
            await follow(currentUserId, event.user.user_uuid.toString());
            element.followState = false;
          
          }
        }
      } else if (check == true) {
       
        for (var element in usersList) {
          if (element.user_uuid == event.user.user_uuid) {
            await unfollow(event.user.user_uuid.toString());
            element.followState = true;
       
          }
        }
      }
      emit(FollowState(users: usersList));
    });
  }
}
