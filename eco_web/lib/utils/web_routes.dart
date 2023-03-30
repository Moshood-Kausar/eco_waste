import 'package:eco_web/views/dashboard.dart';
import 'package:eco_web/views/recycle_items.dart';
import 'package:eco_web/views/waste_items.dart';
import 'package:flutter/material.dart';

import '../views/sign_in.dart';

class WebRoutes {
  Map<String, Widget Function(BuildContext ctx)> routes =
      <String, WidgetBuilder>{
    '/': (ctx) => const SignIn(),
    '/dashboard': (ctx) => const DashBoard(),
    '/recycleitems': (ctx) => const RecycleItems(),
    '/wasteitems': (ctx) => const WasteItems(),
  };
}
