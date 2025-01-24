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
                    stream: (pang_id < 4)
                        ? DatabaseHelper.instance
                            .getDataStream('${pang_s[pang_id]}')
                        : DatabaseHelper.instance.getDataStream_JOIN(
                            'medication_schedule', 'd_medications'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DataTable(
                          columns: [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('Names')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('X')),
                          ],
                          rows: snapshot.data!.map((item) {
                            return DataRow(
                              cells: [
                                DataCell(Text(item['id'].toString() ??
                                    item['name_th'] ??
                                    item['unit_th'])),
                                DataCell(Text(item['name_th'] ??
                                    item['unit_th'])), // Handle null case
                                DataCell(Text(item['status'] ?? '-')),
                                DataCell(InkWell(
                                    onTap: () {
                                      DatabaseHelper.instance.deleteData(
                                          item['id'],
                                          (pang_id < 4)
                                              ? '${pang_s[pang_id]}'
                                              : 'medication_schedule');
                                    },
                                    child: Text('ลบ'))),
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
