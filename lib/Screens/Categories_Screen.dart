import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pill_reminder/Screens/home_Screen.dart';
import '../Data_Standard/Data_Standard_All.dart';
import '../Database/Database_Helper.dart';
import '../Database/Insert_Data.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _Categories();
}

class _Categories extends State<Categories> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      // ไปหน้าฐานข้อมูลยา
      Get.to(() => Categories()); // ตรวจสอบว่า Categories import มาจากไหน
    } else if (index == 1) {
      // หน้า HomePage (ไม่ต้องเปลี่ยนอะไร)
      Get.to(() => HomePage()); // หากต้องการเปลี่ยนกลับไปหน้า HomePage
    } else if (index == 2) {
      // ไปหน้าข้อมูลผู้ใช้
      // Get.to(() => UserProfileScreen()); // ตรวจสอบว่า UserProfileScreen import ถูกต้องหรือไม่
    }
  }

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
        automaticallyImplyLeading: false,
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
                        List<Map<String, dynamic>> data = snapshot.data!;

                        return DataTable(
                          columns: _buildColumnsForTable(
                              pang_s[pang_id]), // ✅ ใช้ฟังก์ชันกำหนดคอลัมน์
                          rows: data.map<DataRow>((item) {
                            return DataRow(
                              cells: _buildCellsForTable(
                                  context,
                                  pang_s[pang_id],
                                  item), // ✅ ส่ง context เข้าไป
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[300],
        backgroundColor: const Color.fromARGB(255, 73, 91, 227),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          _onItemTapped(index); // เรียกฟังก์ชันในคลาสเดียวกัน
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services, size: 35),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 35),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 35),
            label: "",
          ),
        ],
      ),
    );
  }
}

List<DataColumn> _buildColumnsForTable(String tableName) {
  switch (tableName) {
    case 'd_categories':
      return const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Name TH')),
        DataColumn(label: Text('Name EN')),
      ];
    case 'd_medications':
      return const [
        DataColumn(label: SizedBox(width: 40, child: Text('ID'))),
        DataColumn(label: SizedBox(width: 120, child: Text('Name TH'))),
        DataColumn(label: SizedBox(width: 120, child: Text('Name EN'))),
      ];
    case 'd_unit':
      return const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Unit TH')),
        DataColumn(label: Text('Unit EN')),
      ];
    case 'd_user':
      return const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Name TH')),
        DataColumn(label: Text('Action')),
      ];
    case 'medication_schedule':
      return const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Status')),
      ];
    default:
      return const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Data')),
      ];
  }
}

List<DataCell> _buildCellsForTable(
    BuildContext context, String tableName, Map<String, dynamic> item) {
  switch (tableName) {
    case 'd_categories':
      return [
        DataCell(Text(item['id']?.toString() ?? '-')),
        DataCell(Text(item['name_th'] ?? '-')),
        DataCell(Text(item['name_en'] ?? '-')),
      ];
    case 'd_medications':
      return [
        DataCell(
            SizedBox(width: 40, child: Text(item['id']?.toString() ?? '-'))),
        DataCell(SizedBox(
          width: 120, // ปรับความกว้าง
          child: Text(item['name_th'] ?? '-', overflow: TextOverflow.ellipsis),
        )),
        DataCell(SizedBox(
          width: 120, // ปรับความกว้าง
          child: Text(item['name_en'] ?? '-', overflow: TextOverflow.ellipsis),
        )),
      ];
    case 'd_unit':
      return [
        DataCell(Text(item['id']?.toString() ?? '-')),
        DataCell(Text(item['unit_th'] ?? '-')),
        DataCell(Text(item['unit_en'] ?? '-')),
      ];
    case 'd_user':
      return [
        DataCell(Text(item['id']?.toString() ?? '-')),
        DataCell(Text(item['name_th'] ?? '-')),
        DataCell(
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _showUserDetail(context, item); // ✅ ใช้ context ที่ส่งมา
            },
          ),
        ),
      ];
    case 'medication_schedule':
      return [
        DataCell(Text(item['id']?.toString() ?? '-')),
        DataCell(Text(item['date'] ?? '-')),
        DataCell(Text(item['status'] ?? '-')),
      ];
    default:
      return [
        DataCell(Text(item['id']?.toString() ?? '-')),
        DataCell(Text(item.toString())),
      ];
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
