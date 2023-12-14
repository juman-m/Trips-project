import 'dart:io';

import 'package:capstone_1/models/trip.dart';
import 'package:capstone_1/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

addUser(Map body) async {
  final supabase = Supabase.instance.client;
  await supabase.from("users").insert(body).select();
}

Future<List<UserModel>> getUsers() async {
  final supabase = Supabase.instance.client;
  final users = await supabase.from("users").select();
  final List<UserModel> usersObjectList = [];

  for (var element in users) {
    usersObjectList.add(UserModel.fromJson(element));
  }
  return usersObjectList;
}

Future<List<UserModel>> getFollowing(String userId) async {
  final supabase = Supabase.instance.client;
  final List following = await supabase
      .from('following')
      .select('follows_uuid')
      .eq('user_uuid', userId);
  final List users = await supabase.from('users').select();
  List joinList = [];
  List<UserModel> usersObject = [];
  for (var followingUsers in following) {
    for (var element in users) {
      if (followingUsers['follows_uuid'] == element['user_uuid']) {
        joinList.add(element);
      }
    }
  }
  for (var element in joinList) {
    usersObject.add(UserModel.fromJson(element));
  }
  return usersObject;
}

Future<List<UserModel>> getFollowers(String userId) async {
  final supabase = Supabase.instance.client;
  final List followers = await supabase
      .from('followers')
      .select('followed_uuid')
      .eq('user_uuid', userId);
  final List users = await supabase.from('users').select();
  List joinList = [];
  List<UserModel> usersObject = [];
  for (var followersUsers in followers) {
    for (var element in users) {
      if (followersUsers['followed_uuid'] == element['user_uuid']) {
        joinList.add(element);
      }
    }
  }
  for (var element in joinList) {
    usersObject.add(UserModel.fromJson(element));
  }
  return usersObject;
}

Future<void> follow(String userId, String followUserId) async {
  final supabase = Supabase.instance.client;
  await supabase
      .from('following')
      .insert({'user_uuid': userId, 'follows_uuid': followUserId});
  await supabase
      .from('followers')
      .insert({'user_uuid': followUserId, 'followed_uuid': userId});
}

Future<void> unfollow(String unFollowUserId) async {
  final supabase = Supabase.instance.client;
  final currentUserId = Supabase.instance.client.auth.currentUser!.id;
  final List followingList = await supabase.from('following').select('*');
  final List followersList = await supabase.from('followers').select('*');

  for (var i = 0; i < followersList.length; i++) {
    if (currentUserId == followingList[i]['user_uuid'] &&
        unFollowUserId == followingList[i]['follows_uuid']) {
      await supabase
          .from('following')
          .delete()
          .eq('follows_uuid', unFollowUserId);
      await supabase.from('followers').delete().eq('user_uuid', unFollowUserId);
    }
  }

  await supabase.from('followers').delete().eq('user_uuid', unFollowUserId);
}

Future<bool> isFollowed(String currentUser, String checkUser) async {
  bool isAfollower = false;
  final supabase = Supabase.instance.client;
  final List following = await supabase.from('following').select();

  for (var element in following) {
    if (element['user_uuid'] == currentUser &&
        element['follows_uuid'] == checkUser) {
      isAfollower = true;
      break;
    } else {
      isAfollower = false;
    }
  }
  return isAfollower;
}

Future<UserModel> getUserById(String userId) async {
  final supabase = Supabase.instance.client;
  final response =
      await supabase.from("users").select('*').eq('user_uuid', userId);
  final UserModel user = UserModel.fromJson(response[0]);
  return user;
}

Future<List<Trip>> getOwnerTrips(String userID) async {
  final supabase = Supabase.instance.client;
  final trips = await supabase.from("trips").select().eq('creator_id', userID);
  final List<Trip> tripsObjectList = [];
  for (var element in trips) {
    tripsObjectList.add(Trip.fromJson(element));
  }

 
  return tripsObjectList;
}

Future updateUser({
  required String name,
  required String phone,
  required int age,
  required String city,
}) async {
  final supabase = Supabase.instance.client;
  await supabase.from('users').update({
    'name': name,
    'phone': phone,
    'city': city,
    'age': age,
  }).eq('user_uuid', supabase.auth.currentUser!.id);
}



