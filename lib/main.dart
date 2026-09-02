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

final List<Map<String, dynamic>> kAllCases = [
  {
    "id": "case_01",
    "specialty": "Acil Tıp",
    "title": "Sol Bacakta Şiddetli Ağrı ve Uyuşukluk",
    "difficulty": "ORTA",
    "xp": 450,
    "patient": {
      "name": "Erkek, 20 yaşında",
      "age": 20,
      "gender": "Erkek",
      "complaint": "Sol bacakta ani başlayan şiddetli ağrı ve uyuşukluk."
    },
    "initial_vitals": {
      "bp": "130/80 mmHg",
      "hr": "95 /dk",
      "spo2": "%98",
      "rr": "17 /dk",
      "temp": "36.8 °C",
      "gcs": "15/15",
      "condition": "Semptomatik"
    },
    "ongoing_test": {
      "name": "Alt Ekstremite Venöz Doppler",
      "duration": "3 dk",
      "completion": "00:15"
    },
    "diagnostics": [
      {
        "id": "doppler",
        "name": "Alt Ekstremite Venöz Doppler",
        "result": "Sol femoral ve popliteal vende tam tıkayıcı akut trombüs (DVT).",
        "time": "3 dk"
      },
      {
        "id": "ddimer",
        "name": "D-Dimer Testi",
        "result": "D-Dimer: 3.850 ng/mL (Kritik yüksek pozitif).",
        "time": "15 dk"
      },
      {
        "id": "abg",
        "name": "Arteryel Kan Gazı",
        "result": "pH: 7.42, PaO2: 95 mmHg, PaCO2: 38 mmHg (Normal sınırlar).",
        "time": "5 dk"
      }
    ],
    "treatments": [
      {
        "id": "lmwh",
        "name": "Düşük Molekül Ağırlıklı Heparin (Enoksaparin 1 mg/kg SC)",
        "feedback": "Antikoagülasyon tedavisi hızla başlandı, emboli riski kontrol altına alındı.",
        "vitals_update": {"condition": "Stabil"},
        "score": 40
      },
      {
        "id": "elevation",
        "name": "Ekstremite Elevasyonu ve İstirahat",
        "feedback": "Venöz göllenme ve bacak ödemi gerilemeye başladı.",
        "vitals_update": {},
        "score": 20
      },
      {
        "id": "wrong_massage",
        "name": "Bacağa Şiddetli Masaj ve Egzersiz",
        "feedback": "Hayati Hata! Masaj trombüsün kopmasına ve masif pulmoner emboliye yol açabilir!",
        "vitals_update": {"spo2": "%82", "condition": "Kritik Kötüleşme"},
        "score": -35
      }
    ],
    "questions": [
      {"q": "Ağrı tam olarak ne zaman ve nasıl başladı?", "a": "Bugün sabah saatlerinde aniden başladı, yürümekle şiddetleniyor."},
      {"q": "Daha önce bacakta şişlik veya pıhtı öyküsü var mı?", "a": "Hayır ilk defa oluyor, ancak 2 gün önce uzun otobüs yolculuğu yaptım."},
      {"q": "Göğüs ağrısı veya ani nefes darlığınız var mı?", "a": "Şu an göğsümde ağrı yok, sadece bacağım çok gergin ve ağrıyor."}
    ],
    "debriefing": {
      "final_diagnosis": "Derin Ven Trombozu (DVT)",
      "summary": "Tek taraflı bacak ağrısı ve şişliğinde ilk tercih renkli Doppler USG'dir. Tanı anında antikoagülan başlanmalı, bacağa masaj yapılmasından kesinlikle kaçınılmalıdır."
    }
  },
  {
    "id": "case_02",
    "specialty": "Kardiyoloji",
    "title": "Göğüste Baskı ve Soğuk Terleme",
    "difficulty": "ZOR",
    "xp": 550,
    "patient": {
      "name": "Mehmet Y.",
      "age": 58,
      "gender": "Erkek",
      "complaint": "1 saattir süren, sol kola ve çeneye yayılan baskı tarzı göğüs ağrısı."
    },
    "initial_vitals": {
      "bp": "85/55 mmHg",
      "hr": "112 /dk",
      "spo2": "%91",
      "rr": "24 /dk",
      "temp": "36.6 °C",
      "gcs": "15/15",
      "condition": "Kritik"
    },
    "ongoing_test": {
      "name": "12 Derivasyonlu EKG Çekimi",
      "duration": "1 dk",
      "completion": "00:05"
    },
    "diagnostics": [
      {
        "id": "ecg",
        "name": "12 Derivasyonlu EKG",
        "result": "V1-V4 derivasyonlarında belirgin ST elevasyonu (Akut Anterior STEMI).",
        "time": "1 dk"
      },
      {
        "id": "trop",
        "name": "Kardiyak Troponin I",
        "result": "1.450 ng/L (Kritik Pozitif).",
        "time": "15 dk"
      }
    ],
    "treatments": [
      {
        "id": "o2",
        "name": "Nazal Kanül Oksijen (4 L/dk)",
        "feedback": "SpO2 %97 seviyesine ulaştı.",
        "vitals_update": {"spo2": "%97", "rr": "18 /dk"},
        "score": 20
      },
      {
        "id": "antiplatelet",
        "name": "Aspirin 300 mg + Klopidogrel 300 mg",
        "feedback": "Trombosit agregasyon inhibisyonu sağlandı.",
        "vitals_update": {},
        "score": 25
      },
      {
        "id": "pci",
        "name": "Acil Primer PCI (Anjiyo Kateter Laboratuvarı)",
        "feedback": "LAD tam tıkalı bulundu, stent takılarak reperfüzyon sağlandı.",
        "vitals_update": {"bp": "115/75 mmHg", "hr": "76 /dk", "condition": "Stabil"},
        "score": 50
      }
    ],
    "questions": [
      {"q": "Ağrı sırta veya çeneye yayılıyor mu?", "a": "Evet, sol kolum ve çeneme doğru çok şiddetli vuruyor."},
      {"q": "Daha önce kalp rahatsızlığınız var mıydı?", "a": "Tansiyonum vardı, günde 1 paket sigara içiyorum."}
    ],
    "debriefing": {
      "final_diagnosis": "Akut Anterior STEMI",
      "summary": "Göğüs ağrısıyla başvuran hastada ilk 10 dakikada EKG çekilmeli, antiplatelet verilmeli ve primer PCI'a alınmalıdır."
    }
  },
  {
    "id": "case_03",
    "specialty": "Nöroloji",
    "title": "Ani Sağ Kol Kuvvetsizliği ve Afazi",
    "difficulty": "ZOR",
    "xp": 550,
    "patient": {
      "name": "Fatma D.",
      "age": 68,
      "gender": "Kadın",
      "complaint": "45 dakika önce aniden gelişen konuşamama ve sağ kolda güç kaybı."
    },
    "initial_vitals": {
      "bp": "170/95 mmHg",
      "hr": "105 /dk",
      "spo2": "%96",
      "rr": "18 /dk",
      "temp": "36.7 °C",
      "gcs": "11/15",
      "condition": "Kritik"
    },
    "ongoing_test": {
      "name": "Acil Kontrassız Beyin BT",
      "duration": "4 dk",
      "completion": "00:10"
    },
    "diagnostics": [
      {
        "id": "ct",
        "name": "Acil Kontrassız Beyin BT",
        "result": "Hemoraji yok. Sol MCA sulkuslarında erken silinme.",
        "time": "4 dk"
      },
      {
        "id": "glucose",
        "name": "Parmak Ucu Kan Şekeri",
        "result": "114 mg/dL (Hipoglisemi ekarte edildi).",
        "time": "1 dk"
      }
    ],
    "treatments": [
      {
        "id": "rtpa",
        "name": "IV Trombolitik (Alteplaz / rtPA) Uygulaması",
        "feedback": "İlk 4.5 saatlik altın pencerede tromboliz uygulandı, motor defisit gerilemeye başladı.",
        "vitals_update": {"gcs": "14/15", "condition": "Stabil"},
        "score": 50
      }
    ],
    "questions": [
      {"q": "Belirtiler tam olarak saat kaçta başladı?", "a": "Yaklaşık 45 dakika önce kahvaltı yaparken bardağı elinden düşürdü."},
      {"q": "Düzenli kullandığı kan sulandırıcı ilaç var mı?", "a": "Kalp ritim bozukluğu için hap verilmişti ama son 1 haftadır içmiyordu."}
    ],
    "debriefing": {
      "final_diagnosis": "Akut İskemik İnme (Sol MCA)",
      "summary": "Kanamayı ekarte etmek için ilk iş kontrassız BT çekilmeli ve ilk 4.5 saat içinde trombolitik tedavi uygulanmalıdır."
    }
  },
  {
    "id": "case_04",
    "specialty": "Pediatri",
    "title": "Ateşli Çocukta Nöbet ve Bilinç Değişikliği",
    "difficulty": "KOLAY",
    "xp": 350,
    "patient": {
      "name": "Ali E.",
      "age": 2,
      "gender": "Erkek",
      "complaint": "Yüksek ateş sonrası tüm vücutta kasılma ve gözlerde yukarı kayma."
    },
    "initial_vitals": {
      "bp": "95/60 mmHg",
      "hr": "145 /dk",
      "spo2": "%98",
      "rr": "28 /dk",
      "temp": "39.4 °C",
      "gcs": "13/15",
      "condition": "Orta"
    },
    "ongoing_test": {
      "name": "Ense Sertliği ve KBB Muayenesi",
      "duration": "2 dk",
      "completion": "00:08"
    },
    "diagnostics": [
      {
        "id": "ped_exam",
        "name": "Menenjit Muayenesi (Ense Sertliği)",
        "result": "Ense sertliği negatif, fontanel kabarık değil.",
        "time": "2 dk"
      },
      {
        "id": "ent",
        "name": "Otoskopik Muayene",
        "result": "Bilateral timpanik membran hiperemik (Akut Otitis Media).",
        "time": "2 dk"
      }
    ],
    "treatments": [
      {
        "id": "antipyretic",
        "name": "IV Parasetamol + Fiziksel Soğutma",
        "feedback": "Ateş kademeli olarak düştü, çocuk çevreyle göz teması kurmaya başladı.",
        "vitals_update": {"temp": "37.3 °C", "hr": "110 /dk", "gcs": "15/15", "condition": "Stabil"},
        "score": 40
      }
    ],
    "questions": [
      {"q": "Nöbet ne kadar sürdü?", "a": "Yaklaşık 1.5 - 2 dakika sürdü sonra kendiliğinden durdu."},
      {"q": "Daha önce hiç nöbet geçirmiş miydi?", "a": "Hayır, ilk defa oldu. 2 gündür hafif ateşi ve burun akıntısı vardı."}
    ],
    "debriefing": {
      "final_diagnosis": "Basit Febril Konvülsiyon",
      "summary": "Febril konvülsiyonlarda menenjit ekarte edildikten sonra ateş kontrolü sağlanmalı ve aileye selim doğası anlatılmalıdır."
    }
  }
];

