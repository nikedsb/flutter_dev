import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_app/models/user.dart';
import 'package:sns_app/repositories/user.dart';

final userFutureProvider =
    FutureProvider<List<User>>((_) async => await fetchUsers());
