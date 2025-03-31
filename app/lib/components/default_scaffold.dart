import 'package:flutter/material.dart';
import 'package:shoprite/constants/colors.dart';

class DefaultScaffold extends StatelessWidget {
  const DefaultScaffold({
    super.key,
    required this.body,
    this.appBarTitle,
  });

  final Widget body;
  final Widget? appBarTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(
        children: [Text("hi")],
      ),
      appBar: appBarTitle != null
          ? AppBar(
              title: appBarTitle,
              centerTitle: true,
              leading: Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                );
              }),
              titleTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: body,
        ),
      ),
    );
  }
}
