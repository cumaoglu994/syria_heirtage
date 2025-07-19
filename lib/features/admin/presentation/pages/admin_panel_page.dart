import 'package:flutter/material.dart';
import '../../../../core/config/app_config.dart';

/// Admin panel for Ministry of Tourism
class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({super.key});

  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _statistics = [
    {
      'title': 'إجمالي المستخدمين',
      'value': '12,847',
      'change': '+15%',
      'isPositive': true,
      'icon': Icons.people,
      'color': AppConfig.primaryColor,
    },
    {
      'title': 'الرحلات المحجوزة',
      'value': '3,421',
      'change': '+8%',
      'isPositive': true,
      'icon': Icons.flight,
      'color': AppConfig.syrianGreen,
    },
    {
      'title': 'الإيرادات',
      'value': '\$45,230',
      'change': '+12%',
      'isPositive': true,
      'icon': Icons.attach_money,
      'color': AppConfig.syrianGold,
    },
    {
      'title': 'التقييمات',
      'value': '4.8/5',
      'change': '+0.2',
      'isPositive': true,
      'icon': Icons.star,
      'color': AppConfig.syrianRed,
    },
  ];

  final List<Map<String, dynamic>> _recentActivities = [
    {
      'id': '1',
      'type': 'user_registration',
      'title': 'مستخدم جديد',
      'description': 'أحمد محمد سجل في التطبيق',
      'timestamp': '2 دقيقة',
      'icon': Icons.person_add,
      'color': AppConfig.primaryColor,
    },
    {
      'id': '2',
      'type': 'booking',
      'title': 'حجز جديد',
      'description': 'رحلة دمشق - تدمر تم حجزها',
      'timestamp': '15 دقيقة',
      'icon': Icons.book_online,
      'color': AppConfig.syrianGreen,
    },
    {
      'id': '3',
      'type': 'review',
      'title': 'تقييم جديد',
      'description': 'تقييم 5 نجوم لقلعة الحصن',
      'timestamp': '1 ساعة',
      'icon': Icons.star,
      'color': AppConfig.syrianGold,
    },
    {
      'id': '4',
      'type': 'content',
      'title': 'محتوى جديد',
      'description': 'تم إضافة دليل صوتي جديد',
      'timestamp': '3 ساعة',
      'icon': Icons.headphones,
      'color': AppConfig.accentColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة الإدارة'),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: AppConfig.syrianWhite,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: عرض الإشعارات
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: فتح الإعدادات
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // التبويبات
          Container(
            decoration: BoxDecoration(
              color: AppConfig.backgroundColor,
              border: Border(
                bottom: BorderSide(
                  color: AppConfig.primaryColor.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _AdminTabButton(
                    icon: Icons.dashboard,
                    title: 'الرئيسية',
                    isSelected: _selectedTab == 0,
                    onTap: () => _selectTab(0),
                  ),
                ),
                Expanded(
                  child: _AdminTabButton(
                    icon: Icons.content_paste,
                    title: 'المحتوى',
                    isSelected: _selectedTab == 1,
                    onTap: () => _selectTab(1),
                  ),
                ),
                Expanded(
                  child: _AdminTabButton(
                    icon: Icons.people,
                    title: 'المستخدمين',
                    isSelected: _selectedTab == 2,
                    onTap: () => _selectTab(2),
                  ),
                ),
                Expanded(
                  child: _AdminTabButton(
                    icon: Icons.analytics,
                    title: 'التقارير',
                    isSelected: _selectedTab == 3,
                    onTap: () => _selectTab(3),
                  ),
                ),
              ],
            ),
          ),
          // محتوى التبويبات
          Expanded(
            child: IndexedStack(
              index: _selectedTab,
              children: [
                _DashboardTab(),
                _ContentTab(),
                _UsersTab(),
                _ReportsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _selectTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }
}

class _AdminTabButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _AdminTabButton({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppConfig.spacingM),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppConfig.primaryColor : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppConfig.primaryColor
                  : AppConfig.textSecondaryColor,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: AppConfig.caption.copyWith(
                color: isSelected
                    ? AppConfig.primaryColor
                    : AppConfig.textSecondaryColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConfig.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الإحصائيات
          Text(
            'الإحصائيات العامة',
            style: AppConfig.heading2.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppConfig.spacingM),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppConfig.spacingM,
              mainAxisSpacing: AppConfig.spacingM,
              childAspectRatio: 1.5,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              final stat = [
                {
                  'title': 'إجمالي المستخدمين',
                  'value': '12,847',
                  'change': '+15%',
                  'isPositive': true,
                  'icon': Icons.people,
                  'color': AppConfig.primaryColor,
                },
                {
                  'title': 'الرحلات المحجوزة',
                  'value': '3,421',
                  'change': '+8%',
                  'isPositive': true,
                  'icon': Icons.flight,
                  'color': AppConfig.syrianGreen,
                },
                {
                  'title': 'الإيرادات',
                  'value': '\$45,230',
                  'change': '+12%',
                  'isPositive': true,
                  'icon': Icons.attach_money,
                  'color': AppConfig.syrianGold,
                },
                {
                  'title': 'التقييمات',
                  'value': '4.8/5',
                  'change': '+0.2',
                  'isPositive': true,
                  'icon': Icons.star,
                  'color': AppConfig.syrianRed,
                },
              ][index];
              return _StatCard(stat: stat);
            },
          ),
          const SizedBox(height: AppConfig.spacingL),
          // النشاطات الأخيرة
          Text(
            'النشاطات الأخيرة',
            style: AppConfig.heading2.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppConfig.spacingM),
          _RecentActivitiesList(),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final Map<String, dynamic> stat;

  const _StatCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConfig.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: stat['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConfig.radiusM),
                  ),
                  child: Icon(stat['icon'], color: stat['color'], size: 24),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConfig.spacingS,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: stat['isPositive']
                        ? AppConfig.syrianGreen.withOpacity(0.1)
                        : AppConfig.syrianRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConfig.radiusS),
                  ),
                  child: Text(
                    stat['change'],
                    style: AppConfig.caption.copyWith(
                      color: stat['isPositive']
                          ? AppConfig.syrianGreen
                          : AppConfig.syrianRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConfig.spacingM),
            Text(
              stat['value'],
              style: AppConfig.heading2.copyWith(
                fontWeight: FontWeight.bold,
                color: stat['color'],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              stat['title'],
              style: AppConfig.body2.copyWith(
                color: AppConfig.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentActivitiesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        'id': '1',
        'type': 'user_registration',
        'title': 'مستخدم جديد',
        'description': 'أحمد محمد سجل في التطبيق',
        'timestamp': '2 دقيقة',
        'icon': Icons.person_add,
        'color': AppConfig.primaryColor,
      },
      {
        'id': '2',
        'type': 'booking',
        'title': 'حجز جديد',
        'description': 'رحلة دمشق - تدمر تم حجزها',
        'timestamp': '15 دقيقة',
        'icon': Icons.book_online,
        'color': AppConfig.syrianGreen,
      },
      {
        'id': '3',
        'type': 'review',
        'title': 'تقييم جديد',
        'description': 'تقييم 5 نجوم لقلعة الحصن',
        'timestamp': '1 ساعة',
        'icon': Icons.star,
        'color': AppConfig.syrianGold,
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return _ActivityCard(activity: activity);
      },
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final Map<String, dynamic> activity;

  const _ActivityCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConfig.spacingM),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusL),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: activity['color'].withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConfig.radiusM),
          ),
          child: Icon(activity['icon'], color: activity['color'], size: 20),
        ),
        title: Text(
          activity['title'],
          style: AppConfig.body1.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(activity['description'], style: AppConfig.body2),
        trailing: Text(
          activity['timestamp'],
          style: AppConfig.caption.copyWith(
            color: AppConfig.textSecondaryColor,
          ),
        ),
      ),
    );
  }
}

class _ContentTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.content_paste, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('إدارة المحتوى'),
        ],
      ),
    );
  }
}

class _UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('إدارة المستخدمين'),
        ],
      ),
    );
  }
}

class _ReportsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.analytics, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('التقارير والإحصائيات'),
        ],
      ),
    );
  }
}
