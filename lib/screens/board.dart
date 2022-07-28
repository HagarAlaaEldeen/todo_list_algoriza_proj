import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/schedule");
          },
        ),
        appBar: AppBar(
          foregroundColor: Colors.white,
          elevation: 0.0,
          title: const Text(
            'Board',
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu_rounded,
                ))
          ],
          bottom: const TabBar(
              unselectedLabelColor: Colors.white70,
              labelColor: Colors.yellow,
              tabs: [
                Tab(text: "All", icon: Icon(Icons.list_alt)),
                Tab(text: "Done", icon: Icon(Icons.done)),
                Tab(
                    text: "Uncompleted",
                    icon: Icon(
                      Icons.warning,
                    )),
                Tab(text: "Favorite", icon: Icon(Icons.favorite)),
              ]),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Text("All"),
            ),
            Center(
              child: Text("Done"),
            ),
            Center(
              child: Text("Uncompleted"),
            ),
            Center(
              child: Text("Favorite"),
            ),
          ],
        ),
      ),
    );
  }
}
