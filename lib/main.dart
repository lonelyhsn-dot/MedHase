import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(const MedCaseApp());
}

class MedCaseApp extends StatelessWidget {
  const MedCaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedCase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SpecialtiesScreen(),
    const Center(child: Text("Klinik Kodeks", style: TextStyle(fontWeight: FontWeight.bold))),
    const MyCasesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (idx) => setState(() => _currentIndex = idx),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF6366F1),
          unselectedItemColor: Colors.grey.shade400,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Ana Sayfa"),
            BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: "Keşfet"),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: "Kodeks"),
            BottomNavigationBarItem(icon: Icon(Icons.folder_shared_rounded), label: "Vakalarım"),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFFE0E7FF),
              child: Icon(Icons.person, color: Color(0xFF4F46E5)),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dr. Taha", style: TextStyle(color: Colors.black84, fontSize: 16, fontWeight: FontWeight.bold)),
                Text("Lv.6", style: TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEDD5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.local_fire_department, color: Colors.deepOrange, size: 18),
                SizedBox(width: 4),
                Text("Bugün", style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFEF08A), width: 1.5),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF9C3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFFACC15)),
                        ),
                        child: const Center(
                          child: Text("6", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF854D0E))),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Pratisyen Hekim", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            Text("Lv.7 için 9110 XP kaldı", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: const Color(0xFFE0F2FE), borderRadius: BorderRadius.circular(20)),
                        child: const Text("⚡ +150 XP", style: TextStyle(color: Color(0xFF0284C7), fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const LinearProgressIndicator(value: 0.15, backgroundColor: Color(0xFFF1F5F9), color: Color(0xFF0284C7), minHeight: 6),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(10)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.verified, color: Color(0xFF16A34A), size: 16),
                              SizedBox(width: 6),
                              Text("15 Toplam Tanı", style: TextStyle(color: Color(0xFF16A34A), fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(10)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.pie_chart, color: Color(0xFFD97706), size: 16),
                              SizedBox(width: 6),
                              Text("%60 Doğruluk", style: TextStyle(color: Color(0xFFD97706), fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      final cases = jsonDecode(kClinicalCasesJson);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProcedureRoomScreen(caseData: cases[0])));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black.withOpacity(0.05)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: const Color(0xFFE0F2FE), borderRadius: BorderRadius.circular(14)),
                            child: const Icon(Icons.sports_esports_rounded, color: Color(0xFF0284C7)),
                          ),
                          const SizedBox(height: 12),
                          const Text("Hemen Oyna", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          const SizedBox(height: 4),
                          const Text("Klinik becerilerini test et!", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: const Color(0xFFFFEDD5), borderRadius: BorderRadius.circular(14)),
                          child: const Icon(Icons.mode_edit_rounded, color: Color(0xFFEA580C)),
                        ),
                        const SizedBox(height: 12),
                        const Text("Vaka Oluştur", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 4),
                        const Text("Kendi vakanı yaz", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black.withOpacity(0.05)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: const Color(0xFFE0F2FE), borderRadius: BorderRadius.circular(14)),
                    child: const Icon(Icons.menu_book_rounded, color: Color(0xFF0284C7)),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Klinik Kodeks", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Text("Tüm tetkik ve tedavilerin ansiklopedisi", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpecialtiesScreen extends StatelessWidget {
  const SpecialtiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final list = [
      {"name": "Kardiyoloji", "cases": "10 vaka", "icon": Icons.favorite, "color": Colors.red},
      {"name": "Dahiliye", "cases": "8 vaka", "icon": Icons.water_drop, "color": Colors.orange},
      {"name": "Acil Tıp", "cases": "16 vaka", "icon": Icons.emergency, "color": Colors.redAccent},
      {"name": "Pediatri", "cases": "5 vaka", "icon": Icons.child_care, "color": Colors.amber},
      {"name": "Nöroloji", "cases": "3 vaka", "icon": Icons.psychology, "color": Colors.cyan},
      {"name": "Dermatoloji", "cases": "3 vaka", "icon": Icons.healing, "color": Colors.purple},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Tüm Uzmanlık Alanları", style: TextStyle(color: Colors.black84, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.15,
        ),
        itemCount: list.length,
        itemBuilder: (context, i) {
          final item = list[i];
          final Color clr = item['color'] as Color;
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.black.withOpacity(0.04)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: clr.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                  child: Icon(item['icon'] as IconData, color: clr, size: 22),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item['cases'] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        const Icon(Icons.arrow_forward_rounded, size: 14, color: Colors.grey),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class MyCasesScreen extends StatelessWidget {
  const MyCasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Vakalarım", style: TextStyle(color: Colors.black84, fontWeight: FontWeight.bold)),
      ),
      body: const Center(child: Text("Kayıtlı Vaka Bulunmuyor", style: TextStyle(color: Colors.grey))),
    );
  }
}

class ProcedureRoomScreen extends StatefulWidget {
  final Map<String, dynamic> caseData;
  const ProcedureRoomScreen({super.key, required this.caseData});

