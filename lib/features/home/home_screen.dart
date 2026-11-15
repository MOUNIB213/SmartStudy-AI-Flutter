import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onOpenSettings});

  final VoidCallback onOpenSettings;

  Future<void> _pickDocument(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'txt', 'jpg', 'jpeg', 'png'],
      allowMultiple: true,
      withData: false,
    );
    if (!context.mounted) return;
    if (result == null || result.files.isEmpty) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم اختيار ${result.files.length} ملف/ملفات.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartStudy AI', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            tooltip: 'الإعدادات',
            onPressed: onOpenSettings,
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.tertiary],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('مرحباً بك في مساعدك الدراسي',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('ارفع دروسك، نظّم مكتبتك، واستعد للتعلم بذكاء.',
                    style: TextStyle(color: Colors.white, height: 1.5)),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text('ماذا تريد أن تفعل؟',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _ActionTile(
            icon: Icons.upload_file_outlined,
            title: 'استيراد درس أو ملف',
            subtitle: 'PDF وDOCX وTXT والصور',
            onTap: () => _pickDocument(context),
          ),
          const _ActionTile(
            icon: Icons.document_scanner_outlined,
            title: 'تصوير درس',
            subtitle: 'سنضيف التصوير واستخراج النص في المرحلة التالية',
          ),
          const _ActionTile(
            icon: Icons.auto_awesome_outlined,
            title: 'إنشاء ملخص',
            subtitle: 'حوّل دروسك إلى نقاط مركزة',
          ),
          const _ActionTile(
            icon: Icons.account_tree_outlined,
            title: 'خريطة ذهنية',
            subtitle: 'نظّم المفاهيم والعلاقات بصرياً',
          ),
          const _ActionTile(
            icon: Icons.quiz_outlined,
            title: 'اختبارات وتمارين',
            subtitle: 'اختبر فهمك وتابع تقدمك',
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: onOpenSettings,
            icon: const Icon(Icons.key_outlined),
            label: const Text('إعدادات الذكاء الاصطناعي'),
          ),
          const SizedBox(height: 16),
          Text(
            'نسخة تأسيسية: اختيار الملفات والإعدادات والثيم يعملان. بقية الوحدات ستُبنى تدريجياً.',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_left),
      ),
    );
  }
}
