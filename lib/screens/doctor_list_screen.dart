import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final _future = Supabase.instance.client
      .from('doctors')
      .select(); // Fetch all columns from the "doctors" table

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Warna ikon hamburger
        ),
        title: const Text(
          'Mediverse',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 92, 84),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Add menu actions if needed
          },
        ),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.hasData) {
            final doctors = snapshot.data as List<dynamic>;

            if (doctors.isEmpty) {
              return const Center(
                child: Text('No doctors available'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: const BorderSide(
                      color: Color.fromARGB(129, 0, 133, 138), // Warna border
                      width: 1.0, // Ketebalan border
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: doctor['profile_image'] != null
                              ? NetworkImage(doctor['profile_image'])
                              : const AssetImage('assets/placeholder.png')
                                  as ImageProvider,
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${doctor['name'] ?? 'Unknown'}',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w800,
                                ),
                                overflow: TextOverflow
                                    .ellipsis, // Menghindari overflow
                              ),
                              Text(
                                doctor['specialization'] ?? 'No specialization',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 83, 122, 119),
                                  fontStyle: FontStyle.italic,
                                ),
                                overflow: TextOverflow
                                    .ellipsis, // Menghindari overflow
                              ),
                              const SizedBox(height: 10.0),
                              Wrap(
                                spacing: 8.0, // Jarak horizontal antar tombol
                                runSpacing:
                                    8.0, // Jarak vertikal jika terbungkus
                                children: [
                                  Material(
                                    color:
                                        const Color.fromARGB(255, 0, 119, 109),
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: InkWell(
                                      onTap: () {
                                        // Add action for Call Now
                                      },
                                      splashColor: Colors
                                          .white10, // Splash color when clicked
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6.0, horizontal: 12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(
                                              Icons.call,
                                              color: Colors.white,
                                              size:
                                                  16, // Ukuran ikon lebih kecil
                                            ),
                                            SizedBox(width: 6.0),
                                            Text(
                                              'Call Now',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    14.0, // Ukuran teks lebih kecil
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Material(
                                    color:
                                        const Color.fromARGB(255, 0, 119, 109),
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: InkWell(
                                      onTap: () {
                                        // Add action for Book Appointment
                                      },
                                      splashColor: Colors
                                          .white10, // Splash color when clicked
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6.0, horizontal: 12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(
                                              Icons.calendar_today,
                                              color: Colors.white,
                                              size:
                                                  16, // Ukuran ikon lebih kecil
                                            ),
                                            SizedBox(width: 6.0),
                                            Text(
                                              'Schedules',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    14.0, // Ukuran teks lebih kecil
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Add additional actions if needed
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Color.fromARGB(255, 0, 92, 84),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }
}
