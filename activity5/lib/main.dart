import 'package:audioplayers/audioplayers.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const BikeRentalApp());
}

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  ThemeMode get themeMode => _isDark ? ThemeMode.dark : ThemeMode.light;
  void toggleTheme(bool value) {
    _isDark = value;
    notifyListeners();
  }
}

class CartProvider extends ChangeNotifier {
  final List<String> _items = <String>[];
  List<String> get items => List.unmodifiable(_items);
  int get count => _items.length;
  void addItem(String name) {
    _items.add(name);
    notifyListeners();
  }

  void removeAt(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

class BikeRentalApp extends StatelessWidget {
  const BikeRentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, _) {
          return MaterialApp(
            title: 'Bike Rental',
            debugShowCheckedModeBanner: false,
            themeMode: theme.themeMode,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
              textTheme: GoogleFonts.poppinsTextTheme(),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.teal,
                brightness: Brightness.dark,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData.dark().textTheme,
              ),
              useMaterial3: true,
            ),
            initialRoute: '/login',
            routes: {
              '/login': (_) => const LoginScreen(),
              '/register': (_) => const RegistrationScreen(),
              '/home': (_) => const HomeShell(),
              '/about': (_) => const AboutScreen(),
              '/contact': (_) => const ContactScreen(),
              '/reservation': (_) => const ReservationScreen(),
              '/payment': (_) => const PaymentScreen(),
            },
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  MaterialIcons.directions_bike,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 8),
                Text(
                  'Bike Rental',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Email required';
                              if (!value.contains('@'))
                                return 'Enter a valid email';
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Password required';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: _submit,
                              child: const Text('Login'),
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/register'),
                            child: const Text('Create account'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _role = 'User';
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Name required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Email required';
                  if (!v.contains('@')) return 'Invalid email';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Password required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _confirm,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
                validator: (v) =>
                    (v != _password.text) ? 'Passwords do not match' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _role,
                items: const [
                  DropdownMenuItem(value: 'User', child: Text('User')),
                  DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                ],
                onChanged: (v) => setState(() => _role = v),
                decoration: const InputDecoration(labelText: 'Role'),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _submit,
                  child: const Text('Create Account'),
                ),
              ),
            ],
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
  int _currentIndex = 0;
  final List<Widget> _tabs = const [HomeIndex(), OrdersTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bike Rental'),
        actions: [
          Row(
            children: [
              const Icon(Icons.dark_mode_outlined),
              Switch(value: theme.isDark, onChanged: theme.toggleTheme),
            ],
          ),
          const SizedBox(width: 8),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  builder: (_) => const CartSheet(),
                ),
              ),
              Positioned(
                right: 8,
                top: 6,
                child: CircleAvatar(
                  radius: 9,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    context.watch<CartProvider>().count.toString(),
                    style: const TextStyle(fontSize: 11, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
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
          UserAccountsDrawerHeader(
            accountName: const Text('Rider'),
            accountEmail: const Text('rider@bikerental.app'),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.pedal_bike),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.event_available_outlined),
            title: const Text('Reservation'),
            onTap: () => Navigator.pushNamed(context, '/reservation'),
          ),
          ListTile(
            leading: const Icon(Icons.image_outlined),
            title: const Text('Gallery'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GalleryScreen()),
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
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout (pushReplacement)'),
            onTap: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
      ),
    );
  }
}

class HomeIndex extends StatelessWidget {
  const HomeIndex({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_bike), text: 'Bikes'),
              Tab(icon: Icon(Icons.video_collection_outlined), text: 'Media'),
              Tab(
                icon: Icon(Icons.playlist_add_check_outlined),
                text: 'Inputs',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [const BikesTab(), const MediaTab(), const InputsTab()],
            ),
          ),
        ],
      ),
    );
  }
}

