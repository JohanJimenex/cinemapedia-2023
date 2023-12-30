import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/datasources/isardb_datasource_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/localdb_repository_impl.dart';

final localDBRepositoryProvider = Provider(
    (ref) => LocalDBRepositoryImpl(dataSource: IsarDBDatasourceImpl()));
