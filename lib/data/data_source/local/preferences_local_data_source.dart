import 'dart:convert';

import '../../../domain/entities/beers.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constants/keys.dart';
import '../../../core/error/exceptions.dart';
import '../../models/response/beers_model.dart';

abstract class PreferencesLocalDataSource {
  Future<void> persistToken(String token);

  Future<String?> get token;

  Future<void> addFavorite(Beers item);
  Future<void> removeFavoriteAll();
  Future<void> removeFavorite(Beers item);

  Future<List<Beers>> get favorites;
}

class PreferencesLocalDataSourceImpl implements PreferencesLocalDataSource {
  const PreferencesLocalDataSourceImpl(this.secureStorage);

  final FlutterSecureStorage secureStorage;

  @override
  Future<void> persistToken(String token) async {
    try {
      await secureStorage.write(key: SharedPrefKeys.token, value: token);
    } catch (_) {
      throw SecureStorageException();
    }
  }

  @override
  Future<String?> get token async {
    try {
      return await secureStorage.read(key: SharedPrefKeys.token);
    } catch (_) {
      throw SecureStorageException();
    }
  }

  @override
  Future<void> addFavorite(Beers item) async {
    try {
      String? value = await secureStorage.read(key: SharedPrefKeys.favorite);
      List<Beers>? fav = List<Beers>.from(
          json.decode(value ?? "[]").map((x) => Beers.fromJson(x)));

      fav.add(item);

      await secureStorage.write(
        key: SharedPrefKeys.favorite,
        value: json.encode(
          List<dynamic>.from(
            fav.map(
              (x) => x.toJson(),
            ),
          ),
        ),
      );
    } catch (e) {
      throw SecureStorageException();
    }
  }

  @override
  Future<List<Beers>> get favorites async {
    try {
      String? value = await secureStorage.read(key: SharedPrefKeys.favorite);
      List<Beers>? fav = List<Beers>.from(
          json.decode(value ?? '[]').map((x) => Beers.fromJson(x)));

      return fav;
    } catch (e) {
      throw SecureStorageException();
    }
  }

  @override
  Future<void> removeFavoriteAll() async {
    await secureStorage.delete(key: SharedPrefKeys.favorite);
  }

  @override
  Future<void> removeFavorite(Beers item) async {
    try {
      String? value = await secureStorage.read(key: SharedPrefKeys.favorite);
      List<Beers>? fav = [];

      fav.addAll(List<Beers>.from(
          json.decode(value ?? "[]").map((x) => Beers.fromJson(x))));
      for (var i = 0; i < fav.length; i++) {
        if (fav[i].id == item.id) {
          fav.removeAt(i);
        }
      }

      await secureStorage.write(
        key: SharedPrefKeys.favorite,
        value: json.encode(
          List<dynamic>.from(
            fav.map(
              (x) => x.toJson(),
            ),
          ),
        ),
      );
    } catch (e) {
      print(e.toString());
      throw SecureStorageException();
    }
  }
}
