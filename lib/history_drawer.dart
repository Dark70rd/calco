import 'package:flutter/material.dart';
import 'database_helper.dart';

class HistoryDrawer extends StatefulWidget {
  final double drawerwidth;
  const HistoryDrawer({Key? key, required this.drawerwidth}) : super(key: key);

  @override
  State<HistoryDrawer> createState() => _HistoryDrawerState();
}

class _HistoryDrawerState extends State<HistoryDrawer> {
  late Future<List<Map<String, String>>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = DatabaseHelper().getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: widget.drawerwidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 40,
            //width: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 10),
                  iconSize: MediaQuery.of(context).size.width * 0.09,
                  onPressed: () async {
                    await DatabaseHelper().deleteAllUsers();
                    setState(() {
                      _historyFuture = DatabaseHelper().getHistory();
                    });
                  },
                  icon: Icon(Icons.delete_forever_outlined),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, String>>>(
              future: DatabaseHelper().getHistory(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    reverse: true,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          snapshot.data?[index]['equation'] ?? '',
                          style: const TextStyle(fontSize: 25),
                        ),
                        subtitle: SelectableText(
                          snapshot.data?[index]['result'] ?? '',
                          style: const TextStyle(fontSize: 30),
                        ),
                      );
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


//outdated code
////  return Dismissible(
//           key: Key(snapshot.data![index].toString()),
//                   onDismissed: (direction) {
//                    if (snapshot.data != null) {
//                       DatabaseHelper().deleteUser(
//                            snapshot.data![index]['equation'].toString());
//                        }
//                      },