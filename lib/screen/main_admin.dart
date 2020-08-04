import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tksmart/screen/home.dart';
import 'package:tksmart/utility/my_style.dart';
import 'package:tksmart/utility/signout_process.dart';
import 'package:tksmart/widget/show_list_admin_all.dart';

class MainAdmin extends StatefulWidget {
  @override
  _MainAdminState createState() => _MainAdminState();
}

class _MainAdminState extends State<MainAdmin> {
  String nameUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('Name');
      print('nameUser = $nameUser');
    });
  }

  Widget currentWidget = ShowListAdminAll();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameUser == null ? 'Main Admin' : 'สวัสดีคุณ $nameUser'),
      ),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }

  Drawer showDrawer() => Drawer(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                showHead(),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('หน้าแรก'),
                  subtitle: Text('แสดงรายการหน้าแรก'),
                  onTap: () {
                    setState(() {
                      currentWidget = ShowListAdminAll();
                    });
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                menuSignOut(),
              ],
            )
          ],
        ),
      );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxDecoration('user.jpg'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text(
        nameUser == null ? 'Name Login' : nameUser,
        style: TextStyle(color: MyStyle().darkColor),
      ),
      accountEmail: Text(
        'Login',
        style: TextStyle(color: MyStyle().primaryColor),
      ),
    );
  }

  Widget menuSignOut() {
    return Container(
      decoration: BoxDecoration(color: Colors.red.shade700),
      child: ListTile(
        onTap: () => signOutProcess(context),
        leading: Icon(
          Icons.exit_to_app,
          color: Colors.white,
        ),
        title: Text(
          'Sign Out',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          'ออกจากระบบ',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
