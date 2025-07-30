import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ryot'),
          bottom: TabBar(
            tabs: [
              Tab(child: Text('Movies')),
              Tab(child: Text('Shows')),
              Tab(child: Text('Anime')),
              Tab(child: Text('Manga')),
              Tab(child: Text('Books')),
              // TODO: add tabs progamatically based on user preferences
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Row(
                  spacing: 20.0,
                  children: [
                    CircleAvatar(
                      radius: 48,
                      foregroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSF5EmOMKXYngYyAbipAejzp-ikfYw4PmDH0g&s',
                      ),
                    ),
                    Text(
                      'Username',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Movies')),
            Center(child: Text('Shows')),
            Center(child: Text('Animes')),
            Center(child: Text('Mangas')),
            Center(child: Text('Books')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
