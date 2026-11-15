import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../services/ai/ai_provider_type.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.currentTheme,
    required this.onThemeChanged,
  });

  final ThemeMode currentTheme;
  final ValueChanged<ThemeMode> onThemeChanged;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const _storage = FlutterSecureStorage();
  final _keyController = TextEditingController();
  AiProviderType _provider = AiProviderType.openAiCompatible;
  bool _loading = true;
  bool _obscure = true;
  bool _hasSavedKey = false;

  @override
  void initState() {
    super.initState();
    _loadKeyStatus();
  }

  Future<void> _loadKeyStatus() async {
    final key = await _storage.read(key: 'ai_api_key');
    if (!mounted) return;
    setState(() {
      _hasSavedKey = key != null && key.isNotEmpty;
      _loading = false;
    });
  }

  Future<void> _saveKey() async {
    final value = _keyController.text.trim();
    if (value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('أدخل مفتاح API أولاً')),
      );
      return;
    }
    await _storage.write(key: 'ai_api_key', value: value);
    if (!mounted) return;
    setState(() => _hasSavedKey = true);
    _keyController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حفظ المفتاح في التخزين الآمن على الجهاز.')),
    );
  }

  Future<void> _deleteKey() async {
    await _storage.delete(key: 'ai_api_key');
    if (!mounted) return;
    setState(() => _hasSavedKey = false);
  }

  @override
  void dispose() {
    _keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('المظهر', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          DropdownButtonFormField<ThemeMode>(
            value: widget.currentTheme,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: const [
              DropdownMenuItem(value: ThemeMode.system, child: Text('حسب إعدادات الجهاز')),
              DropdownMenuItem(value: ThemeMode.light, child: Text('فاتح')),
              DropdownMenuItem(value: ThemeMode.dark, child: Text('داكن')),
            ],
            onChanged: (value) {
              if (value != null) widget.onThemeChanged(value);
            },
          ),
          const SizedBox(height: 28),
          Text('مزود الذكاء الاصطناعي', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          DropdownButtonFormField<AiProviderType>(
            value: _provider,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: AiProviderType.values.map((p) {
              return DropdownMenuItem(value: p, child: Text(p.label));
            }).toList(),
            onChanged: (value) {
              if (value != null) setState(() => _provider = value);
            },
          ),
          const SizedBox(height: 24),
          Text('مفتاح API', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _keyController,
            obscureText: _obscure,
            decoration: InputDecoration(
              hintText: 'ألصق مفتاح API هنا',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
              ),
            ),
          ),
          const SizedBox(height: 10),
          FilledButton.icon(
            onPressed: _saveKey,
            icon: const Icon(Icons.save_outlined),
            label: const Text('حفظ المفتاح بأمان'),
          ),
          const SizedBox(height: 8),
          if (_loading)
            const LinearProgressIndicator()
          else
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(_hasSavedKey ? Icons.verified_user : Icons.info_outline),
              title: Text(_hasSavedKey ? 'يوجد مفتاح محفوظ على هذا الجهاز' : 'لا يوجد مفتاح محفوظ'),
              trailing: _hasSavedKey
                  ? TextButton(onPressed: _deleteKey, child: const Text('حذف'))
                  : null,
            ),
          const SizedBox(height: 12),
          const Text(
            'تنبيه: المفتاح محفوظ محلياً في التخزين الآمن. لا تشاركه ولا ترفعه إلى GitHub. '
            'الاتصال المباشر بمزود خارجي يعني أن نص السؤال والمقاطع التي تختار إرسالها ستغادر الجهاز.',
          ),
        ],
      ),
    );
  }
}
