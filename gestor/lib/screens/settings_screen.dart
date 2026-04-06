import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../providers/theme_provider.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final c = context.colors;

    return Scaffold(
      backgroundColor: c.bg,
      appBar: AppBar(
        backgroundColor: c.surface,
        elevation: 0,
        title: Text(
          'Ajustes',
          style: TextStyle(
            color: c.prim,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'APARIENCIA',
            style: TextStyle(
              color: c.sec,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: c.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: c.div),
            ),
            child: Column(
              children: [
                _buildThemeOption(
                  context: context,
                  label: 'Modo del Sistema',
                  icon: LineAwesomeIcons.mobile_solid,
                  mode: ThemeMode.system,
                  currentMode: themeProvider.themeMode,
                  onTap: () => themeProvider.toggleTheme(ThemeMode.system),
                ),
                Divider(height: 1, color: c.div),
                _buildThemeOption(
                  context: context,
                  label: 'Modo Claro',
                  icon: LineAwesomeIcons.sun,
                  mode: ThemeMode.light,
                  currentMode: themeProvider.themeMode,
                  onTap: () => themeProvider.toggleTheme(ThemeMode.light),
                ),
                Divider(height: 1, color: c.div),
                _buildThemeOption(
                  context: context,
                  label: 'Modo Oscuro',
                  icon: LineAwesomeIcons.moon,
                  mode: ThemeMode.dark,
                  currentMode: themeProvider.themeMode,
                  onTap: () => themeProvider.toggleTheme(ThemeMode.dark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption({
    required BuildContext context,
    required String label,
    required IconData icon,
    required ThemeMode mode,
    required ThemeMode currentMode,
    required VoidCallback onTap,
  }) {
    final c = context.colors;
    final isSelected = mode == currentMode;

    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: isSelected ? c.accent : c.sec),
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? c.accent : c.prim,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      trailing: isSelected
          ? Icon(LineAwesomeIcons.check_solid, color: c.accent)
          : null,
    );
  }
}
