import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          duration: const Duration(milliseconds: 650),
          curve: Curves.decelerate,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Container(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width/12,
                ),
                SizedBox(height: 10,),
                Text('Israel Getahun'),
                SizedBox(height: 4,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.white
                  ),
                  height: 20,
                  width: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.star,size: 18,),
                      Text('4.6'),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
        CustomListTile(frontIcon: Icons.person,text: 'Profile'),
        Divider(color: Colors.black45,height: 4,),
        CustomListTile(frontIcon: Icons.attach_money,text: 'Earning'),
        Divider(color: Colors.black45,height: 4,),
        CustomListTile(frontIcon: Icons.settings,text: 'Settings'),
        Divider(color: Colors.black45,height: 4,),
        CustomListTile(frontIcon: Icons.notifications,text: 'notification'),
        Divider(color: Colors.black45,height: 4,),
        CustomListTile(frontIcon: Icons.help_outline,text: 'Help'),
        Divider(color: Colors.black45,height: 4,),
        CustomListTile(frontIcon: Icons.exit_to_app,text: 'Logout'),
        Divider(color: Colors.black45,height: 4,),




      ],
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData frontIcon;
  final String text;

  CustomListTile({this.frontIcon,this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 0),
      child: InkWell(
        splashColor: Colors.blueAccent,
        onTap: null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
          children: [
            Container(
              height: 50.0,
              child: Row(
                children: [
                  Icon(frontIcon),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('$text')),
                ],
              ),
            ),
            Icon(Icons.arrow_right)
          ],
        ),
      ),
    );
  }
}
