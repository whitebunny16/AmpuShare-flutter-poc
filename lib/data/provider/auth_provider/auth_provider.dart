import 'package:ampushare/data/models/auth_model/auth_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authModelProvider =
    StateNotifierProvider<AuthModelNotifier, AuthModel>((ref) {
  return AuthModelNotifier();
});

class AuthModelNotifier extends StateNotifier<AuthModel> {
  AuthModelNotifier()
      : super(AuthModel(
            access: '',
            refresh: '',
            user: AuthUser(
                firstName: '',
                lastName: '',
                profileImage: '',
                id: 0,
                email: '')));

  void updateAuthModel(AuthModel newModel) {
    state = newModel;
  }
}

class AuthRepository {
  Future<AuthModel> getAuthModel() async {
    final prefs = await SharedPreferences.getInstance();
    final authModelString = prefs.getString('authModel');
    if (authModelString != null) {
      return authModelFromJson(authModelString);
    } else {
      return AuthModel(
          access: '',
          refresh: '',
          user: AuthUser(
              firstName: '', lastName: '', profileImage: '', id: 0, email: ''));
    }
  }

  Future<void> setAuthModel(AuthModel model) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('authModel', authModelToJson(model));
  }
}

final authProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});
