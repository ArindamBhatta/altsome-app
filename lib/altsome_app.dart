import 'package:flutter/material.dart';
import 'package:altsome_app/page/home_page/home_page.dart';
import 'package:provider/provider.dart';

import 'page/Authentication/provider/login_auth_provider.dart';
import 'page/home_page/body/top_data_in_page_view/Provider/specification_provider.dart';

class AltsomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginAuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SpecificationProvider(),
        ),
      ],
      child: HomePage(),
    );
  }
}
