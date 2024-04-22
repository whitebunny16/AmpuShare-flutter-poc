import 'package:ampushare/data/models/auth_model/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDrawer extends HookConsumerWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileImage = useState<String>("");
    final fullName = useState<String>("");
    final email = useState<String>("");

    void getProfile() async {
      final prefs = await SharedPreferences.getInstance();
      final authModelString = prefs.getString('authModel');
      AuthModel authModel = authModelFromJson(authModelString!);
      profileImage.value = authModel.user.profileImage;
      fullName.value = '${authModel.user.firstName} ${authModel.user.lastName}';
      email.value = authModel.user.email;
    }

    useEffect(() {
      getProfile();
      return null;
    }, []);

    void onProfileIconPress() {
      // Navigate to profile page
    }

    void onBuddiesIconPress() {
      // Navigate to buddies page
    }

    void onLogoutIconPress() {
      // Handle logout
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(fullName.value),
            accountEmail: Text(email.value),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  '${dotenv.get('API_HOST')}${profileImage.value}'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('View Profile'),
            onTap: onProfileIconPress,
          ),
          ListTile(
              leading: const Icon(Icons.group),
              title: const Text('View Buddies'),
              onTap: onBuddiesIconPress),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: onLogoutIconPress,
          ),
        ],
      ),
    );
  }
}
