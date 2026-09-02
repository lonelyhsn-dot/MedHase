import 'package:flutter/material.dart';

void main() => runApp(const MedCaseApp());

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6366F1)),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

// -------------------------------------------------------------
// VAKA VERİLERİ (TÜM BRANŞLAR)
// -------------------------------------------------------------
final List<Map<String, dynamic>> kCases = [
  {
    "title": "Sol Bacakta Şiddetli Ağrı ve Uyuşukluk",
    "specialty": "Acil Tıp",
    "diff": "ORTA",
    "xp": "450 XP",
    "patient": "Erkek, 20 yaşında - Sol bacakta ani başlayan şiddetli ağrı ve uyuşukluk.",
    "test_ongoing": "Alt Ekstremite Venöz Doppler",
    "vitals": {"hr": "96", "bp": "128/80", "spo2": "97", "rr": "17", "temp": "36.9", "gcs": "15/15", "status": "Semptomatik"},
    "tests": [
      {"name": "Alt Ekstremite Venöz Doppler", "res": "Sol femoral ve popliteal vende tam tıkayıcı DVT."},
      {"name": "D-Dimer Testi", "res": "3.850 ng/mL (Kritik Pozitif)."},
      {"name": "Arteryel Kan Gazı", "res": "pH: 7.42, PaO2: 95 mmHg (Normal)."}
    ],
    "treatments": [
      {"name": "Enoksaparin (LMWH) 1 mg/kg SC", "feed": "Antikoagülasyon başlandı, emboli önlendi.", "score": 40},
      {"name": "Bacağa Şiddetli Masaj (Hatalı)", "feed": "Hayati Hata! Masaj masif pulmoner emboliye yol açar!", "score": -40},
      {"name": "Ekstremite Elevasyonu", "feed": "Venöz dönüş rahatlatıldı.", "score": 20}
    ],
    "questions": [
      {"q": "Ağrı ne zaman başladı?", "a": "Sabah aniden başladı, yürüyünce artıyor."},
      {"q": "Nefes darlığınız var mı?", "a": "Şu an göğsümde ağrı veya nefes darlığı yok."}
    ],
    "diag": "Derin Ven Trombozu (DVT)"
  },
  {
    "title": "Göğüste Baskı ve Soğuk Terleme",
    "specialty": "Kardiyoloji",
    "diff": "ZOR",
    "xp": "550 XP",
    "patient": "Erkek, 58 yaşında - Sol kola yayılan ezici göğüs ağrısı.",
    "test_ongoing": "12 Derivasyonlu EKG Çekimi",
    "vitals": {"hr": "112", "bp": "85/55", "spo2": "91", "rr": "24", "temp": "36.6", "gcs": "15/15", "status": "Kritik"},
    "tests": [
      {"name": "12 Derivasyonlu EKG", "res": "V1-V4 derivasyonlarında ST elevasyonu (STEMI)."},
      {"name": "Troponin I", "res": "1.450 ng/L (Kritik Yüksek)."}
    ],
    "treatments": [
      {"name": "Aspirin 300mg + Klopidogrel 300mg", "feed": "Antiplatelet tedavi verildi.", "score": 30},
      {"name": "Acil Primer PCI (Anjiyo)", "feed": "LAD stentlendi, akım sağlandı.", "score": 50}
    ],
    "questions": [
      {"q": "Ağrı nereye vuruyor?", "a": "Sol kolum ve çeneme doğru baskı yapıyor."}
    ],
    "diag": "Akut Anterior STEMI"
  },
  {
    "title": "Ani Sağ Taraf Güçsüzlüğü ve Afazi",
    "specialty": "Nöroloji",
    "diff": "ZOR",
    "xp": "550 XP",
    "patient": "Kadın, 68 yaşında - Sağ kolda felç ve konuşamama.",
    "test_ongoing": "Acil Kontrassız Beyin BT",
    "vitals": {"hr": "105", "bp": "170/95", "spo2": "96", "rr": "18", "temp": "36.7", "gcs": "11/15", "status": "Kritik"},
    "tests": [
      {"name": "Beyin BT", "res": "Hemoraji yok. Erken iskemik bulgular."},
      {"name": "Kan Şekeri", "res": "114 mg/dL (Normal)."}
    ],
    "treatments": [
      {"name": "IV Trombolitik (rtPA)", "feed": "İlk 4.5 saatte tromboliz yapıldı.", "score": 50}
    ],
    "questions": [
      {"q": "Ne zaman başladı?", "a": "45 dakika önce kahvaltıda başladı."}
    ],
    "diag": "Akut İskemik İnme"
  },
  {
    "title": "Ateşli Çocukta Nöbet",
    "specialty": "Pediatri",
    "diff": "KOLAY",
    "xp": "350 XP",
    "patient": "Erkek, 2 yaşında - Yüksek ateş sonrası kasılma nöbeti.",
    "test_ongoing": "Ense Sertliği Muayenesi",
    "vitals": {"hr": "140", "bp": "95/60", "spo2": "98", "rr": "28", "temp": "39.4", "gcs": "13/15", "status": "Orta"},
    "tests": [
      {"name": "Menenjit Muayenesi", "res": "Ense sertliği negatif."},
      {"name": "KBB Muayenesi", "res": "Akut Otitis Media."}
    ],
    "treatments": [
      {"name": "IV Parasetamol", "feed": "Ateş düştü, çocuk rahatladı.", "score": 40}
    ],
    "questions": [
      {"q": "Nöbet ne kadar sürdü?", "a": "Yaklaşık 1.5 dakika sürdü."}
    ],
    "diag": "Basit Febril Konvülsiyon"
  }
];

