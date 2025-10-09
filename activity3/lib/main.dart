import 'package:flutter/material.dart';

void main() {
  runApp(const BikeRentalApp());
}

class BikeRentalApp extends StatelessWidget {
  const BikeRentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF0E7C7B),
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'Bike Rental',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFFF7FBFB),
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 1,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      home: const HomeIndexScreen(),
      routes: {
        UsernameFormScreen.route: (_) => const UsernameFormScreen(),
        LoginFormScreen.route: (_) => const LoginFormScreen(),
        RegistrationFormScreen.route: (_) => const RegistrationFormScreen(),
        MixedInputsScreen.route: (_) => const MixedInputsScreen(),
        ReservationFormScreen.route: (_) => const ReservationFormScreen(),
        ControllerDemoScreen.route: (_) => const ControllerDemoScreen(),
      },
    );
  }
}

class HomeIndexScreen extends StatelessWidget {
  const HomeIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bike Rental')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          _HeaderCard(),
          _NavCard(
            title: 'Username Form',
            subtitle: 'Simple form with a TextFormField',
            icon: Icons.person_outline,
            onTap: () => Navigator.pushNamed(context, UsernameFormScreen.route),
          ),
          _NavCard(
            title: 'Login',
            subtitle: 'Email & password with validation',
            icon: Icons.login,
            onTap: () => Navigator.pushNamed(context, LoginFormScreen.route),
          ),
          _NavCard(
            title: 'Registration',
            subtitle: 'Name, email, password, confirm, role',
            icon: Icons.app_registration,
            onTap: () =>
                Navigator.pushNamed(context, RegistrationFormScreen.route),
          ),
          _NavCard(
            title: 'Reservation',
            subtitle: 'Pick bike, date & time; save to list',
            icon: Icons.pedal_bike,
            onTap: () =>
                Navigator.pushNamed(context, ReservationFormScreen.route),
          ),
          _NavCard(
            title: 'Mixed Inputs',
            subtitle: 'TextField, Checkbox, Switch',
            icon: Icons.tune,
            onTap: () => Navigator.pushNamed(context, MixedInputsScreen.route),
          ),
          _NavCard(
            title: 'Controller Demo',
            subtitle: 'Capture text using a controller',
            icon: Icons.text_fields,
            onTap: () =>
                Navigator.pushNamed(context, ControllerDemoScreen.route),
          ),
        ],
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [cs.primary, cs.primaryContainer]),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.directions_bike, size: 48, color: Colors.white),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Welcome to Bike Rental',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Rent bikes, make reservations, and manage your profile.',
                    style: TextStyle(color: Colors.white70),
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

class _NavCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  const _NavCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

// 1) Simple Username Form
class UsernameFormScreen extends StatefulWidget {
  static const route = '/username';
  const UsernameFormScreen({super.key});

  @override
  State<UsernameFormScreen> createState() => _UsernameFormScreenState();
}

class _UsernameFormScreenState extends State<UsernameFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Username Form')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Enter a username' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Hello, ${_usernameController.text.trim()}!',
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 2) Login form with validation
class LoginFormScreen extends StatefulWidget {
  static const route = '/login';
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Email is required';
                  if (!v.contains('@')) return 'Enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscure,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Password is required' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Logged in as ${_emailController.text.trim()}',
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 6) Registration with role dropdown (7)
class RegistrationFormScreen extends StatefulWidget {
  static const route = '/register';
  const RegistrationFormScreen({super.key});

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  String _role = 'User';
  bool _agree = false;
  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Name is required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Email is required';
                  if (!v.contains('@')) return 'Enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _role,
                items: const [
                  DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                  DropdownMenuItem(value: 'User', child: Text('User')),
                ],
                onChanged: (v) => setState(() => _role = v ?? 'User'),
                decoration: const InputDecoration(labelText: 'Role'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscure1,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure1 ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () => setState(() => _obscure1 = !_obscure1),
                  ),
                ),
                validator: (v) =>
                    (v == null || v.length < 6) ? 'Min 6 characters' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _confirmController,
                obscureText: _obscure2,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure2 ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () => setState(() => _obscure2 = !_obscure2),
                  ),
                ),
                validator: (v) => (v != _passwordController.text)
                    ? 'Passwords do not match'
                    : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                    value: _agree,
                    onChanged: (v) => setState(() => _agree = v ?? false),
                  ),
                  const Expanded(
                    child: Text('I agree to the Terms and Privacy'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (!_agree) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please agree to the terms'),
                      ),
                    );
                    return;
                  }
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Welcome, ${_nameController.text.trim()} ($_role)',
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 5) Mixed input types: TextField, Checkbox, Switch
class MixedInputsScreen extends StatefulWidget {
  static const route = '/mixed';
  const MixedInputsScreen({super.key});