final List<Map<String, String>> kClinicalCodex = [
  {"title": "12 Derivasyonlu EKG", "type": "Görüntüleme", "desc": "STEMI, aritmi, dal blokları ve iskemi değerlendirmesinde ilk 10 dakikada çekilmelidir."},
  {"title": "Yüksek Duyarlıklı Troponin", "type": "Laboratuvar", "desc": "Miyokard nekrozunun en duyarlı belirtecidir. 0. ve 3. saat takipleri önerilir."},
  {"title": "Arteryel Kan Gazı (AKG)", "type": "Laboratuvar", "desc": "pH, PaO2, PaCO2, HCO3 ve laktat ölçümüyle solunumsal ve metabolik asidoz değerlendirilir."},
  {"title": "Beyin BT (Kontrassız)", "type": "Görüntüleme", "desc": "Akut inme ve kafa travmasında intrakraniyal kanamayı ekarte etmek için altın standarttır."},
  {"title": "Toraks BT Anjiyo (BTPA)", "type": "Görüntüleme", "desc": "Pulmoner tromboemboli (PTE) kesin tanısında dolum defektlerini saptar."},
  {"title": "Aspirin (Asetilsalisilik Asit)", "type": "İlaç", "desc": "Akut koroner sendromda 150-300 mg çiğnetilerek verilen temel trombosit inhibitörüdür."},
  {"title": "Nalokson", "type": "Antidot", "desc": "Opioid aşırı dozunda (solunum depresyonu ve miyozis) IV/IM uygulanan kompetitif antagonisttir."},
  {"title": "Noradrenalin (Norepinefrin)", "type": "Vazopressör", "desc": "Septik ve vazodilatuv şokta ilk tercih vazopressördür (MAP > 65 hedefi)."}
];

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
    const CodexScreen(),
    const MyCasesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10)],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (idx) => setState(() => _currentIndex = idx),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF6366F1),
          unselectedItemColor: Colors.grey.shade400,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
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
                Text("Dr. Samo", style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold)),
                Text("Lv.6", style: TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFFFFEDD5), borderRadius: BorderRadius.circular(20)),
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
                    child: const LinearProgressIndicator(value: 0.25, backgroundColor: Color(0xFFF1F5F9), color: Color(0xFF0284C7), minHeight: 6),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProcedureRoomScreen(caseData: kAllCases[0])));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black.withOpacity(0.04))),
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
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateCaseWizardScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black.withOpacity(0.04))),
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
                ),
              ],
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CodexScreen()));
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black.withOpacity(0.04))),
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
                return InkWell(
                  onTap: () {
                    final matchingCases = kAllCases.where((c) => c['specialty'] == item['name']).toList();
                    final targetCase = matchingCases.isNotEmpty ? matchingCases.first : kAllCases.first;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProcedureRoomScreen(caseData: targetCase)));
                  },
                  child: Container(
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CodexScreen extends StatelessWidget {
  const CodexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Klinik Kodeks", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: kClinicalCodex.length,
        itemBuilder: (context, idx) {
          final item = kClinicalCodex[idx];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(8)),
                        child: Text(item['type']!, style: const TextStyle(fontSize: 11, color: Color(0xFF4F46E5), fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(item['desc']!, style: const TextStyle(color: Colors.black87, fontSize: 13, height: 1.3)),
                ],
              ),
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: const Color(0xFFEDE9FE), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.folder_shared_rounded, color: Color(0xFF7C3AED), size: 20),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Vakalarım", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("Şu an 4", style: TextStyle(color: Colors.grey, fontSize: 11)),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_box_rounded, color: Color(0xFF6366F1), size: 28),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateCaseWizardScreen()));
              },
            )
          ],
          bottom: const TabBar(
            indicatorColor: Color(0xFF6366F1),
            labelColor: Color(0xFF6366F1),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Kaydedilenler"),
              Tab(text: "Oluşturduklarım"),
              Tab(text: "Geçmiş"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCasesGrid(context, kAllCases),
            _buildCasesGrid(context, [kAllCases[0], kAllCases]),
            _buildCasesGrid(context, [kAllCases[1]]),
          ],
        ),
      ),
    );
  }

  Widget _buildCasesGrid(BuildContext context, List<Map<String, dynamic>> caseList) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: caseList.length,
      itemBuilder: (context, idx) {
        final c = caseList[idx];
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProcedureRoomScreen(caseData: c)));
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: c['difficulty'] == "ZOR" ? const Color(0xFFFCA5A5) : const Color(0xFFFDE68A)),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: c['difficulty'] == "ZOR" ? const Color(0xFFFEE2E2) : const Color(0xFFFEF9C3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.biotech, color: c['difficulty'] == "ZOR" ? Colors.red : Colors.orange, size: 22),
                  ),
                ),
                Text(
                  "${c['patient']['name']} - ${c['patient']['complaint']}",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, height: 1.3, color: Colors.black87),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: c['difficulty'] == "ZOR" ? Colors.red.shade100 : Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(c['difficulty'], style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: c['difficulty'] == "ZOR" ? Colors.red.shade800 : Colors.amber.shade900)),
                    ),
                    Text("${c['xp']} XP", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.orange)),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CreateCaseWizardScreen extends StatefulWidget {
  const CreateCaseWizardScreen({super.key});

  @override
  State<CreateCaseWizardScreen> createState() => _CreateCaseWizardScreenState();
}