// -------------------------------------------------------------
// NAVİGASYON (ALT MENÜ)
// -------------------------------------------------------------
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});
  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _idx = 0;
  final List<Widget> _pages = const [
    HomeScreen(),
    SpecialtiesScreen(),
    CodexScreen(),
    MyCasesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_idx],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
        child: BottomNavigationBar(
          currentIndex: _idx,
          onTap: (i) => setState(() => _idx = i),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF6366F1),
          unselectedItemColor: Colors.grey.shade400,
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

// -------------------------------------------------------------
// 1. ANA SAYFA (EKRAN 3)
// -------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
          children: [
            CircleAvatar(backgroundColor: Color(0xFFE0E7FF), child: Icon(Icons.person, color: Color(0xFF4F46E5))),
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Dr. Samo", style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Lv.6", style: TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold)),
            ]),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFFFFEDD5), borderRadius: BorderRadius.circular(20)),
            child: const Row(children: [
              Icon(Icons.local_fire_department, color: Colors.deepOrange, size: 18),
              SizedBox(width: 4),
              Text("Bugün", style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 13)),
            ]),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Doktor Seviye Kartı
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFFEF08A), width: 1.5)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(color: const Color(0xFFFEF9C3), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFFACC15))),
                        child: const Center(child: Text("6", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF854D0E)))),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("Pratisyen Hekim", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Text("Lv.7 için 9110 XP kaldı", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ]),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: const Color(0xFFE0F2FE), borderRadius: BorderRadius.circular(20)),
                        child: const Text("⚡ +150 XP", style: TextStyle(color: Color(0xFF0284C7), fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const LinearProgressIndicator(value: 0.25, backgroundColor: Color(0xFFF1F5F9), color: Color(0xFF0284C7), minHeight: 6),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(10)),
                          child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Icon(Icons.verified, color: Color(0xFF16A34A), size: 16),
                            SizedBox(width: 6),
                            Text("15 Toplam Tanı", style: TextStyle(color: Color(0xFF16A34A), fontWeight: FontWeight.bold, fontSize: 12)),
                          ]),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(10)),
                          child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Icon(Icons.pie_chart, color: Color(0xFFD97706), size: 16),
                            SizedBox(width: 6),
                            Text("%60 Doğruluk", style: TextStyle(color: Color(0xFFD97706), fontWeight: FontWeight.bold, fontSize: 12)),
                          ]),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Hemen Oyna & Vaka Oluştur
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProcedureRoomScreen(caseData: kCases[0]))),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black.withOpacity(0.04))),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFFE0F2FE), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.sports_esports_rounded, color: Color(0xFF0284C7))),
                        const SizedBox(height: 12),
                        const Text("Hemen Oyna", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 4),
                        const Text("Klinik becerilerini test et!", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateCaseWizardScreen())),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black.withOpacity(0.04))),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFFFFEDD5), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.mode_edit_rounded, color: Color(0xFFEA580C))),
                        const SizedBox(height: 12),
                        const Text("Vaka Oluştur", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 4),
                        const Text("Kendi vakanı yaz", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Kodeks Kartı
            InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CodexScreen())),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black.withOpacity(0.04))),
                child: Row(
                  children: [
                    Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFFE0F2FE), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.menu_book_rounded, color: Color(0xFF0284C7))),
                    const SizedBox(width: 12),
                    const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text("Klinik Kodeks", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      Text("Tüm tetkik ve tedavilerin ansiklopedisi", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ])),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// 2. KEŞFET (EKRAN 4)
