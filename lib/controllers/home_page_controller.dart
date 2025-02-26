import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_tutorial/models/pokemon.dart';
import 'package:riverpod_tutorial/services/http_service.dart';

import '../models/page_data.dart';

class HomePageController extends StateNotifier<HomePageData> {
  final GetIt _getit = GetIt.instance;

  late HTTPService _httpService;

  HomePageController(
    super.state,
  ) {
    _httpService = _getit.get<HTTPService>();
    _setup();
  }

  Future<void> _setup() async {
    loadData();
  }

  Future<void> loadData() async {
    if (state.data == null) {
      Response? res = await _httpService.get(
        "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0",
      );
      // print(res?.data);
      if (res != null && res.data != null) {
        PokemonListData data = PokemonListData.fromJson(res.data);
        state = state.copyWith(
          data: data,
        );
      }
    } else {}
  }
}
