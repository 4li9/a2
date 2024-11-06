import 'package:a2/%D9%88%D8%AD%D8%AF%D9%87%20%D8%A7%D9%84%D8%AA%D8%AD%D9%83%D9%85/settinge_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settinge extends StatefulWidget {
  @override
  _SettingeState createState() => _SettingeState();
}

class _SettingeState extends State<Settinge> {
  bool isSmallAlertEnabled = true; // هذا يتحكم في حالة الـ Checkbox

  @override
  Widget build(BuildContext context) {
    settingeControllerimp controller = Get.put(settingeControllerimp());

    return Scaffold(
      appBar: AppBar(
        title: Text('الإعدادات'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildButton(
            context,
            icon: Icons.monetization_on,
            title: 'اختر العملة',
            subtitle: 'يجري الآن التعرف على الجنيه المصري.',
            onTap: () {
              controller
                  .goToCurrencySelection(); // هنا يمكنك إضافة انتقال لصفحة اختيار العملة
            },
          ),
          _buildButton(
            context,
            icon: Icons.upgrade,
            title: 'الاشتراك في الإصدار الكامل',
            subtitle:
                'أنت الآن تستخدم الإصدار المجاني... الرجاء اختيار الخطة المناسبة للترقية.',
            onTap: () {
              // يمكنك الانتقال إلى صفحة الاشتراك هنا
            },
          ),
          _buildButton(
            context,
            icon: Icons.vibration,
            title: 'إعدادات الاهتزازات',
            onTap: () {
              // يمكنك الانتقال إلى صفحة إعدادات الاهتزازات
            },
          ),
          _buildButton(
            context,
            icon: Icons.volume_up,
            title: 'نمط التعرف على العملات',
            subtitle: 'القيمة والعملة معاً',
            onTap: () {
              // يمكنك الانتقال إلى صفحة نمط التعرف على العملات
            },
          ),
          _buildCheckboxTile(
            title: 'إصدار صغير عند التعرف على العملات',
            subtitle: 'إذا لم تكن متأكدًا من أن التطبيق نشط...',
            value: isSmallAlertEnabled,
            onChanged: (bool newValue) {
              setState(() {
                isSmallAlertEnabled = newValue;
              });
            },
          ),
          _buildButton(
            context,
            icon: Icons.flash_on,
            title: 'الفلاش',
            subtitle: 'يتم تحسين عملية التعرف على العملات عند تمكين الفلاش.',
            onTap: () {
              // يمكنك الانتقال إلى صفحة إعدادات الفلاش
            },
          ),
          _buildButton(
            context,
            icon: Icons.switch_camera,
            title: 'التبديل بين الكاميرا الخلفية والأمامية',
            subtitle: 'استخدام الكاميرا الخلفية.',
            onTap: () {
              // يمكنك الانتقال إلى صفحة تبديل الكاميرات
            },
          ),
          _buildButton(
            context,
            icon: Icons.image,
            title: 'أرسل لنا صورة للمعاينة',
            subtitle:
                'يمكنك تفعيل زر في الشاشة الرئيسية لإرسال صور بشكل تلقائي...',
            onTap: () {
              // يمكنك الانتقال إلى صفحة إرسال الصور
            },
          ),
        ],
      ),
    );
  }

  // دالة لإنشاء زر مع الأيقونة والعنوان والوصف (إذا كان موجودًا)
  Widget _buildButton(BuildContext context,
      {required IconData icon,
      required String title,
      String? subtitle,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(16.0),
            backgroundColor: Colors.white, // خلفية بيضاء
            elevation: 0, // بدون ظل
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 28, color: Colors.black), // أيقونة
              SizedBox(width: 16), // مسافة بين الأيقونة والنص
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة لإنشاء مربع اختيار مع محاذاة صحيحة للغة العربية (RTL)
  Widget _buildCheckboxTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: CheckboxListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          value: value,
          onChanged: (bool? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.green,
        ),
      ),
    );
  }
}