// -------------------------------------------------------------
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Tüm Uzmanlık Alanları", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Uzmanlık alanı ara...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.15),
              itemCount: list.length,
              itemBuilder: (context, i) {
                final item = list[i];
                final clr = item['color'] as Color;
                return InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProcedureRoomScreen(caseData: kCases[i % kCases.length]))),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.black.withOpacity(0.04))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: clr.withOpacity(0.12), borderRadius: BorderRadius.circular(12)), child: Icon(item['icon'] as IconData, color: clr, size: 22)),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(item['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(height: 2),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text(item['cases'] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            const Icon(Icons.arrow_forward_rounded, size: 14, color: Colors.grey),
                          ])
                        ])
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// 3. KODEKS (ANSİKLOPEDİ)
// -------------------------------------------------------------
class CodexScreen extends StatelessWidget {
  const CodexScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final list = [
      {"t": "12 Derivasyonlu EKG", "type": "Görüntüleme", "d": "STEMI ve aritmilerde ilk 10 dakikada çekilmelidir."},
      {"t": "Kardiyak Troponin", "type": "Laboratuvar", "d": "Miyokard nekrozunun en duyarlı belirtecidir."},
      {"t": "Kan Gazı (AKG)", "type": "Laboratuvar", "d": "pH, oksijenasyon ve asidoz tablosunu belirler."},
      {"t": "Beyin BT (Kontrassız)", "type": "Görüntüleme", "d": "Akut inmede kanamayı dışlamak için altın standarttır."},
      {"t": "Enoksaparin (LMWH)", "type": "İlaç", "d": "DVT ve emboli tedavisinde standart antikoagülandır."},
      {"t": "Aspirin 300 mg", "type": "İlaç", "d": "Akut koroner sendromda temel antiplatelet ajandır."}
    ];

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, title: const Text("Klinik Kodeks", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold))),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        itemBuilder: (context, i) => Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.white,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(list[i]['t']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(8)), child: Text(list[i]['type']!, style: const TextStyle(fontSize: 11, color: Color(0xFF4F46E5), fontWeight: FontWeight.bold))),
              ]),
              const SizedBox(height: 8),
              Text(list[i]['d']!, style: const TextStyle(color: Colors.black87, fontSize: 13)),
            ]),
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// 4. VAKALARIM (EKRAN 5)
// -------------------------------------------------------------
class MyCasesScreen extends StatelessWidget {
  const MyCasesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(children: [
            Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFFEDE9FE), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.folder_shared_rounded, color: Color(0xFF7C3AED), size: 20)),
            const SizedBox(width: 10),
            const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Vakalarım", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16)),
              Text("Şu an 4", style: TextStyle(color: Colors.grey, fontSize: 11)),
            ]),
          ]),
          actions: [
            IconButton(icon: const Icon(Icons.add_box_rounded, color: Color(0xFF6366F1), size: 28), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateCaseWizardScreen()))),
          ],
          bottom: const TabBar(
            indicatorColor: Color(0xFF6366F1),
            labelColor: Color(0xFF6366F1),
            unselectedLabelColor: Colors.grey,
            tabs: [Tab(text: "Kaydedilenler"), Tab(text: "Oluşturduklarım"), Tab(text: "Geçmiş")],
          ),
        ),
        body: TabBarView(
          children: [
            _buildGrid(context, kCases),
            _buildGrid(context, kCases),
            _buildGrid(context, kCases),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<Map<String, dynamic>> list) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.85),
      itemCount: list.length,
      itemBuilder: (context, i) {
        final c = list[i];
        final isHard = c['diff'] == "ZOR";
        return InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProcedureRoomScreen(caseData: c))),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: isHard ? const Color(0xFFFCA5A5) : const Color(0xFFFDE68A))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: isHard ? const Color(0xFFFEE2E2) : const Color(0xFFFEF9C3), shape: BoxShape.circle), child: Icon(Icons.biotech, color: isHard ? Colors.red : Colors.orange, size: 22))),
                Text(c['patient'] as String, maxLines: 4, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Colors.black87)),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: isHard ? Colors.red.shade100 : Colors.amber.shade100, borderRadius: BorderRadius.circular(6)), child: Text(c['diff'] as String, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isHard ? Colors.red.shade800 : Colors.amber.shade900))),
                  Text(c['xp'] as String, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.orange)),
                ])
              ],
            ),
          ),
        );
      },
    );
  }
}

