import 'dart:async';

import 'package:clock_app/MenuType.dart';
import 'package:clock_app/component/clock_view.dart';
import 'package:clock_app/constants/theme_data.dart';
import 'package:clock_app/model/alarm_info.dart';
import 'package:clock_app/model/menu_info.dart';
import 'package:clock_app/pages/alarm_page.dart';
import 'package:clock_app/pages/clock_page.dart';
import 'package:clock_app/pages/stop_watch.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:clock_app/model/alarm_info.dart';
import 'package:clock_app/alarm_helper.dart';

import '../data.dart';

class HomePage extends StatefulWidget {
  _HomePage createState() => _HomePage();
}

class _HomePage extends State {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   var timerInfo = Provider.of<TimerInfor>(context, listen: false);
    //   timerInfo.updateRemainingTime();
    // });
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: Row(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: menuItems.map((currentMenuInfo) => buildMenuButton(currentMenuInfo)).toList(),
            ),
          ),
          VerticalDivider(
            width: 1.0,
            color: Colors.white54,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context , MenuInfo value , Widget child) {
                if (value.menuType == MenuType.clock) {
                  return  ClockPage();
                }else if(value.menuType == MenuType.alarm){
                  return ChangeNotifierProvider<AlarmHelper>(
                      create: (context) => AlarmHelper(),
                child: AlarmPage());

                }else if(value.menuType == MenuType .stopWatch){
                  return StopWatch();

                }
                else{
                  return Center(
                    child: Text(
                      " UpComping Soon"
                          ,style: TextStyle(
                      fontSize: 40.0,
                      color : Colors.white
                    )
                    )
                  );
                }

              }
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildMenuButton(MenuInfo currentMenuInfo){
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget child) {
        return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(32))),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
          color: currentMenuInfo.menuType == value.menuType

              ? CustomColors.menuBackgroundColor:  Colors.transparent,
          onPressed: () {

              var menuInfo = Provider.of<MenuInfo>(context, listen: false);
              menuInfo.updateMenu(currentMenuInfo);
              print(menuInfo.title);



          },
          child: Column(
            children: <Widget>[
              Hero(
                tag:'logo',

                child: Image.asset(
                  currentMenuInfo.imageSource,
                  scale: 1.5,
                ),
              ),
              SizedBox(height: 16),
              Text(
                currentMenuInfo.title ?? '',
                style: TextStyle(
                    fontFamily: 'avenir',
                    color: CustomColors.primaryTextColor,
                    fontSize: 14),
              ),
            ],
          ),
        );
      },
    );

}
