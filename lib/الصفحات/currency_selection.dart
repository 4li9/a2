import 'package:flutter/material.dart';

class CurrencySelection extends StatelessWidget {
  final List<Map<String, String>> currencies = [
    {'name': 'الدرهم الإماراتي', 'description': 'العملة المحلية.'},
    {'name': 'الدينار الأردني', 'description': ''},
    {'name': 'الدينار البحريني', 'description': ''},
    {'name': 'الدينار العراقي', 'description': ''},
    {'name': 'الدينار الكويتي', 'description': ''},
    {'name': 'الريال الإيراني', 'description': ''},
    {'name': 'الريال السعودي', 'description': ''},
    {'name': 'الريال العماني', 'description': ''},
    {'name': 'الريال القطري', 'description': ''},
    {'name': 'الريال اليمني', 'description': ''},
    {'name': 'الشيكل الإسرائيلي', 'description': ''},
    {'name': 'الليرة السورية', 'description': ''},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اختر العملة'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // الرجوع
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // تفعيل خاصية البحث
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: currencies.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(currencies[index]['name']!),
            subtitle: currencies[index]['description']!.isNotEmpty
                ? Text(currencies[index]['description']!)
                : null,
          );
        },
      ),
    );
  }
}