// -------------------------------------------------------------
// 5. VAKA OLUŞTURMA SİHİRBAZI
// -------------------------------------------------------------
class CreateCaseWizardScreen extends StatelessWidget {
  const CreateCaseWizardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kendi Vakanı Yaz", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)), backgroundColor: Colors.white, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Vaka Başlığı", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          TextField(decoration: InputDecoration(hintText: "Örn: Akut Karın Ağrısı", filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
          const SizedBox(height: 16),
          const Text("Hasta Şikayeti", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          TextField(maxLines: 4, decoration: InputDecoration(hintText: "Hastanın hikayesini girin...", filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), padding: const EdgeInsets.all(14)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vaka başarıyla kaydedildi!")));
                Navigator.pop(context);
              },
              child: const Text("Vakayı Yayınla", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          )
        ]),
      ),
    );
  }
}

// -------------------------------------------------------------
// 6. MÜDAHALE ODASI (EKRAN 1)
// -------------------------------------------------------------
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
  final Set<String> doneTests = {};
  final Set<String> doneTrts = {};

  @override
  void initState() {
    super.initState();
    vitals = Map<String, dynamic>.from(widget.caseData['vitals']);
    logs.add({
      "t": "Vaka Başladı",
      "tm": "00:00",
      "c": Colors.grey,
      "i": Icons.info_outline,
      "m": widget.caseData['patient']
    });
    logs.add({
      "t": "İlk Değerlendirme",
      "tm": "00:00",
      "c": Colors.amber,
      "i": Icons.touch_app_outlined,
      "m": "Durum: ${vitals['status']} | Stabilite: %$stability\nNabız: ${vitals['hr']}/dk, TA: ${vitals['bp']}, SpO2: %${vitals['spo2']}, Ateş: ${vitals['temp']}°C"
    });
    if (widget.caseData.containsKey('test_ongoing')) {
      logs.add({
        "t": "Tetkik Başlatıldı",
        "tm": "00:12",
        "c": const Color(0xFF6366F1),
        "i": Icons.hourglass_top_rounded,
        "m": "${widget.caseData['test_ongoing']}\nTahmini süre: 3 dk • Tamamlanma: 00:15"
      });
    }
  }

  void _openMonitor() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => MonitorBottomSheet(vitals: vitals),
    );
  }

  void _openQuestions() {
    final qs = widget.caseData['questions'] as List? ?? [];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Hastaya Soru Sor (Anamnez)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...qs.map((q) => Card(color: const Color(0xFFF0F9FF), child: ListTile(title: Text(q['q']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), subtitle: Text(q['a']!, style: const TextStyle(fontSize: 12))))),
        ]),
      ),
    );
  }

  void _openTests() {
    final tests = widget.caseData['tests'] as List;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("İstenebilecek Tetkikler", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...tests.map((t) {
              final isDone = doneTests.contains(t['name']);
              return Card(
                color: const Color(0xFFF8FAFC),
                child: ListTile(
                  title: Text(t['name']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  subtitle: isDone ? Text("Sonuç: ${t['res']!}", style: const TextStyle(color: Color(0xFF0D9488), fontSize: 12)) : null,
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: isDone ? Colors.grey : const Color(0xFF6366F1)),
                    onPressed: isDone ? null : () {
                      setState(() {
                        doneTests.add(t['name']!);
                        logs.add({"t": "Tetkik Tamamlandı", "tm": "00:15", "c": const Color(0xFF6366F1), "i": Icons.biotech, "m": "${t['name']!}\nSonuç: ${t['res']!}"});
                      });
                      setModalState(() {});
                    },
                    child: Text(isDone ? "Görüldü" : "İste"),
                  ),
                ),
              );
            })
          ]),
        ),
      ),
    );
  }

  void _openTreatments() {
    final trts = widget.caseData['treatments'] as List;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Tedavi & Müdahale Seçenekleri", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...trts.map((t) {
            final isDone = doneTrts.contains(t['name']);
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(14), side: BorderSide(color: isDone ? Colors.grey : const Color(0xFF6366F1))),
                onPressed: isDone ? null : () {
                  Navigator.pop(context);
                  setState(() {
                    doneTrts.add(t['name']);
                    final isGood = (t['score'] as int) > 0;
                    stability = isGood ? 100 : (stability - 30).clamp(10, 100);
                    logs.add({"t": "Müdahale Yapıldı", "tm": "00:20", "c": isGood ? Colors.green : Colors.red, "i": Icons.medication, "m": "${t['name']}\n${t['feed']}"});
                  });
                },
                child: Row(children: [
                  Icon(isDone ? Icons.check : Icons.play_arrow, color: isDone ? Colors.grey : const Color(0xFF6366F1), size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(t['name'], style: TextStyle(color: isDone ? Colors.grey : Colors.black87, fontSize: 13))),
                ]),
              ),
            );
          })
        ]),
      ),
    );
  }

  void _finishCase() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.verified_rounded, color: Colors.green, size: 48),
          const SizedBox(height: 10),
          const Text("Hasta Taburcu Edildi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text("Nihai Teşhis: ${widget.caseData['diag']}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4F46E5))),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), padding: const EdgeInsets.all(14)),
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              child: const Text("Vaka Listesine Dön", style: TextStyle(color: Colors.white)),
            ),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.chevron_left, color: Colors.black87, size: 28), onPressed: () => Navigator.pop(context)),
        title: Row(children: [
          Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Color(0xFFFEE2E2), shape: BoxShape.circle), child: const Icon(Icons.emergency, color: Colors.red, size: 16)),
          const SizedBox(width: 8),
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Müdahale Odası", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16)),
            Row(children: [
              Icon(Icons.timer_outlined, size: 12, color: Colors.grey),
              SizedBox(width: 4),
              Text("00:12", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ]),
          ]),
        ]),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(width: 46, height: 46, child: CircularProgressIndicator(value: stability / 100, strokeWidth: 3, backgroundColor: Colors.grey.shade200, valueColor: AlwaysStoppedAnimation<Color>(stability > 50 ? const Color(0xFF22C55E) : Colors.red))),
                CircleAvatar(radius: 18, backgroundColor: stability > 50 ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2), child: Text("$stability%", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: stability > 50 ? const Color(0xFF16A34A) : Colors.red))),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Segmented Buttons (Tetkik, Tedavi, Taburcu)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(children: [
              InkWell(onTap: _openTests, child: _pill("Tetkik", Icons.biotech, true)),
              const SizedBox(width: 8),
              InkWell(onTap: _openTreatments, child: _pill("Tedavi", Icons.medication, false)),
              const SizedBox(width: 8),
              InkWell(onTap: _finishCase, child: _pill("Taburcu", Icons.exit_to_app, false)),
            ]),
          ),

          // Devam Eden İşlemler
          if (widget.caseData.containsKey('test_ongoing'))
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFC7D2FE))),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFF99F6E4), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.person_search, color: Color(0xFF0D9488), size: 16)),
                  const SizedBox(width: 8),
                  Text(widget.caseData['test_ongoing'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ]),
                const Text("3 dk", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ]),
            ),

          // Zaman Tüneli
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: logs.length,
              itemBuilder: (context, i) {
                final log = logs[i];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(children: [
                      Container(width: 32, height: 32, decoration: BoxDecoration(color: (log['c'] as Color).withOpacity(0.15), shape: BoxShape.circle), child: Icon(log['i'] as IconData, size: 18, color: log['c'] as Color)),
                      if (i != logs.length - 1) Container(width: 2, height: 65, color: Colors.grey.shade300),
                    ]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.black.withOpacity(0.04))),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text(log['t'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            Text("⏱ ${log['tm']}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          ]),
                          const SizedBox(height: 6),
                          Text(log['m'] as String, style: const TextStyle(color: Colors.black87, fontSize: 13, height: 1.3)),
                        ]),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Alt Dock (Soru, Tetkik, Kons., Monitör)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.vertical(top: Radius.circular(24)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10)]),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              _dock("Soru", Icons.chat_bubble_outline_rounded, const Color(0xFFE0F2FE), const Color(0xFF0284C7), _openQuestions),
              _dock("Tetkik", Icons.biotech, const Color(0xFFEDE9FE), const Color(0xFF7C3AED), _openTests),
              _dock("Kons.", Icons.group_outlined, const Color(0xFFFFEDD5), const Color(0xFFEA580C), _openTreatments),
              _dock("Monitör", Icons.monitor_heart_outlined, const Color(0xFFDCFCE7), const Color(0xFF16A34A), _openMonitor),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _pill(String t, IconData ic, bool act) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: act ? const Color(0xFFEDE9FE) : Colors.transparent, borderRadius: BorderRadius.circular(20)),
      child: Row(children: [
        Icon(ic, size: 16, color: act ? const Color(0xFF6D28D9) : Colors.grey),
        const SizedBox(width: 6),
        Text(t, style: TextStyle(color: act ? const Color(0xFF6D28D9) : Colors.grey, fontWeight: act ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
      ]),
    );
  }

  Widget _dock(String t, IconData ic, Color bg, Color clr, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)), child: Icon(ic, color: clr, size: 24)),
        const SizedBox(height: 4),
        Text(t, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
      ]),
    );
  }
}

