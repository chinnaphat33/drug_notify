import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../Data_Standard/Data_Standard_All.dart';
import '../Database/Database_Helper.dart';
import '../Database/Insert_Data.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _Categories();
}

class _Categories extends State<Categories> {
  @override
  void initState() {
    super.initState();
    // DatabaseHelper.instance.deleteDatabase_tabel();
  }

  // Method to insert data into the database
  void _insertData() async {
    DataStandardAll dataStandardAll = DataStandardAll();
    (pang_id == 0)
        ? dataStandardAll.Data_category()
        : (pang_id == 1)
            ? dataStandardAll.Data_medications()
            : (pang_id == 2)
                ? dataStandardAll.Data_unit()
                : (pang_id == 3)
                    ? dataStandardAll.Data_user()
                    : dataStandardAll.Data_medication_schedule();
  }

  int pang_id = 0;
  List pang_s = [
    'd_categories',
    'd_medications',
    'd_unit',
    'd_user',
    'medication_schedule',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text('Database Example'),
  actions: [
    IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () async {
  Database db = await DatabaseHelper.instance.database;
  await DatabaseHelper.instance.dropAndRecreateUserTable(db); 
  setState(() {
    // รีเฟรชหน้าจอหลังจากลบตาราง
  });
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Table d_user has been reset')),
  );
},

    ),
  ],
),
      body: Column(
        children: [
          SizedBox(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              }),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int index = 0; index < pang_s.length; index++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              pang_id = index;
                            });
                          },
                          child: Container(
                              color: Colors.cyan,
                              padding: const EdgeInsets.all(2.0),
                              child: Text('${pang_s[index]}')),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
           Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StreamBuilder(
                    stream: DatabaseHelper.instance
                        .getDataStream('${pang_s[pang_id]}'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DataTable(
                          columns: [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('Name TH')),
                            DataColumn(label: Text('Action')),
                          ],
                          rows: snapshot.data!.map<DataRow>((item) {
                            return DataRow(
                              cells: [
                                DataCell(Text(item['id']?.toString() ?? '-')),
                                DataCell(Text(item['name_th'] ?? '-')),
                                DataCell(
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      _showUserDetail(context, item);
                                    },
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Add a FloatingActionButton to insert data
      floatingActionButton: FloatingActionButton(
        onPressed: _insertData,
        child: const Icon(Icons.add),
      ),
    );
  }
}
void _showUserDetail(BuildContext context, Map<String, dynamic> userData) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: userData.entries.map<Widget>((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${entry.key}: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(entry.value?.toString() ?? '-'),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
