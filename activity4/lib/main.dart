import 'package:flutter/material.dart';

void main() {
  runApp(const BikeRentalApp());
}

class BikeRentalApp extends StatelessWidget {
  const BikeRentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme =
        ColorScheme.fromSeed(seedColor: const Color(0xFF1E88E5));
    return MaterialApp(
      title: 'Bike Rental',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeShell(),
        '/about': (context) => const AboutScreen(),
        '/contact': (context) => const ContactScreen(),
        '/pushDemoA': (context) => const PushDemoAScreen(),
        '/pushDemoB': (context) => const PushDemoBScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/formsHub': (context) => const FormsHubScreen(),
        '/reservation': (context) => const ReservationScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/documentTracker': (context) => const DocumentTrackerScreen(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      Text('Bike Rental Login',
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Email is required';
                          if (!value.contains('@'))
                            return 'Enter a valid email';
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: passwordController,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Password is required';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: submit,
                        child: const Text('Login'),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/registration'),
                        child: const Text('Create an account'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void submit() {
    if (!formKey.currentState!.validate()) return;
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration:
                            const InputDecoration(labelText: 'Full name'),
                        validator: (v) =>
                            (v == null || v.isEmpty) ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Required';
                          if (!v.contains('@')) return 'Invalid email';
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: passwordController,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (v) =>
                            (v == null || v.isEmpty) ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: confirmPasswordController,
                        decoration: const InputDecoration(
                            labelText: 'Confirm password'),
                        obscureText: true,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Required';
                          if (v != passwordController.text)
                            return 'Passwords do not match';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      FilledButton(
                          onPressed: submit,
                          child: const Text('Create account'))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const HomeScreen(),
      const ProfileScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bike Rental'),
        bottom: const TabBarArea(),
      ),
      drawer: const AppDrawer(),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bike Rental',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Rent your ride with ease'),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () => Navigator.pushNamed(context, '/about'),
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail_outlined),
            title: const Text('Contact'),
            onTap: () => Navigator.pushNamed(context, '/contact'),
          ),
          ListTile(
            leading: const Icon(Icons.assignment_outlined),
            title: const Text('Document Tracker'),
            onTap: () => Navigator.pushNamed(context, '/documentTracker'),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month_outlined),
            title: const Text('Reservation'),
            onTap: () => Navigator.pushNamed(context, '/reservation'),
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Payment'),
            onTap: () => Navigator.pushNamed(context, '/payment'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
      ),
    );
  }
}

class TabBarArea extends StatelessWidget implements PreferredSizeWidget {
  const TabBarArea({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: const TabBar(
        tabs: [
          Tab(text: 'Chats', icon: Icon(Icons.chat_bubble_outline)),
          Tab(text: 'Status', icon: Icon(Icons.timelapse)),
          Tab(text: 'Calls', icon: Icon(Icons.call_outlined)),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bikes = [
      ('City Bike', 'Comfortable city ride', Icons.pedal_bike),
      ('Mountain Bike', 'Trail-ready performance', Icons.directions_bike),
      ('E-Bike', 'Effortless assisted rides', Icons.electric_bike),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Available Bikes', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: bikes
              .map((b) => _BikeCard(title: b.$1, subtitle: b.$2, icon: b.$3))
              .toList(),
        ),
        const SizedBox(height: 24),
        const FormsHubPreview(),
      ],
    );
  }
}

class _BikeCard extends StatelessWidget {
  const _BikeCard(
      {required this.title, required this.subtitle, required this.icon});

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 32),
                  const SizedBox(width: 12),
                  Text(title, style: Theme.of(context).textTheme.titleMedium)
                ],
              ),
              const SizedBox(height: 8),
              Text(subtitle),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () => Navigator.pushNamed(context, '/reservation'),
                  child: const Text('Reserve'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FormsHubPreview extends StatelessWidget {
  const FormsHubPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Forms & Inputs',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, '/formsHub'),
                  child: const Text('Open Forms Demo'),
                ),
                OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, '/pushDemoA'),
                  child: const Text('Push vs Replacement'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile'));
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Settings'));
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: const Center(child: Text('About Bike Rental')),
    );
  }
}

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact')),
      body: const Center(child: Text('Contact us at support@bikerental.test')),
    );
  }
}

class PushDemoAScreen extends StatelessWidget {
  const PushDemoAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Push Demo A')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('This is A'),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () => Navigator.pushNamed(context, '/pushDemoB'),
              child: const Text('push to B'),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/pushDemoB'),
              child: const Text('pushReplacement to B'),
            ),
          ],
        ),
      ),
    );
  }
}

class PushDemoBScreen extends StatelessWidget {
  const PushDemoBScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Push Demo B')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('This is B'),
            const SizedBox(height: 8),
            FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('pop to previous')),
          ],
        ),
      ),
    );
  }
}

class FormsHubScreen extends StatelessWidget {
  const FormsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forms Hub')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          UsernameFormCard(),
          SizedBox(height: 12),
          MultiInputFormCard(),
          SizedBox(height: 12),
          RoleDropdownFormCard(),
          SizedBox(height: 12),
          ControllerCaptureCard(),
          SizedBox(height: 12),
          LocalListFormCard(),
        ],
      ),
    );
  }
}

class UsernameFormCard extends StatefulWidget {
  const UsernameFormCard({super.key});

  @override
  State<UsernameFormCard> createState() => _UsernameFormCardState();
}

class _UsernameFormCardState extends State<UsernameFormCard> {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Username Form',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Hello, ${controller.text}!')));
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

class MultiInputFormCard extends StatefulWidget {
  const MultiInputFormCard({super.key});

  @override
  State<MultiInputFormCard> createState() => _MultiInputFormCardState();
}