// -------------------------------------------------------------
// 7. HASTA MONİTÖRÜ MODALI (EKRAN 2)
// -------------------------------------------------------------
class MonitorBottomSheet extends StatelessWidget {
  final Map<String, dynamic> vitals;
  const MonitorBottomSheet({super.key, required this.vitals});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFFFEF9C3), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.show_chart, color: Color(0xFFCA8A04), size: 20)),
            const SizedBox(width: 10),
            const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("HASTA MONİTÖRÜ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("6 parametre izleniyor", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ]),
          ]),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
            children: [
              _tile("KALP HIZI", vitals['hr'] ?? "96", "bpm", const Color(0xFF22C55E), Icons.favorite),
              _tile("KAN BASINCI", vitals['bp'] ?? "128/80", "mmHg", const Color(0xFFEF4444), Icons.speed),
              _tile("OKSİJEN", vitals['spo2'] ?? "97", "%", const Color(0xFF06B6D4), Icons.air),
              _tile("SOLUNUM", vitals['rr'] ?? "17", "/dk", const Color(0xFFEAB308), Icons.waves),
              _tile("ATEŞ", vitals['temp'] ?? "36.9", "°C", const Color(0xFFF97316), Icons.thermostat),
              _tile("GCS", vitals['gcs'] ?? "15/15", "", const Color(0xFFA855F7), Icons.psychology),
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

  Widget _tile(String t, String v, String u, Color c, IconData ic) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF141926), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [Icon(ic, color: c, size: 14), const SizedBox(width: 4), Text(t, style: TextStyle(color: c, fontSize: 10, fontWeight: FontWeight.bold))]),
          Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
            Text(v, style: TextStyle(color: c, fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(width: 4),
            Text(u, style: const TextStyle(color: Colors.white60, fontSize: 11)),
          ]),
        ],
      ),
    );
  }
}