class BikesTab extends StatelessWidget {
  const BikesTab({super.key});
  @override
  Widget build(BuildContext context) {
    final bikes = <Map<String, String>>[
      {'name': 'City Bike', 'img': 'assets/images/bike1.png'},
      {'name': 'Mountain Bike', 'img': 'assets/images/bike2.png'},
      {'name': 'Road Bike', 'img': 'assets/images/bike3.png'},
    ];
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemCount: bikes.length,
        itemBuilder: (context, index) {
          final bike = bikes[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    child: Image.asset(
                      bike['img']!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.network(
                        'https://images.unsplash.com/photo-1518655048521-f130df041f66?w=600',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(bike['name']!),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    onPressed: () =>
                        context.read<CartProvider>().addItem(bike['name']!),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MediaTab extends StatefulWidget {
  const MediaTab({super.key});
  @override
  State<MediaTab> createState() => _MediaTabState();
}

class _MediaTabState extends State<MediaTab> {
  late final VideoPlayerController _videoController;
  ChewieController? _chewieController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _audioPlaying = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
    );
    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoPlay: false,
      looping: true,
      allowFullScreen: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.teal,
        handleColor: Colors.tealAccent,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.teal.shade200,
      ),
    );
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _toggleAudio() async {
    if (_audioPlaying) {
      await _audioPlayer.stop();
      setState(() => _audioPlaying = false);
    } else {
      await _audioPlayer.play(
        UrlSource('https://www.kozco.com/tech/LRMonoPhase4.mp3'),
      );
      setState(() => _audioPlaying = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Images',
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/images/bike1.png',
                    height: 140,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Image.network(
                      'https://images.unsplash.com/photo-1509395176047-4a66953fd231?w=400',
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://images.unsplash.com/photo-1485968579580-b6d095142e6e?w=400',
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Carousel',
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const GalleryCarousel(height: 160),
        const SizedBox(height: 16),
        Text(
          'Video (Chewie)',
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: _chewieController == null
              ? const Center(child: CircularProgressIndicator())
              : Chewie(controller: _chewieController!),
        ),
        const SizedBox(height: 16),
        Text(
          'Audio',
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        FilledButton.icon(
          onPressed: _toggleAudio,
          icon: Icon(
            _audioPlaying
                ? Icons.stop_circle_outlined
                : Icons.play_circle_outline,
          ),
          label: Text(_audioPlaying ? 'Stop Audio' : 'Play Audio'),
        ),
        const SizedBox(height: 16),
        Text(
          'Icons',
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/icons/bike.png',
              width: 36,
              height: 36,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.pedal_bike, size: 32, color: Colors.teal),
            ),
            Image.asset(
              'assets/icons/helmet.png',
              width: 36,
              height: 36,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.safety_check,
                size: 32,
                color: Colors.orange,
              ),
            ),
            Image.asset(
              'assets/icons/repair.png',
              width: 36,
              height: 36,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.build_outlined,
                size: 32,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class InputsTab extends StatefulWidget {
  const InputsTab({super.key});
  @override
  State<InputsTab> createState() => _InputsTabState();
}

class _InputsTabState extends State<InputsTab> {
  final GlobalKey<FormState> _usernameKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  bool _agree = false;
  bool _available = true;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _controllerDemo = TextEditingController();
  final List<String> _submitted = <String>[];

  @override
  void dispose() {
    _username.dispose();
    _controllerDemo.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  void _saveToLocalList() {
    if (_usernameKey.currentState!.validate()) {
      setState(() {
        _submitted.add(_username.text);
        _username.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Username Form', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Form(
            key: _usernameKey,
            child: TextFormField(
              controller: _username,
              decoration: const InputDecoration(labelText: 'Username'),
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'Enter username' : null,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              FilledButton(
                onPressed: _saveToLocalList,
                child: const Text('Save Username'),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {
                  final text = _controllerDemo.text;
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Controller Text'),
                      content: Text(text),
                    ),
                  );
                },
                child: const Text('Show Controller Text'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _controllerDemo,
            decoration: const InputDecoration(
              labelText: 'Controller demo input',
            ),
          ),
          const SizedBox(height: 12),
          CheckboxListTile(
            value: _agree,
            onChanged: (v) => setState(() => _agree = v ?? false),
            title: const Text('Agree to rental terms'),
          ),
          SwitchListTile(
            value: _available,
            onChanged: (v) => setState(() => _available = v),
            title: const Text('Bike available for reservation'),
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.date_range_outlined),
                  label: Text(
                    _selectedDate == null
                        ? 'Pick Date'
                        : _selectedDate!.toString().split(' ').first,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickTime,
                  icon: const Icon(Icons.access_time),
                  label: Text(
                    _selectedTime == null
                        ? 'Pick Time'
                        : _selectedTime!.format(context),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Saved Usernames',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          ..._submitted
              .map(
                (e) =>
                    ListTile(leading: const Icon(Icons.person), title: Text(e)),
              )
              .toList(),
        ],
      ),
    );
  }
}

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});
  @override
  Widget build(BuildContext context) {
    final items = context.watch<CartProvider>().items;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        ListTile(
          title: const Text('Cart Items'),
          subtitle: Text(
            'Watching count: ${context.watch<CartProvider>().count}',
          ),
          trailing: FilledButton(
            onPressed: () => context.read<CartProvider>().addItem('Helmet'),
            child: const Text('Add Helmet (read)'),
          ),
        ),
        const Divider(),
        ...items.asMap().entries.map(
          (entry) => Card(
            child: ListTile(
              leading: const Icon(Icons.shopping_bag_outlined),
              title: Text(entry.value),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () =>
                    context.read<CartProvider>().removeAt(entry.key),
              ),
            ),
          ),
        ),
        if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'No items yet. Add from Bikes tab.',
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/bike3.png'),
                onBackgroundImageError: null,
              ),
              const SizedBox(height: 12),
              Text(
                'Rider Name',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Feather.user, size: 18),
                  SizedBox(width: 6),
                  Text('Premium Member'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartSheet extends StatelessWidget {
  const CartSheet({super.key});
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Your Cart',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ...cart.items.map((e) => ListTile(title: Text(e))).toList(),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: cart.clear,
                    child: const Text('Clear'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/payment');
                    },
                    child: const Text('Checkout'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Navigator.push vs pushReplacement demo'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PushVsReplacementScreen(),
                ),
              ),
              child: const Text('Open Demo'),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Contact us at support@bikerental.app')),
    );
  }
}

class PushVsReplacementScreen extends StatelessWidget {
  const PushVsReplacementScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Push vs Replacement')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DummyScreen(title: 'Pushed Screen'),
                ),
              ),
              child: const Text('Navigator.push'),
            ),
            const SizedBox(height: 12),
            FilledButton.tonal(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const DummyScreen(title: 'Replacement Screen'),
                ),
              ),
              child: const Text('Navigator.pushReplacement'),
            ),
          ],
        ),
      ),
    );
  }
}

