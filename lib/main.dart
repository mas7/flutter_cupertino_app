import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:gdc_flutter_cupertino/model/app_state_model.dart';
import 'package:provider/provider.dart';
import 'app.dart';

void main() {
  return runApp(
    ChangeNotifierProvider<AppStateModel>(
      create: (_) => AppStateModel()..loadProducts(),
      child: const CupertinoStoreApp(),
    ),
  );
}
