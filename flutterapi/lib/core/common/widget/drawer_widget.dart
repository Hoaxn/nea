import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterapi/config/routers/app_route.dart';
import 'package:flutterapi/features/home/viewmodel/home_viewmodel.dart';

class CustomDrawer extends ConsumerStatefulWidget {
  const CustomDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    const gap = SizedBox(height: 10);

    return Drawer(
      width: deviceWidth * 0.7,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 170,
            decoration: BoxDecoration(color: Colors.lightBlue.withOpacity(0.7)),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          gap,
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoute.homeRoute);
            },
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(Icons.home),
                ),
                SizedBox(width: 16.0),
                Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          gap,
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, AppRoute.sevenHourExceededRoute);
            },
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(Icons.file_open),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  "Seven Hour Exceeded",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          gap,
          InkWell(
            onTap: () async {
              ref.read(homeViewModelProvider.notifier).logout(context);
            },
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  "Log out",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
