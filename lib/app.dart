import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdc_flutter_cupertino/product_list_tab.dart';
import 'package:gdc_flutter_cupertino/search_tab.dart';
import 'package:gdc_flutter_cupertino/shopping_cart_tab.dart';
import 'package:provider/provider.dart';

import 'model/app_state_model.dart';

class CupertinoStoreApp extends StatelessWidget {
  const CupertinoStoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      home: CupertinoStoreHomePage(),
    );
  }
}

class CupertinoStoreHomePage extends StatelessWidget {
  const CupertinoStoreHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(builder: (context, model, child) {
      return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          iconSize: 26,
          height: 55,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: "Products",
            ),
            const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Badge(
                  badgeContent: Text(
                    model.productsInCart.length.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  toAnimate: false,
                  child: const Icon(CupertinoIcons.shopping_cart)),
              label: 'Cart',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          late final CupertinoTabView returnValue;
          switch (index) {
            case 0:
              returnValue = CupertinoTabView(
                builder: (context) {
                  return const CupertinoPageScaffold(
                    child: ProductListTab(),
                  );
                },
              );
              break;
            case 1:
              returnValue = CupertinoTabView(
                builder: ((context) {
                  return const CupertinoPageScaffold(
                    child: SearchTab(),
                  );
                }),
              );
              break;
            case 2:
              returnValue = CupertinoTabView(
                builder: ((context) {
                  return const CupertinoPageScaffold(
                    child: ShoppingCartTab(),
                  );
                }),
              );
              break;
          }
          return returnValue;
        },
      );
    });
  }
}
