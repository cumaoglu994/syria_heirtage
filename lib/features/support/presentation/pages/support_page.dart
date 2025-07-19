import 'package:flutter/material.dart';
import '../../../../core/config/app_config.dart';

/// Support and contact page
class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'all';

  final List<Map<String, dynamic>> _faqs = [
    {
      'id': '1',
      'question': 'كيف يمكنني حجز رحلة سياحية؟',
      'answer':
          'يمكنك حجز رحلة سياحية من خلال صفحة الباقات والعروض، اختر الرحلة المناسبة واضغط على "احجز الآن"',
      'category': 'booking',
    },
    {
      'id': '2',
      'question': 'هل التطبيق يعمل بدون إنترنت؟',
      'answer': 'نعم، يمكنك تحميل الدليل الصوتي والخرائط للاستخدام دون إنترنت',
      'category': 'offline',
    },
    {
      'id': '3',
      'question': 'كيف يمكنني تغيير اللغة؟',
      'answer': 'اذهب إلى الإعدادات > اللغة واختر اللغة المفضلة لديك',
      'category': 'settings',
    },
    {
      'id': '4',
      'question': 'هل التطبيق مجاني؟',
      'answer': 'نعم، التطبيق مجاني بالكامل مع بعض الميزات المدفوعة الاختيارية',
      'category': 'pricing',
    },
    {
      'id': '5',
      'question': 'كيف يمكنني الإبلاغ عن مشكلة؟',
      'answer':
          'يمكنك الإبلاغ عن المشاكل من خلال صفحة الدعم أو إرسال بريد إلكتروني',
      'category': 'reporting',
    },
  ];

  final List<Map<String, dynamic>> _supportCategories = [
    {
      'id': 'all',
      'name': 'الكل',
      'icon': Icons.all_inclusive,
      'color': AppConfig.primaryColor,
    },
    {
      'id': 'booking',
      'name': 'الحجز',
      'icon': Icons.book_online,
      'color': AppConfig.syrianGreen,
    },
    {
      'id': 'technical',
      'name': 'تقني',
      'icon': Icons.phone_android,
      'color': AppConfig.syrianRed,
    },
    {
      'id': 'payment',
      'name': 'الدفع',
      'icon': Icons.payment,
      'color': AppConfig.syrianGold,
    },
    {
      'id': 'account',
      'name': 'الحساب',
      'icon': Icons.person,
      'color': AppConfig.accentColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدعم والمساعدة'),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: AppConfig.syrianWhite,
      ),
      body: Column(
        children: [
          // شريط البحث
          Padding(
            padding: const EdgeInsets.all(AppConfig.spacingM),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'ابحث في الأسئلة الشائعة...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _searchController.clear(),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConfig.radiusL),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          // التصنيفات
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppConfig.spacingM,
              ),
              itemCount: _supportCategories.length,
              itemBuilder: (context, index) {
                final category = _supportCategories[index];
                final isSelected = _selectedCategory == category['id'];
                return Padding(
                  padding: const EdgeInsets.only(right: AppConfig.spacingM),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category['id'];
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? category['color']
                                : category['color'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              AppConfig.radiusL,
                            ),
                            border: isSelected
                                ? Border.all(color: category['color'], width: 2)
                                : null,
                          ),
                          child: Icon(
                            category['icon'],
                            color: isSelected
                                ? AppConfig.syrianWhite
                                : category['color'],
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category['name'],
                          style: AppConfig.caption.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // خيارات الدعم السريع
          Container(
            padding: const EdgeInsets.all(AppConfig.spacingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الدعم السريع',
                  style: AppConfig.heading3.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppConfig.spacingM),
                Row(
                  children: [
                    Expanded(
                      child: _QuickSupportCard(
                        icon: Icons.chat,
                        title: 'دردشة مباشرة',
                        subtitle: 'تحدث مع فريق الدعم',
                        color: AppConfig.syrianGreen,
                        onTap: () => _openLiveChat(),
                      ),
                    ),
                    const SizedBox(width: AppConfig.spacingM),
                    Expanded(
                      child: _QuickSupportCard(
                        icon: Icons.email,
                        title: 'إرسال بريد',
                        subtitle: 'راسلنا عبر البريد الإلكتروني',
                        color: AppConfig.primaryColor,
                        onTap: () => _sendEmail(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConfig.spacingM),
                Row(
                  children: [
                    Expanded(
                      child: _QuickSupportCard(
                        icon: Icons.phone,
                        title: 'اتصال هاتفي',
                        subtitle: 'اتصل بفريق الدعم',
                        color: AppConfig.syrianRed,
                        onTap: () => _makePhoneCall(),
                      ),
                    ),
                    const SizedBox(width: AppConfig.spacingM),
                    Expanded(
                      child: _QuickSupportCard(
                        icon: Icons.bug_report,
                        title: 'إبلاغ عن مشكلة',
                        subtitle: 'أبلغ عن خطأ أو مشكلة',
                        color: AppConfig.syrianGold,
                        onTap: () => _reportIssue(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // الأسئلة الشائعة
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(AppConfig.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الأسئلة الشائعة',
                    style: AppConfig.heading3.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConfig.spacingM),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _getFilteredFAQs().length,
                      itemBuilder: (context, index) {
                        final faq = _getFilteredFAQs()[index];
                        return _FAQCard(faq: faq);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredFAQs() {
    var filtered = _faqs;

    if (_selectedCategory != 'all') {
      filtered = filtered
          .where((faq) => faq['category'] == _selectedCategory)
          .toList();
    }

    if (_searchController.text.isNotEmpty) {
      filtered = filtered.where((faq) {
        return faq['question'].toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ) ||
            faq['answer'].toLowerCase().contains(
              _searchController.text.toLowerCase(),
            );
      }).toList();
    }

    return filtered;
  }

  void _openLiveChat() {
    // TODO: فتح الدردشة المباشرة
    _showSupportDialog(
      'الدردشة المباشرة',
      'سيتم فتح الدردشة المباشرة قريباً...',
    );
  }

  void _sendEmail() {
    // TODO: فتح تطبيق البريد الإلكتروني
    _showSupportDialog(
      'إرسال بريد إلكتروني',
      'سيتم فتح تطبيق البريد الإلكتروني...',
    );
  }

  void _makePhoneCall() {
    // TODO: إجراء مكالمة هاتفية
    _showSupportDialog('اتصال هاتفي', 'سيتم الاتصال بفريق الدعم...');
  }

  void _reportIssue() {
    // TODO: فتح نموذج الإبلاغ عن المشكلة
    _showSupportDialog(
      'إبلاغ عن مشكلة',
      'سيتم فتح نموذج الإبلاغ عن المشكلة...',
    );
  }

  void _showSupportDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConfig.primaryColor,
              foregroundColor: AppConfig.syrianWhite,
            ),
            child: const Text('موافق'),
          ),
        ],
      ),
    );
  }
}

class _QuickSupportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _QuickSupportCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusL),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConfig.radiusL),
        child: Padding(
          padding: const EdgeInsets.all(AppConfig.spacingM),
          child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConfig.radiusL),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: AppConfig.spacingS),
              Text(
                title,
                style: AppConfig.body1.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: AppConfig.caption.copyWith(
                  color: AppConfig.textSecondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FAQCard extends StatefulWidget {
  final Map<String, dynamic> faq;

  const _FAQCard({required this.faq});

  @override
  State<_FAQCard> createState() => _FAQCardState();
}

class _FAQCardState extends State<_FAQCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConfig.spacingM),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusL),
      ),
      child: ExpansionTile(
        title: Text(
          widget.faq['question'],
          style: AppConfig.body1.copyWith(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConfig.spacingM),
            child: Text(widget.faq['answer'], style: AppConfig.body1),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConfig.spacingM),
            child: Row(
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.thumb_up),
                  label: const Text('مفيد'),
                  onPressed: () {
                    // TODO: تسجيل أن السؤال مفيد
                  },
                ),
                const Spacer(),
                TextButton.icon(
                  icon: const Icon(Icons.thumb_down),
                  label: const Text('غير مفيد'),
                  onPressed: () {
                    // TODO: تسجيل أن السؤال غير مفيد
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
