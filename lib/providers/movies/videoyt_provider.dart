import 'package:cinemapedia/providers/barril_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoYTProvider = FutureProvider.family((ref, String movieId) async {
  final resp = await ref
      .watch(movieRepositoryProvider)
      .getYoutubeVideosByMovieId(movieId);

  return resp;
});
