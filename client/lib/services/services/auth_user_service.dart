import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:repository/repository.dart';
import 'package:rxdart/subjects.dart';

import '../bloc/data.dart';
import '../services.dart';
import 'storage.dart';
import 'user.dart';

/// A service which offers information about the currently logged in user by
/// listening to the [StorageService]'s [tokenStream] and requesting the
/// currently logged  in user from the [UserService] anytime the token changes.
class AuthUserService {
  AuthUserService({
    @required this.storage,
    @required this.user,
  })  : assert(storage != null),
        assert(user != null) {
    storage.dataStream.map((StorageData data) => data.token).distinct().listen(
      _updateUser,
      onError: (dynamic error) {
        if (error is ItemNotFound) {
          _updateUser(null);
        } else {
          throw error;
        }
      },
    );
    authUserServiceReadyCompleter.complete();
  }

  final StorageService storage;
  final UserService user;

  final BehaviorSubject<User> _meSubject = BehaviorSubject<User>();
  Stream<User> get globalUserStream => _meSubject.stream;
  User get globalUser => _meSubject.value;
  void dispose() => _meSubject.close();

  Future<void> _updateUser(String token) async {
    if (token == null) {
      _meSubject.add(null);
    } else {
      final Id<User> id = Id<User>(_decodeTokenToUser(token));
      final User me = await user.getUser(id);
      _meSubject.add(me);
    }
  }

  // A JWT token consists of a header, body and claim (signature), all
  // separated by dots and encoded in base64. For now, we don't verify the
  // claim, but just decode the body.
  static String _decodeTokenToUser(String jwtEncoded) {
    final String encodedBody = jwtEncoded.split('.')[1];
    final String body = String.fromCharCodes(base64.decode(encodedBody));
    return json.decode(body)['userId'];
  }
}
