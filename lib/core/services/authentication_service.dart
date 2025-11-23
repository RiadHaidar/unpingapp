import '../helpers/shared_pref_helper.dart';
import '../helpers/constants.dart';

class AuthenticationService {
  final SharedPrefHelper _sharedPrefHelper = SharedPrefHelper();

  Future<String?> getToken() async {
    return await _sharedPrefHelper.getString(AppConstants.keyAuthToken);
  }

  Future<void> saveToken(String token) async {
    await _sharedPrefHelper.saveString(AppConstants.keyAuthToken, token);
  }

  Future<void> clearToken() async {
    await _sharedPrefHelper.remove(AppConstants.keyAuthToken);
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<String?> getUserId() async {
    return await _sharedPrefHelper.getString(AppConstants.keyUserId);
  }

  Future<void> saveUserId(String userId) async {
    await _sharedPrefHelper.saveString(AppConstants.keyUserId, userId);
  }

  Future<void> logout() async {
    await _sharedPrefHelper.remove(AppConstants.keyAuthToken);
    await _sharedPrefHelper.remove(AppConstants.keyUserId);
  }
}