class _CreateCaseWizardScreenState extends State<CreateCaseWizardScreen> {
  final _titleController = TextEditingController();
  final _complaintController = TextEditingController();
  String _selectedSpec = "Kardiyoloji";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        title: const Text("Kendi Vakanı Yaz", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.chevron_left, color: Colors.black87), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Vaka Başlığı", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: "Örn: Ani Göğüs Ağrısı", filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
            ),
            const SizedBox(height: 16),
            const Text("Uzmanlık Alanı", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: DropdownButton<String>(
                value: _selectedSpec,
                isExpanded: true,
                underline: const SizedBox(),
                items: ["Kardiyoloji", "Nöroloji", "Acil Tıp", "Pediatri", "Dahiliye"].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (v) => setState(() => _selectedSpec = v!),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Hasta Hikayesi ve Şikayeti", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextField(
              controller: _complaintController,
              maxLines: 4,
              decoration: InputDecoration(hintText: "Hastanın yaşını, şikayetini ve hikayesini yazın...", filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), padding: const EdgeInsets.all(14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vakanız başarıyla kaydedildi!")));
                  Navigator.pop(context);
                },
                child: const Text("Vakayı Yayınla", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
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
    vitals = Map<String, dynamic>.from(widget.caseData['initial_vitals']);
    logs.add({
      "title": "Vaka Başladı",
      "time": "00:00",
      "icon": Icons.info_outline,
      "color": Colors.grey,
      "content": "${widget.caseData['patient']['name']} - ${widget.caseData['patient']['complaint']}"
    });
    logs.add({
      "title": "İlk Değerlendirme",
      "time": "00:00",
      "icon": Icons.touch_app_outlined,
      "color": Colors.amber,
      "content": "Durum: ${vitals['condition']} | Stabilite: %$stability\nNabız: ${vitals['hr']}, TA: ${vitals['bp']}, SpO2: ${vitals['spo2']}, Ateş: ${vitals['temp']}"
    });
    if (widget.caseData.containsKey('ongoing_test')) {
      final ot = widget.caseData['ongoing_test'];
      logs.add({
        "title": "Tetkik Başlatıldı",
        "time": "00:12",
        "icon": Icons.hourglass_top_rounded,
        "color": const Color(0xFF6366F1),
        "content": "${ot['name']}\nTahmini süre: ${ot['duration']} • Tamamlanma: ${ot['completion']}"
      });
    }
  }

  void _openMonitor() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => MonitorBottomSheet(vitals: vitals),
    );
  }

  void _openQuestionsModal() {
    final qs = widget.caseData['questions'] as List? ?? [];
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
            const Row(
              children: [
                Icon(Icons.chat_bubble_outline_rounded, color: Color(0xFF0284C7)),
                SizedBox(width: 8),
                Text("Hastaya Soru Sor (Anamnez)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            ...qs.map((q) => Card(
              color: const Color(0xFFF0F9FF),
              margin: const EdgeInsets.only(bottom: 8),
              child:
