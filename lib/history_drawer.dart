import 'package:flutter/material.dart';
import 'database_helper.dart';

class HistoryDrawer extends StatelessWidget {
  final double drawerwidth;
  const HistoryDrawer({Key? key, required this.drawerwidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      width: drawerwidth,
      child: FutureBuilder<List<Map<String, String>>>(
        future: DatabaseHelper().getHistory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              reverse: true,
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(snapshot.data![index].toString()),
                  onDismissed: (direction) {
                    if (snapshot.data != null) {
                      DatabaseHelper().deleteUser(
                          snapshot.data![index]['equation'].toString());
                    }
                  },
                  child: ListTile(
                    title: Text(snapshot.data?[index]['equation'] ?? ''),
                    subtitle: Text(
                      snapshot.data?[index]['result'] ?? '',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