  @override
  State<MixedInputsScreen> createState() => _MixedInputsScreenState();
}

class _MixedInputsScreenState extends State<MixedInputsScreen> {
  final _textController = TextEditingController();
  bool _agree = false;
  bool _notifications = true;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mixed Inputs')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Notes about your ride',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Checkbox(
                  value: _agree,
                  onChanged: (v) => setState(() => _agree = v ?? false),
                ),
                const Expanded(child: Text('I will return the bike on time')),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Enable notifications'),
                Switch(
                  value: _notifications,
                  onChanged: (v) => setState(() => _notifications = v),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final text = _textController.text.trim();
                final msg =
                    'Notes: ${text.isEmpty ? '(none)' : text}\nAgree: $_agree, Notifications: $_notifications';
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Submission'),
                    content: Text(msg),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

// 8 & 10) Reservation form with date/time and local list display
class ReservationFormScreen extends StatefulWidget {
  static const route = '/reservation';
  const ReservationFormScreen({super.key});

  @override
  State<ReservationFormScreen> createState() => _ReservationFormScreenState();
}

class _ReservationFormScreenState extends State<ReservationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _bikeType = 'City Bike';
  DateTime? _date;
  TimeOfDay? _time;
  final List<Map<String, String>> _reservations = [];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      initialDate: _date ?? now,
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _time ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => _time = picked);
  }

  void _submit() {
    if (_date == null || _time == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date and time')),
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      final dateStr =
          '${_date!.year}-${_date!.month.toString().padLeft(2, '0')}-${_date!.day.toString().padLeft(2, '0')}';
      final timeStr = _time!.format(context);
      setState(() {
        _reservations.insert(0, {
          'name': _nameController.text.trim(),
          'bike': _bikeType,
          'date': dateStr,
          'time': timeStr,
        });
      });
      _nameController.clear();
      _bikeType = 'City Bike';
      _date = null;
      _time = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bike Reservation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Your Name'),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Name is required'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _bikeType,
                    items: const [
                      DropdownMenuItem(
                        value: 'City Bike',
                        child: Text('City Bike'),
                      ),
                      DropdownMenuItem(
                        value: 'Mountain Bike',
                        child: Text('Mountain Bike'),
                      ),
                      DropdownMenuItem(
                        value: 'Road Bike',
                        child: Text('Road Bike'),
                      ),
                      DropdownMenuItem(
                        value: 'Electric Bike',
                        child: Text('Electric Bike'),
                      ),
                    ],
                    onChanged: (v) =>
                        setState(() => _bikeType = v ?? 'City Bike'),
                    decoration: const InputDecoration(labelText: 'Bike Type'),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _pickDate,
                          icon: const Icon(Icons.date_range),
                          label: Text(
                            _date == null
                                ? 'Select Date'
                                : '${_date!.year}-${_date!.month.toString().padLeft(2, '0')}-${_date!.day.toString().padLeft(2, '0')}',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _pickTime,
                          icon: const Icon(Icons.schedule),
                          label: Text(
                            _time == null
                                ? 'Select Time'
                                : _time!.format(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Reserve'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Submitted Reservations',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            if (_reservations.isEmpty)
              const Text('No reservations yet.')
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _reservations.length,
                itemBuilder: (_, i) {
                  final r = _reservations[i];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.pedal_bike),
                      title: Text('${r['bike']} • ${r['date']} ${r['time']}'),
                      subtitle: Text('By ${r['name']}'),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

// 9) Controller demo: capture and display text after pressing a button
class ControllerDemoScreen extends StatefulWidget {
  static const route = '/controller-demo';
  const ControllerDemoScreen({super.key});

  @override
  State<ControllerDemoScreen> createState() => _ControllerDemoScreenState();
}

class _ControllerDemoScreenState extends State<ControllerDemoScreen> {
  final _controller = TextEditingController();
  String _display = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Controller Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Type something'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => setState(() => _display = _controller.text),
              child: const Text('Show Text'),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(_display.isEmpty ? 'Nothing yet.' : _display),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
