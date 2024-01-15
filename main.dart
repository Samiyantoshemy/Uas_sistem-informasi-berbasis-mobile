import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://udeymmgirqdqbmlvaffh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVkZXltbWdpcnFkcWJtbHZhZmZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDUyNDU3OTYsImV4cCI6MjAyMDgyMTc5Nn0.dlO2Ln6tVyH_QjbwOvCkryg7_e0a-w-v5KeNHnYz5tg',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Countries',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _future = Supabase.instance.client.from('countries').select();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final countries = snapshot.data!;
          return ListView.builder(
            itemCount: countries.length,
            itemBuilder: ((context, index) {
              final country = countries[index];
              return ListTile(
                leading: Icon(
                  Icons.flag_circle_rounded,
                  color: Color.fromARGB(255, 1, 241, 41),
                ),
                // trailing: Icon(Icons.flag_circle_outlined, color: Colors.amber),
                title: Text(
                  country['admin'],
                  style:
                      TextStyle(color: const Color.fromARGB(255, 0, 85, 155)),
                ),
                subtitle: Text(country['baju']),
              );
            }),
          );
        },
      ),
    );
  }
}
