import 'package:capstone_1/blocs/edit_profile_bloc/edit_profile_event.dart';
import 'package:capstone_1/blocs/edit_profile_bloc/edit_profile_state.dart';
import 'package:capstone_1/globals/global_user.dart';
import 'package:capstone_1/services/supabase_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<UpdateProfileEvent>((event, emit) async {
      try {
        emit(LoadingState());
        if (event.name.isNotEmpty &&
            event.phone.isNotEmpty &&
            event.age.isNotEmpty) {
          try {
            int.parse(event.age);
          } catch (e) {
            emit(ErrorState(message: 'The age must be integer only'));
            
          }
          if (event.phone.length != 10) {
            emit(ErrorState(message: 'The phone number should be 10 numbers'));
            
          } else {
            await updateUser(
               
                name: event.name,
                phone: event.phone,
                age: int.parse(event.age),
                city: event.city);
            currentUser!.imageUrl =
                'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-shelby-gt500-02-1636734552.jpg';
            currentUser!.name = event.name;
            currentUser!.phone = event.phone;
            currentUser!.age = int.parse(event.age);
            currentUser!.city = event.city;
           
            emit(UpdateProfileState());
          }
        } else {
          
          emit(EmptyState(message: 'All fileds are required'));
        }
      } catch (e) {
        emit(ErrorState(message: 'Error!'));
      }
    });
  }
}