  @override
  State<ProcedureRoomScreen> createState() => _ProcedureRoomScreenState();
}

class _ProcedureRoomScreenState extends State<ProcedureRoomScreen> {
  int stability = 99;
  late Map<String, dynamic> vitals;
  final List<Map<String, dynamic>> logs = [];
  final Set<String> testsDone = {};
  final Set<String> trtsDone = {};

  @override
  void initState() {
    super.initState();
    vitals = Map<String, dynamic>.from(widget.caseData['triage']['initial_vitals']);
    logs.add({
      "title": "Vaka Başladı",
      "time": "00:00",
      "icon": Icons.info_outline,
      "color": Colors.grey,
      "content": "${widget.caseData['triage']['gender']}, ${widget.caseData['triage']['age']} yaşında - ${widget.caseData['triage']['chief_complaint']}"
    });
    logs.add({
      "title": "İlk Değerlendirme",
      "time": "00:00",
      "icon": Icons.touch_app_outlined,
      "color": Colors.amber,
      "content": "Durum: ${vitals['condition']} | Stabilite: %$stability\nNabız: ${vitals['hr']}, TA: ${vitals['bp']}, SpO2: ${vitals['spo2']}, Ateş: ${vitals['temp']}"
    });
  }

  void _openMonitor() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => MonitorBottomSheet(vitals: vitals),
    );
  }

  void _openTestsModal() {
    final diags = widget.caseData['diagnostics'] as List;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("İstenebilecek Tetkikler", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...diags.map((d) {
                final done = testsDone.contains(d['id']);
                return Card(
                  color: const Color(0xFFF8FAFC),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(d['name'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    subtitle: done ? Text("Sonuç: ${d['result']}", style: const TextStyle(color: Color(0xFF0D9488), fontSize: 12)) : null,
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: done ? Colors.grey : const Color(0xFF6366F1)),
                      onPressed: done ? null : () {
                        setState(() {
                          testsDone.add(d['id']);
                          logs.add({
                            "title": "Tetkik Tamamlandı",
                            "time": "00:15",
                            "icon": Icons.biotech,
                            "color": const Color(0xFF6366F1),
                            "content": "${d['name']}\nSonuç: ${d['result']}"
                          });
                        });
                        setModalState(() {});
                      },
                      child: Text(done ? "Tamam" : "İste"),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _openTreatmentsModal() {
    final trts = widget.caseData['treatments'] as List;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Tedavi & Müdahale Seçenekleri", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...trts.map((t) {
              final done = trtsDone.contains(t['id']);
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(14),
                    side: BorderSide(color: done ? Colors.grey : const Color(0xFF6366F1)),
                  ),
                  onPressed: done ? null : () {
                    Navigator.pop(context);
                    setState(() {
                      trtsDone.add(t['id']);
                      final Map<String, dynamic> up = t['vitals_update'] ?? {};
                      up.forEach((k, v) => vitals[k] = v);
                      if ((t['score'] as int) > 0) {
                        stability = 100;
                      } else {
                        stability = (stability - 30).clamp(10, 100);
                      }
                      logs.add({
                        "title": "Müdahale Yapıldı",
                        "time": "00:20",
                        "icon": Icons.medication,
                        "color": (t['score'] as int) >= 0 ? Colors.green : Colors.red,
                        "content": "${t['name']}\n${t['feedback']}"
                      });
                    });
                  },
                  child: Row(
                    children: [
                      Icon(done ? Icons.check : Icons.play_arrow, color: done ? Colors.grey : const Color(0xFF6366F1), size: 18),
                      const SizedBox(width: 8),
                      Expanded(child: Text(t['name'], style: TextStyle(color: done ? Colors.grey : Colors.black84, fontSize: 13))),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black84, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: Color(0xFFFEE2E2), shape: BoxShape.circle),
              child: const Icon(Icons.emergency, color: Colors.red, size: 16),
            ),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Müdahale Odası", style: TextStyle(color: Colors.black84, fontWeight: FontWeight.bold, fontSize: 16)),
                Row(
                  children: [
                    Icon(Icons.timer_outlined, size: 12, color: Colors.grey),
                    SizedBox(width: 4),
                    Text("00:12", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 46,
                  height: 46,
                  child: CircularProgressIndicator(
                    value: stability / 100,
                    strokeWidth: 3,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(stability > 50 ? const Color(0xFF22C55E) : Colors.red),
                  ),
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: stability > 50 ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2),
                  child: Text("$stability%", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: stability > 50 ? const Color(0xFF16A34A) : Colors.red)),
                ),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                InkWell(onTap: _openTestsModal, child: _pillButton("Tetkik", Icons.biotech, true)),
                const SizedBox(width: 8),
                InkWell(onTap: _openTreatmentsModal, child: _pillButton("Tedavi", Icons.medication, false)),
                const SizedBox(width: 8),
                _pillButton("Taburcu", Icons.exit_to_app, false),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: logs.length,
              itemBuilder: (context, i) {
                final log = logs[i];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(color: (log['color'] as Color).withOpacity(0.15), shape: BoxShape.circle),
                          child: Icon(log['icon'] as IconData, size: 18, color: log['color'] as Color),
                        ),
                        if (i != logs.length - 1)
                          Container(width: 2, height: 75, color: Colors.grey.shade300),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black.withOpacity(0.04)),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6)],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(log['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                Text("⏱ ${log['time']}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(log['content'] as String, style: const TextStyle(color: Colors.black84, fontSize: 13, height: 1.3)),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _dockAction("Soru", Icons.chat_bubble_outline_rounded, const Color(0xFFE0F2FE), const Color(0xFF0284C7), () {}),
                _dockAction("Tetkik", Icons.biotech, const Color(0xFFEDE9FE), const Color(0xFF7C3AED), _openTestsModal),
                _dockAction("Tedavi", Icons.medication_outlined, const Color(0xFFFFEDD5), const Color(0xFFEA580C), _openTreatmentsModal),
                _dockAction("Monitör", Icons.monitor_heart_outlined, const Color(0xFFDCFCE7), const Color(0xFF16A34A), _openMonitor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pillButton(String title, IconData icon, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: active ? const Color(0xFFEDE9FE) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: active ? const Color(0xFF6D28D9) : Colors.grey),
          const SizedBox(width: 6),
          Text(title, style: TextStyle(color: active ? const Color(0xFF6D28D9) : Colors.grey, fontWeight: active ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _dockAction(String title, IconData icon, Color bg, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black84)),
        ],
      ),
    );
  }
}

class MonitorBottomSheet extends StatelessWidget {
  final Map<String, dynamic> vitals;
  const MonitorBottomSheet({super.key, required this.vitals});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFFFEF9C3), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.show_chart, color: Color(0xFFCA8A04), size: 20),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("HASTA MONİTÖRÜ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("6 parametre izleniyor", style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
            children: [
              _monitorCard("KALP HIZI", vitals['hr'].toString().replaceAll(" /dk", ""), "bpm", const Color(0xFF22C55E), Icons.favorite),
              _monitorCard("KAN BASINCI", vitals['bp'].toString().replaceAll(" mmHg", ""), "mmHg", const Color(0xFFEF4444), Icons.speed),
              _monitorCard("OKSİJEN", vitals['spo2'].toString().replaceAll("%", ""), "%", const Color(0xFF06B6D4), Icons.air),
              _monitorCard("SOLUNUM", vitals['rr'].toString().replaceAll(" /dk", ""), "/dk", const Color(0xFFEAB308), Icons.waves),
              _monitorCard("ATEŞ", vitals['temp'].toString().replaceAll(" °C", ""), "°C", const Color(0xFFF97316), Icons.thermostat),
              _monitorCard("GCS", vitals['gcs'].toString().split(" ")[0], "/15", const Color(0xFFA855F7), Icons.psychology),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.check, color: Color(0xFF0284C7)),
              label: const Text("Kapat", style: TextStyle(color: Color(0xFF0284C7), fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  Widget _monitorCard(String title, String val, String unit, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF141926),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 14),
              const SizedBox(width: 4),
              Text(title, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(val, style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(width: 4),
              Text(unit, style: const TextStyle(color: Colors.white60, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}

const String kClinicalCasesJson = r'''[
  {
    "id": "cardio_01",
    "specialty": "Kardiyoloji",
    "title": "Akut Göğüs Ağrısı ve Hipotansiyon",
    "difficulty": "Orta",
    "triage": {
      "patient_name": "Ahmet K.",
      "age": 56,
      "gender": "Erkek",
      "chief_complaint": "Sol kola yayılan ezici göğüs ağrısı, soğuk terleme, bulantı.",
      "initial_vitals": {
        "bp": "85/55 mmHg",
        "hr": "114 /dk",
        "spo2": "%90",
        "rr": "26 /dk",
        "temp": "36.5 °C",
        "gcs": "15 (E4V5M6)",
        "condition": "Kritik"
      }
    },
    "diagnostics": [
      {
        "id": "diag_ecg",
        "name": "12 Derivasyonlu EKG",
        "result": "V1-V4 ST elevasyonu (Akut Anterior STEMI)."
      },
      {
        "id": "diag_trop",
        "name": "Kardiyak Troponin I",
        "result": "2.400 ng/L (Kritik Pozitif)."
      }
    ],
    "treatments": [
      {
        "id": "t_o2",
        "name": "Nazal Oksijen (4 L/dk)",
        "feedback": "SpO2 %97 oldu, hasta rahatladı.",
        "vitals_update": {"spo2": "%97", "rr": "18 /dk"},
        "score": 20
      },
      {
        "id": "t_pci",
        "name": "Acil Primer PCI (Anjiyo)",
        "feedback": "Damar stentle açıldı, ritim normale döndü.",
        "vitals_update": {"bp": "115/75 mmHg", "hr": "76 /dk", "condition": "Stabil"},
        "score": 50
      }
    ]
  }
]''';