class DummyScreen extends StatelessWidget {
  final String title;
  const DummyScreen({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Back (pop)'),
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
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  String _bikeType = 'City Bike';
  DateTime? _date;
  TimeOfDay? _time;
  bool _needHelmet = true;
  bool _agree = false;
  final List<Map<String, String>> _reservations = <Map<String, String>>[];

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => _time = picked);
  }

  void _submit() {
    if (!_agree) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please agree to terms')));
      return;
    }
    if (_key.currentState!.validate() && _date != null && _time != null) {
      final entry = <String, String>{
        'name': _name.text,
        'email': _email.text,
        'bike': _bikeType,
        'date': _date!.toString().split(' ').first,
        'time': _time!.format(context),
        'helmet': _needHelmet ? 'Yes' : 'No',
      };
      setState(() {
        _reservations.add(entry);
        _name.clear();
        _email.clear();
        _date = null;
        _time = null;
        _needHelmet = true;
        _agree = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reservation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _key,
              child: Column(
                children: [
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Required';
                      if (!v.contains('@')) return 'Invalid email';
                      return null;
                    },
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
                          icon: const Icon(Icons.date_range_outlined),
                          label: Text(
                            _date == null
                                ? 'Pick Date'
                                : _date!.toString().split(' ').first,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _pickTime,
                          icon: const Icon(Icons.access_time),
                          label: Text(
                            _time == null
                                ? 'Pick Time'
                                : _time!.format(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    value: _needHelmet,
                    onChanged: (v) => setState(() => _needHelmet = v),
                    title: const Text('Need Helmet'),
                  ),
                  CheckboxListTile(
                    value: _agree,
                    onChanged: (v) => setState(() => _agree = v ?? false),
                    title: const Text('Agree to terms and conditions'),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _submit,
                      child: const Text('Reserve'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Submitted Reservations',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ..._reservations.map(
              (r) => Card(
                child: ListTile(
                  leading: const Icon(Icons.event_note_outlined),
                  title: Text('${r['bike']} • ${r['date']} ${r['time']}'),
                  subtitle: Text(
                    '${r['name']} • ${r['email']} • Helmet: ${r['helmet']}',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final double pricePerItem = 1500.0;
    final double subtotal = cart.count * pricePerItem;
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  ...cart.items.map(
                    (e) => ListTile(
                      title: Text(e),
                      trailing: Text('₱${pricePerItem.toStringAsFixed(2)}'),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('Subtotal'),
                    trailing: Text('₱${subtotal.toStringAsFixed(2)}'),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  if (cart.count == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cart is empty')),
                    );
                    return;
                  }
                  cart.clear();
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Payment Successful'),
                      content: const Text('Thank you for your purchase!'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.popUntil(
                            context,
                            ModalRoute.withName('/home'),
                          ),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.lock_outline),
                label: Text('Pay ₱${subtotal.toStringAsFixed(2)}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GalleryCarousel extends StatelessWidget {
  final double height;
  const GalleryCarousel({super.key, this.height = 180});
  @override
  Widget build(BuildContext context) {
    final imgs = <String>[
      'assets/images/bike1.png',
      'assets/images/bike2.png',
      'assets/images/bike3.png',
    ];
    return SizedBox(
      height: height,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.88),
        itemCount: imgs.length,
        itemBuilder: (context, index) {
          final path = imgs[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                path,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.network(
                  'https://images.unsplash.com/photo-1464925257126-6450e871c667?w=800',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [GalleryCarousel(height: 220)],
      ),
    );
  }
}
