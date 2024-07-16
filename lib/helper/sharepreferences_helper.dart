import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesHelper {
  SharedPreferences? _sharedPreferences;
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _email = 'email';
  static const String _profilePhoto = 'photoUrl';
  static const String _phone = 'phone';
  static const String _isShowOnBoarding = 'isShowOnBoarding';
  static const String _userAppId = 'userAppId';
  static const String _fcmToken = 'fcmToken';
  static const String _isNotificationOn = 'notificationOn';
  static const String _quickLoginType = 'quickLoginType';
  static const String _roomCode = 'roomCode';
  static const String _unReadNotiCountDate = 'unReadNotiCountDate';
  static const String _unReadNotiCount = 'unReadNotiCount';

  Future initSharePref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void clearSharePref() {
    _sharedPreferences!
      ..remove(_id)
      ..remove(_name)
      ..remove(_email)
      ..remove(_profilePhoto)
      ..remove(_fcmToken)
      ..remove(_isNotificationOn)
      ..remove(_quickLoginType)
      ..remove(_roomCode)
      ..remove(_unReadNotiCountDate)
      ..remove(_userAppId);
  }

  void setLoginSharePref(
    int id,
    String phone,
    String name,
    String userAppId,
    String profilePhoto,
  ) {
    _sharedPreferences!
      ..setInt(_id, id)
      ..setString(_phone, phone)
      ..setString(_userAppId, userAppId)
      ..setString(_name, name)
      ..setString(_profilePhoto, profilePhoto);
  }

  String getUserAppId() {
    return _sharedPreferences!.getString(_userAppId) ?? '';
  }

  String getUserName() {
    return _sharedPreferences!.getString(_name) ?? '';
  }

  void setRoomCode(String roomCode) {
    _sharedPreferences!.setString(_roomCode, roomCode);
  }

  void setNotiCount(int notiCount) {
    _sharedPreferences!.setInt(_unReadNotiCount, notiCount);
  }

  void setUnReadNotiCountDate(String date) {
    _sharedPreferences!.setString(_unReadNotiCountDate, date);
  }

  String? getRoomCode() {
    return _sharedPreferences!.getString(_roomCode) ?? '';
  }

  int getNotiCount() {
    return _sharedPreferences!.getInt(_unReadNotiCount) ?? 0;
  }

  int? getId() {
    print('dfsdf${_id}');
    return _sharedPreferences!.getInt(_id) ?? 0;
  }

  String getUnReadNotiCountDate() {
    return _sharedPreferences!.getString(_unReadNotiCountDate) ?? '';
  }

  void setUserName(String name) {
    _sharedPreferences!.setString(_name, name);
  }

  void setLoginType(int? type) {
    _sharedPreferences!.setInt(_quickLoginType, type ?? 0);
  }

  String getPhotoUrl() {
    return _sharedPreferences!.getString(_profilePhoto) ?? '';
  }

  bool? isLogin() {
    return _sharedPreferences!.getInt(_id) != null;
  }

  void setIsShowOnBoarding(bool isShow) {
    _sharedPreferences!.setBool(_isShowOnBoarding, isShow);
  }

  void setProfilePhoto(String photo) {
    _sharedPreferences!.setString(_profilePhoto, photo);
  }

  bool isOnBoardingShow() {
    return _sharedPreferences!.getBool(_isShowOnBoarding) ?? false;
  }

  void setFcmToken(String token) {
    _sharedPreferences!.setString(_fcmToken, token);
  }

  String? getFcmToken() {
    return _sharedPreferences!.getString(_fcmToken);
  }

  void setNotificationOn(bool isOn) {
    _sharedPreferences!.setBool(_isNotificationOn, isOn);
  }

  bool isNotificationOn() {
    return _sharedPreferences!.getBool(_isNotificationOn) ?? false;
  }
}
