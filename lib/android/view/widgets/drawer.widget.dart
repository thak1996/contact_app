import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/styles.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.arrow_back),
                ),
                Text('Menu')
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.home_outlined),
                      title: Text('Home'),
                      onTap: () => context.go('/home'),
                    ),
                    ListTile(
                      leading: Icon(Icons.contact_mail_outlined),
                      title: Text('Contact'),
                      onTap: () => context.push('/contact'),
                    ),
                    ListTile(
                      leading: Icon(Icons.post_add_outlined),
                      title: Text('Posts'),
                      onTap: () => context.push('/posts'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
