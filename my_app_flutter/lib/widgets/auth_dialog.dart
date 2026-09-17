import 'package:flutter/material.dart';
import '../theme/blog_theme.dart';

class UserSession {
  final String name;
  final String email;
  final String avatarUrl;
  final bool isAdmin;

  UserSession({
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.isAdmin,
  });
}

class AuthDialog extends StatefulWidget {
  final Function(UserSession session) onAuthenticated;

  const AuthDialog({super.key, required this.onAuthenticated});

  static Future<void> show(BuildContext context, {required Function(UserSession) onAuthenticated}) {
    return showDialog(
      context: context,
      builder: (context) => AuthDialog(onAuthenticated: onAuthenticated),
    );
  }

  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _avatarController = TextEditingController(text: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150');
  
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _avatarController.dispose();
    super.dispose();
  }

  void _handleSignIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password')),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 600));

    final isAdmin = email.contains('admin');
    final session = UserSession(
      name: email.split('@').first,
      email: email,
      avatarUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
      isAdmin: isAdmin,
    );

    setState(() => _isLoading = false);
    if (mounted) {
      Navigator.of(context).pop();
      widget.onAuthenticated(session);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome back, ${session.name}! ${session.isAdmin ? "(Admin)" : ""}')),
      );
    }
  }

  void _handleRegister() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 600));

    final session = UserSession(
      name: name,
      email: email,
      avatarUrl: _avatarController.text.trim().isNotEmpty 
          ? _avatarController.text.trim()
          : 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150',
      isAdmin: false,
    );

    setState(() => _isLoading = false);
    if (mounted) {
      Navigator.of(context).pop();
      widget.onAuthenticated(session);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account created successfully! Welcome, $name')),
      );
    }
  }

  void _handleQuickAdminLogin() {
    final session = UserSession(
      name: 'Admin Master',
      email: 'admin@apexblog.com',
      avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
      isAdmin: true,
    );
    Navigator.of(context).pop();
    widget.onAuthenticated(session);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signed in as Admin Administrator! Full access granted.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: isDark ? BlogTheme.darkCardBg : Colors.white,
      child: Container(
        width: 420,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header icon & title
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: BlogTheme.primaryViolet.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.lock_outline, color: BlogTheme.primaryViolet, size: 28),
            ),
            const SizedBox(height: 12),
            const Text(
              'Apex Blog Account',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Tab bar
            TabBar(
              controller: _tabController,
              labelColor: BlogTheme.primaryViolet,
              unselectedLabelColor: Colors.grey,
              indicatorColor: BlogTheme.primaryViolet,
              tabs: const [
                Tab(text: 'Sign In'),
                Tab(text: 'Register'),
              ],
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 280,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Sign In Tab
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _handleSignIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BlogTheme.primaryViolet,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: _isLoading 
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      const Spacer(),
                      OutlinedButton.icon(
                        onPressed: _handleQuickAdminLogin,
                        icon: const Icon(Icons.admin_panel_settings, color: BlogTheme.secondaryCyan),
                        label: const Text('Quick Sign In as Admin (Demo)', style: TextStyle(color: BlogTheme.secondaryCyan)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: BlogTheme.secondaryCyan),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ],
                  ),

                  // Register Tab
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                            prefixIcon: Icon(Icons.person_outline),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 14),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _handleRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BlogTheme.primaryViolet,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: _isLoading 
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : const Text('Create Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