Future<UserModel> getUser() async {
  final supabase = Supabase.instance.client;
  await Future.delayed(const Duration(seconds: 1));
  final String id = Supabase.instance.client.auth.currentUser!.id;
  final response = await supabase.from("users").select('*').eq('user_uuid', id);
  final UserModel user = UserModel.fromJson(response[0]);
  return user;
}

Future<UserModel> getAUser(String id) async {
  final supabase = Supabase.instance.client;
  final response = await supabase.from("users").select('*').eq('user_uuid', id);
  final UserModel user = UserModel.fromJson(response[0]);
  return user;
}

Future<List<UserModel>> getSearchUser(String name) async {
  final supabase = Supabase.instance.client;
  final List<UserModel> usersList = [];
  final response = await supabase.from("users").select('*').ilike('name', name);
  for (var element in response) {
    usersList.add(UserModel.fromJson(element));
  }
  return usersList;
}

Future<List<Trip>> getTrips({String? Userid}) async {
  final supabase = Supabase.instance.client;
  await Future.delayed(const Duration(seconds: 1));

  List data = [];
  List<Trip> tripsList = [];
  try {
    if (Userid != null) {
      data = await supabase
          .from('trips')
          .select('*, a_trip!inner()')
          .eq('a_trip.joint_id', Userid);
    } else {
      data = await supabase.from('trips').select('*');
    }

    for (var element in data) {
      tripsList.add(Trip.fromJson(element));
    }
  } catch (e) {
    print(e.toString());
  }
  return tripsList;
}

Future<List<Trip>> getFollowingTrips({String? id}) async {
  final supabase = Supabase.instance.client;
  List<Trip> tripsList = [];
  List<Trip> followingTripsList = [];
  try {
    final followingList =
        await supabase.from('following').select('*').eq('user_uuid', id);

    tripsList = await getTrips();

    for (var trip in tripsList) {
      for (var following in followingList) {
        if (following['follows_uuid'] == trip.tripCreator) {
          followingTripsList.add(trip);
        }
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return followingTripsList;
}

deleteTrip({required int id}) async {
  final supabase = Supabase.instance.client;
  await supabase.from('a_trip').delete().eq("trip_id", id);
  await supabase.from('trips').delete().eq("id", id);
}

addUserToTrip(Map body) async {
  final supabase = Supabase.instance.client;
  await supabase.from("a_trip").insert(body).select();
}

Future<bool> searchUserInTrip(
    {required String userId, required int tripId}) async {
  final supabase = Supabase.instance.client;
  final List response = await supabase
      .from("a_trip")
      .select('*')
      .match({'joint_id': userId, 'trip_id': tripId});

  if (response.isEmpty) {
    return false;
  }
  return true;
}

unjointTrip({required String userId, required int tripId}) async {
  final supabase = Supabase.instance.client;
  await supabase
      .from('a_trip')
      .delete()
      .match({'joint_id': userId, 'trip_id': tripId});
}

Future<void> addTrip(Map<String, dynamic> body, File? image) async {
  final supabase = Supabase.instance.client;

  if (image != null) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final imageName = '$timestamp.png';

    await supabase.storage.from("image_project").upload(imageName, image);

    final imageUrl =
        supabase.storage.from("image_project").getPublicUrl(imageName);

    body["image"] = imageUrl;
  } else {
    body["image"] =
        'https://www.fabhotels.com/blog/wp-content/uploads/2020/05/road-trip-hacks-tips-600.jpg';
  }

  await supabase.from("trips").insert(body).select();
}

Future<Trip> getTripDetails(String tripId) async {
  final supabase = Supabase.instance.client;

  final response =
      await supabase.from("trips").select().eq('id', tripId).single();

  return Trip.fromJson(response.data.first as Map<String, dynamic>);
}


Future<void> updateTrip(String tripId, Map<String, dynamic> body, File? image) async {
  final supabase = Supabase.instance.client;

  if (image != null) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final imageName = '$timestamp.png';

    await supabase.storage.from("image_project").upload(imageName, image);

    final imageUrl =
        supabase.storage.from("image_project").getPublicUrl(imageName);

    body["image"] = imageUrl;
  }

  await supabase.from("trips").update(body).eq('id', tripId);
}






