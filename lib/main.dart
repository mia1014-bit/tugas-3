import 'package:flutter/material.dart';
import 'hasil_feedback_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Form Feedback App',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.lightBlue,
      ),
      home: const FormFeedbackPage(),
    );
  }
}

class FormFeedbackPage extends StatefulWidget {
  const FormFeedbackPage({super.key});

  @override
  State<FormFeedbackPage> createState() => _FormFeedbackPageState();
}

class _FormFeedbackPageState extends State<FormFeedbackPage> {
  final _namaController = TextEditingController();
  final _komentarController = TextEditingController();
  double _rating = 3;

  void _kirimFeedback() {
    if (_namaController.text.isEmpty || _komentarController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Isi semua kolom terlebih dahulu!"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // 🔹 Transisi animasi slide + fade
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (_, __, ___) => HasilFeedbackPage(
          nama: _namaController.text,
          komentar: _komentarController.text,
          rating: _rating.toInt(),
        ),
        transitionsBuilder: (_, animation, __, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;
          final tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(position: animation.drive(tween), child: child),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 🌈 Gradient background baby blue to white
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB3E5FC), Color(0xFFE1F5FE), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Icon ilustrasi
                const Icon(
                  Icons.feedback_rounded,
                  color: Colors.lightBlue,
                  size: 90,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Form Feedback 💬",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),
                const SizedBox(height: 30),

                // Card transparan seperti kaca
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Masukkan data Anda:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Nama
                      TextField(
                        controller: _namaController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline),
                          labelText: "Nama Anda",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Komentar
                      TextField(
                        controller: _komentarController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.comment_outlined),
                          labelText: "Komentar Anda",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Rating Anda:", style: TextStyle(fontSize: 16)),
                          Text(
                            "${_rating.toInt()} / 5 ⭐",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: _rating,
                        min: 1,
                        max: 5,
                        divisions: 4,
                        activeColor: Colors.lightBlueAccent,
                        onChanged: (value) {
                          setState(() {
                            _rating = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Tombol Kirim
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: _kirimFeedback,
                          icon: const Icon(Icons.send_rounded),
                          label: const Text(
                            "Kirim Feedback",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlueAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Terima kasih sudah membantu kami menjadi lebih baik 💙",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
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