class _MultiInputFormCardState extends State<MultiInputFormCard> {
  bool agreeToTerms = false;
  bool enableNotifications = true;
  final noteController = TextEditingController();

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Multi Input', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            TextField(
                controller: noteController,
                decoration: const InputDecoration(labelText: 'Notes')),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Agree to rental terms'),
              value: agreeToTerms,
              onChanged: (v) => setState(() => agreeToTerms = v ?? false),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Enable notifications'),
              value: enableNotifications,
              onChanged: (v) => setState(() => enableNotifications = v),
            ),
          ],
        ),
      ),
    );
  }
}

class RoleDropdownFormCard extends StatefulWidget {
  const RoleDropdownFormCard({super.key});

  @override
  State<RoleDropdownFormCard> createState() => _RoleDropdownFormCardState();
}

class _RoleDropdownFormCardState extends State<RoleDropdownFormCard> {
  final formKey = GlobalKey<FormState>();
  String? role;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Role',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Role'),
                value: role,
                items: const [
                  DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                  DropdownMenuItem(value: 'User', child: Text('User')),
                ],
                onChanged: (v) => setState(() => role = v),
                validator: (v) => v == null ? 'Please select a role' : null,
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Selected: $role')));
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final formKey = GlobalKey<FormState>();
  DateTime? date;
  TimeOfDay? time;
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final now = DateTime.now();
    final result = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
      initialDate: now,
    );
    if (result != null) setState(() => date = result);
  }

  Future<void> pickTime() async {
    final result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) setState(() => time = result);
  }

  void submit() {
    if (!formKey.currentState!.validate()) return;
    Navigator.pushNamed(context, '/payment');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reservation')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        hintText: date == null
                            ? 'Pick date'
                            : '${date!.year}-${date!.month}-${date!.day}',
                      ),
                      validator: (_) => date == null ? 'Pick a date' : null,
                      onTap: pickDate,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Time',
                        hintText:
                            time == null ? 'Pick time' : time!.format(context),
                      ),
                      validator: (_) => time == null ? 'Pick a time' : null,
                      onTap: pickTime,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              FilledButton(
                  onPressed: submit, child: const Text('Proceed to Payment')),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Payment Method',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            RadioListTile<int>(
                value: 0,
                groupValue: 0,
                onChanged: (_) {},
                title: const Text('Credit/Debit Card')),
            RadioListTile<int>(
                value: 1,
                groupValue: 0,
                onChanged: (_) {},
                title: const Text('Cash on Pickup')),
            const Spacer(),
            Row(
              children: [
                OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back')),
                const SizedBox(width: 12),
                FilledButton(
                    onPressed: () => Navigator.popUntil(
                        context, ModalRoute.withName('/home')),
                    child: const Text('Confirm')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DocumentTrackerScreen extends StatefulWidget {
  const DocumentTrackerScreen({super.key});

  @override
  State<DocumentTrackerScreen> createState() => _DocumentTrackerScreenState();
}

class _DocumentTrackerScreenState extends State<DocumentTrackerScreen> {
  final submissions = <Map<String, String>>[];
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final idController = TextEditingController();
  String status = 'Pending';

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    super.dispose();
  }

  void addSubmission() {
    if (!formKey.currentState!.validate()) return;
    setState(() {
      submissions.add({
        'name': nameController.text,
        'id': idController.text,
        'status': status
      });
      nameController.clear();
      idController.clear();
      status = 'Pending';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Document Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: idController,
                    decoration: const InputDecoration(labelText: 'ID Number'),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: status,
                    items: const [
                      DropdownMenuItem(
                          value: 'Pending', child: Text('Pending')),
                      DropdownMenuItem(
                          value: 'Verified', child: Text('Verified')),
                      DropdownMenuItem(
                          value: 'Rejected', child: Text('Rejected')),
                    ],
                    onChanged: (v) => setState(() => status = v ?? 'Pending'),
                    decoration: const InputDecoration(labelText: 'Status'),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton(
                        onPressed: addSubmission, child: const Text('Add')),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: submissions.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final s = submissions[index];
                  return ListTile(
                    leading: const Icon(Icons.assignment_outlined),
                    title: Text(s['name'] ?? ''),
                    subtitle: Text('ID: ${s['id']}  •  Status: ${s['status']}'),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ControllerCaptureCard extends StatefulWidget {
  const ControllerCaptureCard({super.key});

  @override
  State<ControllerCaptureCard> createState() => _ControllerCaptureCardState();
}

class _ControllerCaptureCardState extends State<ControllerCaptureCard> {
  final controller = TextEditingController();
  String output = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Controller Capture',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            TextField(
                controller: controller,
                decoration: const InputDecoration(labelText: 'Enter text')),
            const SizedBox(height: 8),
            Row(
              children: [
                FilledButton(
                  onPressed: () => setState(() => output = controller.text),
                  child: const Text('Show'),
                ),
                const SizedBox(width: 12),
                Text(output),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LocalListFormCard extends StatefulWidget {
  const LocalListFormCard({super.key});

  @override
  State<LocalListFormCard> createState() => _LocalListFormCardState();
}

class _LocalListFormCardState extends State<LocalListFormCard> {
  final formKey = GlobalKey<FormState>();
  final itemController = TextEditingController();
  final items = <String>[];

  @override
  void dispose() {
    itemController.dispose();
    super.dispose();
  }

  void addItem() {
    if (!formKey.currentState!.validate()) return;
    setState(() {
      items.add(itemController.text);
      itemController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Local List Save',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Form(
              key: formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: itemController,
                      decoration: const InputDecoration(labelText: 'Item'),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(onPressed: addItem, child: const Text('Add')),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ...items
                .map((e) => ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text(e)))
                .toList(),
          ],
        ),
      ),
    );
  }
}
