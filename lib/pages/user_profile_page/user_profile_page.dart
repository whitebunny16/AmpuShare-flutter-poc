import 'dart:convert';

import 'package:ampushare/data/models/auth_model/auth_model.dart';
import 'package:ampushare/data/models/buddy/buddy_follow_model.dart';
import 'package:ampushare/data/models/profile/user_profile_model.dart';
import 'package:ampushare/services/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends HookWidget {
  final String username;

  const UserProfilePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final userProfile = useState<UserProfileModel?>(null);
    final isFollowing = useState<bool>(false);

    final currentUserId = useState<int>(0);

    void getProfile() async {
      final prefs = await SharedPreferences.getInstance();
      final authModelString = prefs.getString('authModel');
      AuthModel authModel = authModelFromJson(authModelString!);
      currentUserId.value = authModel.user.id;
    }

    useEffect(() {
      void fetchUserProfile() async {
        var dio = await DioHelper.getDio();
        final response = await dio.get('/api/user/$username/profile');
        userProfile.value = userProfileModelFromJson(jsonEncode(response.data));

        getProfile();

        final followersResponse =
            await dio.get('/api/user/${userProfile.value?.userId}/followers');
        buddyFollowModelFromJson(jsonEncode(followersResponse.data));
        isFollowing.value =
            buddyFollowModelFromJson(jsonEncode(followersResponse.data))
                .any((element) => element.follower == currentUserId.value);
      }

      fetchUserProfile();
    }, [isFollowing]);

    Future<void> followUser() async {
      var dio = await DioHelper.getDio();
      try {
        final response =
            await dio.post('/api/user/${userProfile.value?.userId}/follow');
        Fluttertoast.showToast(
          msg: "Followed successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Follow failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        throw e;
      }
    }

    Future<void> unfollowUser() async {
      var dio = await DioHelper.getDio();
      try {
        final response =
            await dio.delete('/api/user/${userProfile.value?.userId}/unfollow');
        Fluttertoast.showToast(
          msg: "Unfollowed successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Unfollow failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        throw e;
      }
    }

    void onFollowToggle() async {
      if (isFollowing.value) {
        await unfollowUser();
        isFollowing.value = false;
      } else {
        await followUser();
        isFollowing.value = true;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
      ),
      body: userProfile.value == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 75,
                          backgroundImage: NetworkImage(
                              '${dotenv.get('API_HOST')}${userProfile.value?.profilePic}'),
                        ),
                        Text(
                            'Name: ${userProfile.value?.firstName} ${userProfile.value?.lastName}'),
                        Text('Username: ${userProfile.value?.username}'),
                        Text('Email: ${userProfile.value?.email}'),
                        Text(
                            'Gender: ${userProfile.value?.gender == "F" ? "Female" : userProfile.value?.gender == "M" ? "Male" : "Others"}'),
                        Text(
                            'Date of Birth: ${userProfile.value?.dateOfBirth.toIso8601String()}'),
                        Text(
                            'Join Date: ${userProfile.value?.createdAt.toIso8601String()}'),
                        ElevatedButton(
                          onPressed: onFollowToggle,
                          child:
                              Text(isFollowing.value ? 'Unfollow' : 'Follow'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
