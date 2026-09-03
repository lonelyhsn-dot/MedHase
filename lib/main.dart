import 'dart:async';
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
// KULLANICI PROFİLİ VE SİSTEM DURUMU (STATE)
// -------------------------------------------------------------
class UserProfile {
  static String name = "Dr. Burcu Çödel";
  static String title = "İntörn Doktor";
  static int level = 1;
  static int xp = 0;
  static int xpToNext = 500;
  static int totalDiagnoses = 0;
  static int correctDiagnoses = 0;

  static List<Map<String, dynamic>> userCreatedCases = [];

  static void addXp(int amount, bool isCorrect) {
    totalDiagnoses++;
    if (isCorrect) correctDiagnoses++;
    xp += amount;
    while (xp >= xpToNext) {
      xp -= xpToNext;
      level++;
      xpToNext = (xpToNext * 1.5).round();
      if (level == 2) title = "Pratisyen Hekim";
      if (level == 4) title = "Asistan Hekim";
      if (level == 7) title = "Uzman Doktor";
      if (level >= 10) title = "Klinik Şefi";
    }
  }

  static double get accuracy => totalDiagnoses == 0 ? 0.0 : (correctDiagnoses / totalDiagnoses) * 100;
}

// -------------------------------------------------------------
// KLİNİK VAKA VERİ TABANI (TÜM BRANŞLAR)
// -------------------------------------------------------------
final List<Map<String, dynamic>> kAllClinicalCases = [
  // 1. ACİL TIP - DVT
  {
    "id": "em_01",
    "specialty": "Acil Tıp",
    "title": "Sol Bacakta Ani Şiddetli Ağrı ve Şişlik",
    "difficulty": "ORTA",
    "xp": 250,
    "initial_stability": 70,
    "patient": {
      "name": "Burak Y.",
      "age": 24,
      "gender": "Erkek",
      "complaint": "Sol baldırda aniden başlayan şiddetli gerginlik, ağrı ve yürüme güçlüğü.",
      "history": "3 gün önce 14 saatlik otobüs yolculuğu yaptı. Sigara: 1 paket/gün."
    },
    "vitals": {"hr": "94", "bp": "125/80", "spo2": "98", "rr": "16", "temp": "36.8", "gcs": "15/15", "status": "Semptomatik"},
    "questions": [
      {"q": "Ağrı ne zaman ve tam olarak nerede başladı?", "a": "Sabah uyandığımda sol baldırımda taş gibi bir sertlik ve kramp benzeri şiddetli ağrı vardı."},
      {"q": "Göğüs ağrınız, çarpıntınız veya nefes darlığınız var mı?", "a": "Hayır doktor hanım, göğsüm gayet rahat sadece bacağım zonkluyor."},
      {"q": "Daha önce bacağınızda benzer şişlik veya damar pıhtısı oldu mu?", "a": "Hayır ilk kez oluyor ama uzun yolculuktan beri bacağım huzursuzdu."}
    ],
    "tests": [
      {"name": "Alt Ekstremite Venöz Renkli Doppler", "duration": 4, "res": "Sol femoral ve popliteal vende komprese olmayan akut trombüs (DVT)."},
      {"name": "D-Dimer Testi", "duration": 5, "res": "D-Dimer: 3.420 ng/mL (Kritik Pozitif)."},
      {"name": "Tam Kan Sayımı (Hemogram)", "duration": 3, "res": "Hb: 14.8 g/dL, Plt: 260.000 /uL, WBC: 7.800 /uL."}
    ],
    "treatments": [
      {
        "name": "Enoksaparin (LMWH) 1 mg/kg SC + Yatak İstirahati",
        "feed": "Antikoagülan tedavi başlandı. Trombüsün akciğere emboli atma riski baskılandı.",
        "score": 40,
        "is_correct": true,
        "vitals_update": {"status": "Stabil"},
        "stability_delta": 25
      },
      {
        "name": "Sol Bacağa Sıcak Uygulama ve Derin Doku Masajı",
        "feed": "Kritik Klinik Hata! Masaj derin ven trombüsünü koparıp masif pulmoner emboliye yol açabilir!",
        "score": -40,
        "is_correct": false,
        "vitals_update": {"hr": "128", "spo2": "84", "rr": "28", "status": "Kritik Kötüleşme"},
        "stability_delta": -35
      },
      {
        "name": "Bacak Elevasyonu ve Kompresyon Takibi",
        "feed": "Venöz dönüş desteklendi, lokal ödem gerilemeye başladı.",
        "score": 20,
        "is_correct": true,
        "vitals_update": {},
        "stability_delta": 10
      }
    ],
    "consultations": [
      {"specialty": "Kalp Damar Cerrahisi (KDC)", "response": "KDC Uzmanı: Doppler DVT ile uyumlu. Flegmazya bulgusu yok, cerrahi trombektomi endikasyonu bulunmuyor. LMWH ile devam edip poliklinik kontrolüne çağırın."},
      {"specialty": "Radyoloji Konsültasyonu", "response": "Radyoloji Uzmanı: Doppler'de tam oklüziv DVT saptandı. İlerleyici şişlik olursa pelvik venleri de tarayabiliriz."}
    ],
    "diag": "Alt Ekstremite Derin Ven Trombozu (DVT)",
    "pearl": "Tek taraflı bacak ağrısı ve ödeminde altın standart tetkik Renkli Doppler USG'dir. Asla masaj yapılmamalı, hızla antikoagülan başlanmalıdır."
  },

  // 2. KARDİYOLOJİ - STEMI
  {
    "id": "cardio_01",
    "specialty": "Kardiyoloji",
    "title": "Baskı Tarzı Göğüs Ağrısı ve Soğuk Terleme",
    "difficulty": "ZOR",
    "xp": 350,
    "initial_stability": 45,
    "patient": {
      "name": "Mehmet Y.",
      "age": 58,
      "gender": "Erkek",
      "complaint": "1 saattir süren, sol kola ve çeneye vuran ezici göğüs ağrısı, bulantı.",
      "history": "Hipertansiyon, 30 paket/yıl sigara öyküsü."
    },
    "vitals": {"hr": "112", "bp": "85/55", "spo2": "91", "rr": "24", "temp": "36.6", "gcs": "15/15", "status": "Kritik"},
    "questions": [
      {"q": "Ağrı tam olarak nasıl bir his ve nereye yayılıyor?", "a": "Göğsüme sanki bir fil oturmuş gibi ezici bir baskı var. Sol kolum ve çeneme doğru yayılıyor."},
      {"q": "Ağrıyla birlikte terleme veya nefes darlığı oldu mu?", "a": "Sırılsıklam soğuk ter boşaldı, nefes alamıyorum."},
      {"q": "Daha önce hiç anjiyo oldunuz mu?", "a": "Hayır, sadece tansiyon hapı kullanıyordum."}
    ],
    "tests": [
      {"name": "12 Derivasyonlu EKG", "duration": 2, "res": "V1-V4 derivasyonlarında 3 mm ST elevasyonu (Akut Anterior STEMI)."},
      {"name": "Kardiyak Troponin I", "duration": 5, "res": "Troponin I: 1.850 ng/L (Kritik Pozitif)."},
      {"name": "Akciğer Grafisi (PA)", "duration": 4, "res": "Kardiyomegali hafif, belirgin pulmoner konjesyon yok."}
    ],
    "treatments": [
      {
        "name": "Aspirin 300 mg çiğnetme + Tikagrelor 180 mg",
        "feed": "İkili antiplatelet tedavi hızla uygulandı.",
        "score": 30,
        "is_correct": true,
        "vitals_update": {},
        "stability_delta": 15
      },
      {
        "name": "Acil Kateter Laboratuvarı & Primer PCI (Anjiyo)",
        "feed": "LAD tam tıkalı bulundu, stent ile damar açıldı ve miyokard perfüzyonu kurtarıldı!",
        "score": 50,
        "is_correct": true,
        "vitals_update": {"hr": "78", "bp": "118/75", "spo2": "98", "status": "Stabil"},
        "stability_delta": 40
      },
      {
        "name": "2000 ml Hızlı SF Sıvı Yüklemesi",
        "feed": "Kardiyak hasarda aşırı sıvı bolusu akut akciğer ödemine ve solunum arrestine yol açtı!",
        "score": -45,
        "is_correct": false,
        "vitals_update": {"spo2": "82", "rr": "32", "status": "Arrest Riski"},
        "stability_delta": -35
      }
    ],
    "consultations": [
      {"specialty": "Girişimsel Kardiyoloji", "response": "Kardiyolog: EKG anterior STEMI ile uyumlu. Anjiyo masası hazırlandı, hastayı sedyeyle hemen kateter salonuna indirin."}
    ],
    "diag": "Akut Anterior ST Elevasyonlu Miyokard Enfarktüsü (STEMI)",
    "pearl": "STEMI olgularında kapı-balon süresi 90 dakikanın altında olmalı; çift antiplatelet yüklenip gecikmeden primer PCI uygulanmalıdır."
  },

  // 3. NÖROLOJİ - İSKEMİK İNME
  {
    "id": "neuro_01",
    "specialty": "Nöroloji",
    "title": "Ani Sağ Kol Güçsüzlüğü ve Konuşamama",
    "difficulty": "ZOR",
    "xp": 350,
    "initial_stability": 50,
    "patient": {
      "name": "Fatma D.",
      "age": 68,
      "gender": "Kadın",
      "complaint": "1 saat önce aniden sağ kol ve bacakta felç, konuşamama ve ağızda kayma.",
      "history": "Atriyal Fibrilasyon, Hipertansiyon."
    },
    "vitals": {"hr": "106", "bp": "175/95", "spo2": "96", "rr": "18", "temp": "36.7", "gcs": "11/15", "status": "Kritik"},
    "questions": [
      {"q": "Yakınları: Belirtiler tam olarak ne zaman fark edildi?", "a": "Tam 50 dakika önce kahvaltı hazırlarken elindeki bardağı düşürdü ve konuşamaz oldu."},
      {"q": "Daha önce geçici felç veya konuşma bozukluğu yaşadı mı?", "a": "Hayır ama ritim bozukluğu vardı, ilacını bazen unutuyordu."}
    ],
    "tests": [
      {"name": "Acil Kontrassız Beyin BT", "duration": 3, "res": "Hemoraji (kanama) izlenmedi. Sol MCA sulkuslarında erken silinme bulgusu."},
      {"name": "Parmak Ucu Kan Şekeri", "duration": 1, "res": "118 mg/dL (İnme taklidi hipoglisemi dışlandı)."},
      {"name": "Koagülasyon Paneli (INR, aPTT)", "duration": 4, "res": "INR: 1.15, aPTT: 28 sn (Trombolitik için güvenli)."}
    ],
    "treatments": [
      {
        "name": "IV Trombolitik (Alteplaz / rtPA) Tedavisi",
        "feed": "İlk 4.5 saatlik altın pencerede intravenöz trombolitik başarıyla verildi, motor kayıp düzelmeye başladı.",
        "score": 50,
        "is_correct": true,
        "vitals_update": {"gcs": "14/15", "status": "Stabil"},
        "stability_delta": 40
      },
      {
        "name": "Akut Saatte Yüksek Doz IV Heparin Bolusu",
        "feed": "Akut iskemik inmede erken tam doz heparin hemorajik transformasyona (kanamaya) zemin hazırlar!",
        "score": -35,
        "is_correct": false,
        "vitals_update": {"status": "Kötüleşiyor"},
        "stability_delta": -25
      }
    ],
    "consultations": [
      {"specialty": "Nöroloji İcapçı Hekimi", "response": "Nörolog: BT kanamayı dışladı, semptom başlangıcı 1 saat. Trombolitik kontrendikasyonu yoksa derhal rtPA başlatın, tansiyonu 185/110 altında tutun."}
    ],
    "diag": "Akut İskemik İnme (Sol MCA Enfarktı)",
    "pearl": "İnmede ilk iş hipoglisemiyi dışlamak ve kontrassız BT ile kanamayı ekarte etmektir. İlk 4.5 saatte trombolitik uygulanmalıdır."
  },

  // 4. NÖROLOJİ - SUBAKUT SAK
  {
    "id": "neuro_02",
    "specialty": "Nöroloji",
    "title": "Hayatımın En Şiddetli Baş Ağrısı ve Kusma",
    "difficulty": "ZOR",
    "xp": 300,
    "initial_stability": 55,
    "patient": {
      "name": "Cemil A.",
      "age": 44,
      "gender": "Erkek",
      "complaint": "Ense kökünden başlayan, patlar tarzda gök gürültüsü baş ağrısı ve fışkırır tarzda kusma.",
      "history": "Polikistik Böbrek Hastalığı, Ailede anevrizma öyküsü."
    },
    "vitals": {"hr": "62", "bp": "180/100", "spo2": "97", "rr": "18", "temp": "37.1", "gcs": "13/15", "status": "Kritik"},
    "questions": [
      {"q": "Ağrı ne kadar sürede en tepe noktasına ulaştı?", "a": "Saniyeler içinde, başıma balyozla vurulmuş gibi aniden patladı!"},
      {"q": "Işığa bakarken veya boynunuzu bükerken ağrı artıyor mu?", "a": "Işık gözlerimi parçalıyor, çenemi göğsüme değdiremiyorum."}
    ],
    "tests": [
      {"name": "Kontrassız Beyin BT", "duration": 3, "res": "Bazal sisternlerde ve subaraknoid mesafede hiperdens kanama (Akut SAK)."},
      {"name": "Beyin BT Anjiyografi", "duration": 5, "res": "AComA (Anterior Komünikan Arter) üzerinde 6 mm sakküler anevrizma."}
    ],
    "treatments": [
      {
        "name": "Nimodipin 60 mg Oral/NG + Kan Basıncı Titrasyonu",
        "feed": "Serebral vazospazm profilaksisi başlandı ve tansiyon pikleri kontrol altına alındı.",
        "score": 40,
        "is_correct": true,
        "vitals_update": {"bp": "140/85", "status": "Stabil"},
        "stability_delta": 30
      },
      {
        "name": "Yüksek Doz Kan Sulandırıcı (Aspirin + Heparin)",
        "feed": "Kritik Hata! Aktif anevrizma kanamasında antikoagülan vermek fatal re-kanamaya neden olur!",
        "score": -50,
        "is_correct": false,
        "vitals_update": {"gcs": "8/15", "status": "Koma Riski"},
        "stability_delta": -40
      }
    ],
    "consultations": [
      {"specialty": "Beyin ve Sinir Cerrahisi (Nöroşirürji)", "response": "Beyin Cerrahı: SAK doğrulanmış. AComA anevrizması için acil endovasküler koilleme veya cerrahi klipleme planlıyoruz, hastayı YBÜ'ye alın."}
    ],
    "diag": "Anevrizmatik Subaraknoid Kanama (SAK)",
    "pearl": "'Gök gürültüsü baş ağrısı' SAK için patognomoniktir. Kan basıncı regüle edilmeli, nimodipin başlanmalı ve acil cerrahi konsülte edilmelidir."
  },

  // 5. PEDİATRİ - FEBRİL KONVÜLSİYON
  {
    "id": "pedia_01",
    "specialty": "Pediatri",
    "title": "Ateşli Çocukta Ani Kasılma ve Göz Kayması",
    "difficulty": "KOLAY",
    "xp": 200,
    "initial_stability": 65,
    "patient": {
      "name": "Ali E.",
      "age": 2,
      "gender": "Erkek",
      "complaint": "Yüksek ateş sonrası tüm vücutta kasılma, çenede kilitlenme (yaklaşık 1.5 dakika sürdü).",
      "history": "Öncesinde 2 gündür ateş, burun akıntısı, huzursuzluk."
    },
    "vitals": {"hr": "142", "bp": "95/60", "spo2": "98", "rr": "28", "temp": "39.4", "gcs": "13/15", "status": "Orta"},
    "questions": [
      {"q": "Anneye: Nöbet esnasında vücudun tek tarafı mı kasıldı yoksa her yeri mi?", "a": "İki kolu ve iki bacağı birden titredi, gözleri yukarı kaydı. 1.5 dakika sonra gevşedi."},
      {"q": "Daha önce hiç havale geçirmiş miydi?", "a": "Hayır doktor hanım ilk kez oldu, çok korktuk."}
    ],
    "tests": [
      {"name": "Menenjit Muayenesi (Ense Sertliği, Brudzinski)", "duration": 2, "res": "Ense sertliği negatif, fontanel kabarık değil, peteşi döküntü yok."},
      {"name": "Otoskopik KBB Muayenesi", "duration": 2, "res": "Bilateral timpanik membran hiperemik ve bombe (Akut Otitis Media)."}
    ],
    "treatments": [
      {
        "name": "IV Parasetamol 15 mg/kg + Ilık Uygulama",
        "feed": "Ateş kademeli düştü, çocuk çevreyle göz teması kurmaya ve annesini tanımaya başladı.",
        "score": 40,
        "is_correct": true,
        "vitals_update": {"temp": "37.2", "hr": "110", "gcs": "15/15", "status": "Stabil"},
        "stability_delta": 30
      },
      {
        "name": "Çocuğun Ağzına Kaşık Sokma ve Soğuk Suya Sokma",
        "feed": "Hatalı ve tehlikeli yaklaşım: Diş travması, aspirasyon ve hipotermi riski yaratır!",
        "score": -30,
        "is_correct": false,
        "vitals_update": {"status": "Ajite"},
        "stability_delta": -20
      }
    ],
    "consultations": [
      {"specialty": "Çocuk Sağlığı ve Hastalıkları", "response": "Pediatrist: Bulgular basit febril konvülsiyon ile uyumlu. Menenjit bulgusu yok. Otit tedavisi planlanıp aileye ateş yönetimi eğitimi verilerek taburcu edilebilir."}
    ],
    "diag": "Basit Febril Konvülsiyon (Akut Otit Sekonder)",
    "pearl": "6 ay - 5 yaş arası çocuklarda <15 dk süren jeneralize nöbetler basit febril konvülsiyondur; ateş odağı saptanıp aile sakinleştirilmelidir."
  },

  // 6. PEDİATRİ - KRUP SENDROMU
  {
    "id": "pedia_02",
    "specialty": "Pediatri",
    "title": "Havlar Tarzda Öksürük ve İnspiratuar Stridor",
    "difficulty": "ORTA",
    "xp": 250,
    "initial_stability": 60,
    "patient": {
      "name": "Zeynep B.",
      "age": 3,
      "gender": "Kadın",
      "complaint": "Gece aniden başlayan havlar tarzda kaba öksürük, ses kısıklığı ve nefes alırken hırıltı.",
      "history": "Hafif nezle bulguları sonrası gece kötüleşti."
    },
    "vitals": {"hr": "130", "bp": "98/62", "spo2": "93", "rr": "32", "temp": "38.2", "gcs": "15/15", "status": "Orta"},
    "questions": [
      {"q": "Çocuk nefes alırken mi verirken mi ses çıkıyor?", "a": "Özellikle nefes alırken sanki boğazı daralmış gibi kaba bir ses geliyor."},
      {"q": "Ağzında yabancı cisim veya küçük oyuncak parçası var mıydı?", "a": "Hayır, uykudan öksürerek uyandı."}
    ],
    "tests": [
      {"name": "Boyun & Üst Havayolu Muayenesi", "duration": 2, "res": "İnspiratuar stridor, suprasternal çekilme pozitif. Yutma güçlüğü veya tükürük akıtma yok."},
      {"name": "Boyun Ön Grafisi", "duration": 3, "res": "Subglottik bölgede 'çan kulesi' (steeple sign) daralma bulgusu."}
    ],
    "treatments": [
      {
        "name": "Nebülize Adrenalin + Oral Deksametazon (0.6 mg/kg)",
        "feed": "Subglottik ödem hızla geriledi, stridor kayboldu ve solunum rahatladı.",
        "score": 45,
        "is_correct": true,
        "vitals_update": {"spo2": "98", "rr": "22", "hr": "105", "status": "Stabil"},
        "stability_delta": 35
      },
      {
        "name": "Ağız İçi Boğaz Basacağı ile Sert Muayene",
        "feed": "Hatalı Yaklaşım! Hava yolunu irrite ederek laringospazm ve tam tıkanıklığı tetikleyebilir!",
        "score": -35,
        "is_correct": false,
        "vitals_update": {"spo2": "87", "status": "Kötüleşiyor"},
        "stability_delta": -25
      }
    ],
    "consultations": [
      {"specialty": "Çocuk Acil Konsültasyonu", "response": "Çocuk Acil Uzmanı: Orta evre Krup tablosu. Deksametazon sonrası 2 saat gözleyin, stridor tekrarlamazsa taburcu edin."}
    ],
    "diag": "Akut Laringotrakeobronşit (Krup Sendromu)",
    "pearl": "Krup tedavisinde steroid (deksametazon) temel taşıdır; orta-ağır vakalarda nebül adrenalin eklenerek hızlı rahatlama sağlanır."
  }
];

// -------------------------------------------------------------
// KLİNİK KODEKS (12 KAPSAMLI TIBBİ REHBER)
// -------------------------------------------------------------
final List<Map<String, String>> kFullCodex = [
  {"t": "12 Derivasyonlu EKG", "type": "Görüntüleme", "d": "Göğüs ağrısı ve senkopta ilk 10 dakikada çekilmeli; ST elevasyonu, dal blokları ve aritmiler taranmalıdır."},
  {"t": "Kardiyak Troponin I & T", "type": "Laboratuvar", "d": "Miyokard nekrozunun en spesifik belirtecidir. 0. ve 3. saat takipleriyle infarktüs dışlanır veya doğrulanır."},
  {"t": "D-Dimer Testi", "type": "Laboratuvar", "d": "Düşük/orta klinik riskli hastalarda DVT ve Pulmoner Emboliyi dışlamak için yüksek negatif prediktif değere sahiptir."},
  {"t": "Arteryel Kan Gazı (AKG)", "type": "Laboratuvar", "d": "pH, PaO2, PaCO2, HCO3 ve laktat ölçülür. Doku hipoksisi ve asit-baz bozukluklarının yönetiminde kritiktir."},
  {"t": "Kontrassız Beyin BT", "type": "Görüntüleme", "d": "Akut inme ve kafa travmasında intrakraniyal kanamayı ekarte etmek için ilk yapılması gereken altın standarttır."},
  {"t": "Toraks BT Anjiyo (BTPA)", "type": "Görüntüleme", "d": "Pulmoner emboli şüphesinde pulmoner arter dallarındaki trombüsü doğrudan gösteren tanı yöntemidir."},
  {"t": "Renkli Doppler USG", "type": "Görüntüleme", "d": "Derin Ven Trombozunda (DVT) venöz lümenin komprese edilememesi ve akım yokluğu ile kesin tanı koyar."},
  {"t": "Aspirin (Asetilsalisilik Asit)", "type": "Acil İlaç", "d": "Akut koroner sendromda 150-300 mg çiğnetilerek verilen siklooksijenaz-1 (COX-1) inhibitörüdür."},
  {"t": "Enoksaparin (LMWH)", "type": "Acil İlaç", "d": "DVT ve AKS olgularında 1 mg/kg SC dozunda uygulanan faktör Xa inhibitörü düşük molekül ağırlıklı heparindir."},
  {"t": "Deksametazon", "type": "Acil İlaç", "d": "Krup sendromunda ve hava yolu ödeminde 0.6 mg/kg tek doz uygulanan uzun etkili kortikosteroiddir."},
  {"t": "Nalokson", "type": "Antidot", "d": "Opioid zehirlenmesinde (solunum depresyonu, miyozis, koma) 0.4 mg IV titre edilerek solunumu geri getiren antidottur."},
  {"t": "Noradrenalin (Norepinefrin)", "type": "Vazopressör", "d": "Septik şok ve vazodilatuv hipotansiyonda ortalama arteryel basıncı (MAP > 65) sağlamak için ilk tercihtir."}
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

  void _onStateChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(onRefresh: _onStateChange),
      const SpecialtiesScreen(),
      const CodexScreen(),
      const MyCasesScreen(),
    ];

    return Scaffold(
      body: pages[_idx],
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
// 1. ANA SAYFA (DR. BURCU ÇÖDEL - SIFIRDAN BAŞLAYAN İSTATİSTİKLER)
// -------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  final VoidCallback onRefresh;
  const HomeScreen({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final progress = UserProfile.xpToNext == 0 ? 0.0 : (UserProfile.xp / UserProfile.xpToNext).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(backgroundColor: Color(0xFFE0E7FF), child: Icon(Icons.person, color: Color(0xFF4F46E5))),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(UserProfile.name, style: const TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Lv.${UserProfile.level} • ${UserProfile.title}", style: const TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold)),
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
                        child: Center(child: Text("${UserProfile.level}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF854D0E)))),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(UserProfile.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Text("Lv.${UserProfile.level + 1} için ${UserProfile.xpToNext - UserProfile.xp} XP kaldı", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ]),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: const Color(0xFFE0F2FE), borderRadius: BorderRadius.circular(20)),
                        child: Text("⚡ ${UserProfile.xp} / ${UserProfile.xpToNext} XP", style: const TextStyle(color: Color(0xFF0284C7), fontWeight: FontWeight.bold, fontSize: 11)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  LinearProgressIndicator(value: progress, backgroundColor: const Color(0xFFF1F5F9), color: const Color(0xFF0284C7), minHeight: 6),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(10)),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            const Icon(Icons.verified, color: Color(0xFF16A34A), size: 16),
                            const SizedBox(width: 6),
                            Text("${UserProfile.totalDiagnoses} Toplam Tanı", style: const TextStyle(color: Color(0xFF16A34A), fontWeight: FontWeight.bold, fontSize: 12)),
                          ]),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(10)),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            const Icon(Icons.pie_chart, color: Color(0xFFD97706), size: 16),
                            const SizedBox(width: 6),
                            Text("%${UserProfile.accuracy.toInt()} Doğruluk", style: const TextStyle(color: Color(0xFFD97706), fontWeight: FontWeight.bold, fontSize: 12)),
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
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (_) => ProcedureRoomScreen(caseData: kAllClinicalCases[0])));
                      onRefresh();
                    },
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
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateCaseWizardScreen()));
                      onRefresh();
                    },
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
                      Text("Tüm tetkik ve tedavilerin ansiklopedisi (12 Rehber)", style: TextStyle(color: Colors.grey, fontSize: 12)),
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
// 2. KEŞFET (BRANŞ LİSTESİ VE O BRANŞA AİT VAKALAR)
// -------------------------------------------------------------
class SpecialtiesScreen extends StatelessWidget {
  const SpecialtiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final specialties = [
      {"name": "Nöroloji", "cases": "${kAllClinicalCases.where((c) => c['specialty'] == 'Nöroloji').length} vaka", "icon": Icons.psychology, "color": Colors.cyan},
      {"name": "Pediatri", "cases": "${kAllClinicalCases.where((c) => c['specialty'] == 'Pediatri').length} vaka", "icon": Icons.child_care, "color": Colors.amber},
      {"name": "Kardiyoloji", "cases": "${kAllClinicalCases.where((c) => c['specialty'] == 'Kardiyoloji').length} vaka", "icon": Icons.favorite, "color": Colors.red},
      {"name": "Acil Tıp", "cases": "${kAllClinicalCases.where((c) => c['specialty'] == 'Acil Tıp').length} vaka", "icon": Icons.emergency, "color": Colors.redAccent},
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
              itemCount: specialties.length,
              itemBuilder: (context, i) {
                final item = specialties[i];
                final clr = item['color'] as Color;
                return InkWell(
                  onTap: () {
                    final matching = kAllClinicalCases.where((c) => c['specialty'] == item['name']).toList();
                    Navigator.push(context, MaterialPageRoute(builder: (_) => SpecialtyCasesScreen(specialtyName: item['name'] as String, cases: matching)));
                  },
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

class SpecialtyCasesScreen extends StatelessWidget {
  final String specialtyName;
  final List<Map<String, dynamic>> cases;

  const SpecialtyCasesScreen({super.key, required this.specialtyName, required this.cases});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$specialtyName Vakaları", style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.chevron_left, color: Colors.black87, size: 28), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cases.length,
        itemBuilder: (context, idx) {
          final c = cases[idx];
          return Card(
            color: Colors.white,
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.black.withOpacity(0.04))),
            child: ListTile(
              contentPadding: const EdgeInsets.all(14),
              leading: const CircleAvatar(backgroundColor: Color(0xFFEDE9FE), child: Icon(Icons.medical_services, color: Color(0xFF7C3AED))),
              title: Text(c['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text("${c['patient']['age']}y, ${c['patient']['gender']} • ${c['difficulty']} • ${c['xp']} XP", style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ),
              trailing: const Icon(Icons.play_circle_fill, color: Color(0xFF6366F1), size: 32),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProcedureRoomScreen(caseData: c))),
            ),
          );
        },
      ),
    );
  }
}

// -------------------------------------------------------------
// 3. KODEKS (GENİŞLETİLMİŞ TIBBİ REHBER)
// -------------------------------------------------------------
class CodexScreen extends StatelessWidget {
  const CodexScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, title: const Text("Klinik Kodeks (Tıbbi Rehber)", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold))),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: kFullCodex.length,
        itemBuilder: (context, i) {
          final item = kFullCodex[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(item['t']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(8)), child: Text(item['type']!, style: const TextStyle(fontSize: 11, color: Color(0xFF4F46E5), fontWeight: FontWeight.bold))),
                ]),
                const SizedBox(height: 8),
                Text(item['d']!, style: const TextStyle(color: Colors.black87, fontSize: 13, height: 1.3)),
              ]),
            ),
          );
        },
      ),
    );
  }
}

// -------------------------------------------------------------
// 4. VAKALARIM EKRANI (DİNAMİK OLUŞTURDUKLARIM SEKMESİ)
// -------------------------------------------------------------
class MyCasesScreen extends StatelessWidget {
  const MyCasesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final myCreated = UserProfile.userCreatedCases;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(children: [
            Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFFEDE9FE), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.folder_shared_rounded, color: Color(0xFF7C3AED), size: 20)),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Vakalarım", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16)),
              Text("Kayıtlı: ${kAllClinicalCases.length + myCreated.length} vaka", style: const TextStyle(color: Colors.grey, fontSize: 11)),
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
            _buildGrid(context, kAllClinicalCases),
            myCreated.isEmpty
                ? Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Icon(Icons.note_add_outlined, size: 48, color: Colors.grey),
                      const SizedBox(height: 12),
                      const Text("Henüz vaka oluşturmadınız", style: TextStyle(color: Colors.grey)),
                      TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateCaseWizardScreen())), child: const Text("Şimdi Yeni Vaka Oluştur")),
                    ]),
                  )
                : _buildGrid(context, myCreated),
            _buildGrid(context, [kAllClinicalCases[0], kAllClinicalCases]),
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
        final isHard = c['difficulty'] == "ZOR";
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
                Text(c['patient']['complaint'] ?? c['title'], maxLines: 4, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Colors.black87)),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: isHard ? Colors.red.shade100 : Colors.amber.shade100, borderRadius: BorderRadius.circular(6)), child: Text(c['difficulty'] ?? "ORTA", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isHard ? Colors.red.shade800 : Colors.amber.shade900))),
                  Text("${c['xp']} XP", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.orange)),
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
// 5. İNTERAKTİF VAKA OLUŞTURMA SİHİRBAZI
// -------------------------------------------------------------
class CreateCaseWizardScreen extends StatefulWidget {
  const CreateCaseWizardScreen({super.key});
  @override
  State<CreateCaseWizardScreen> createState() => _CreateCaseWizardScreenState();
}

class _CreateCaseWizardScreenState extends State<CreateCaseWizardScreen> {
  final _titleController = TextEditingController();
  final _complaintController = TextEditingController();
  String _selectedSpec = "Nöroloji";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kendi Vakanı Yaz", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)), backgroundColor: Colors.white, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Vaka Başlığı", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          TextField(controller: _titleController, decoration: InputDecoration(hintText: "Örn: Akut Başağrısı ve Görme Kaybı", filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
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
              items: ["Nöroloji", "Pediatri", "Kardiyoloji", "Acil Tıp"].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() => _selectedSpec = v!),
            ),
          ),
          const SizedBox(height: 16),
          const Text("Hasta Hikayesi ve Şikayeti", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          TextField(controller: _complaintController, maxLines: 4, decoration: InputDecoration(hintText: "Örn: 35 yaş kadın hasta, şiddetli migren benzeri baş ağrısıyla acile başvurdu...", filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), padding: const EdgeInsets.all(14)),
              onPressed: () {
                if (_titleController.text.isEmpty) return;
                final newCase = {
                  "id": "custom_${DateTime.now().millisecondsSinceEpoch}",
                  "specialty": _selectedSpec,
                  "title": _titleController.text,
                  "difficulty": "ORTA",
                  "xp": 300,
                  "initial_stability": 65,
                  "patient": {
                    "name": "Özel Vaka Hastası",
                    "age": 35,
                    "gender": "Kadın",
                    "complaint": _complaintController.text.isEmpty ? "Akut semptomlarla başvuru." : _complaintController.text
                  },
                  "vitals": {"hr": "88", "bp": "120/80", "spo2": "98", "rr": "16", "temp": "36.7", "gcs": "15/15", "status": "Stabil"},
                  "questions": [
                    {"q": "Ağrı ne zamandan beri var?", "a": "Dünden beri devam ediyor."}
                  ],
                  "tests": [
                    {"name": "Tam Kan Sayımı", "duration": 2, "res": "Lökosit ve hemoglobin normal."}
                  ],
                  "treatments": [
                    {"name": "IV Sıvı ve Semptomatik Tedavi", "feed": "Hasta rahatladı.", "score": 30, "is_correct": true, "vitals_update": {}, "stability_delta": 20}
                  ],
                  "consultations": [
                    {"specialty": "Klinik Uzmanı", "response": "Uzman: Vaka yönetimi başarılı."}
                  ],
                  "diag": _titleController.text,
                  "pearl": "Kendi oluşturduğunuz klinik senaryonuz."
                };
                UserProfile.userCreatedCases.add(newCase);
                kAllClinicalCases.add(newCase);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vakanız başarıyla kaydedildi ve 'Vakalarım' sekmesine eklendi!")));
                Navigator.pop(context);
              },
              child: const Text("Vakayı Sisteme Kaydet", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          )
        ]),
      ),
    );
  }
}

// -------------------------------------------------------------
// 6. MÜDAHALE ODASI (CANLI AKAN ZAMAN SAYACI, GERÇEK SÜRELİ TETKİK VE DİNAMİK VİTALLER)
// -------------------------------------------------------------
class ProcedureRoomScreen extends StatefulWidget {
  final Map<String, dynamic> caseData;
  const ProcedureRoomScreen({super.key, required this.caseData});
  @override
  State<ProcedureRoomScreen> createState() => _ProcedureRoomScreenState();
}

class _ProcedureRoomScreenState extends State<ProcedureRoomScreen> {
  late int stability;
  late Map<String, dynamic> vitals;
  final List<Map<String, dynamic>> logs = [];
  final Set<String> doneTests = {};
  final Set<String> doneTrts = {};

  // Canlı Kronometre
  Timer? _caseTimer;
  int _secondsElapsed = 0;

  // Devam Eden İşlemler (Canlı Geri Sayım)
  String? ongoingActionName;
  int ongoingActionSeconds = 0;
  Timer? _actionCountdownTimer;

  @override
  void initState() {
    super.initState();
    stability = widget.caseData['initial_stability'] ?? 60;
    vitals = Map<String, dynamic>.from(widget.caseData['vitals']);

    // Canlı Kronometreyi Başlat (00:00, 00:01...)
    _caseTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() => _secondsElapsed++);
    });

    // Başlangıçta SAHTE bar yok! SADECE 'Vaka Başladı' kartı eklenir
    final p = widget.caseData['patient'];
    logs.add({
      "t": "Vaka Başladı",
      "tm": "00:00",
      "c": Colors.grey,
      "i": Icons.info_outline,
      "m": "${p['name']} (${p['age']}y, ${p['gender']}) - ${p['complaint']}"
    });
  }

  @override
  void dispose() {
    _caseTimer?.cancel();
    _actionCountdownTimer?.cancel();
    super.dispose();
  }

  String _formatTime(int sec) {
    final m = (sec ~/ 60).toString().padLeft(2, '0');
    final s = (sec % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  // Tetkik İsteme - Gerçek Süreli Simülasyon
  void _startDiagnostic(Map<String, dynamic> test) {
    if (doneTests.contains(test['name'])) return;
    if (ongoingActionName != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Halen devam eden bir işlem var, lütfen bekleyin!")));
      return;
    }

    final duration = (test['duration'] as int?) ?? 3;
    setState(() {
      ongoingActionName = test['name'];
      ongoingActionSeconds = duration;
      logs.add({
        "t": "Tetkik Başlatıldı",
        "tm": _formatTime(_secondsElapsed),
        "c": const Color(0xFF6366F1),
        "i": Icons.hourglass_top_rounded,
        "m": "${test['name']}\nTahmini Süre: $duration sn • Laboratuvara emir iletildi."
      });
    });

    _actionCountdownTimer?.cancel();
    _actionCountdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (ongoingActionSeconds > 1) {
        setState(() => ongoingActionSeconds--);
      } else {
        t.cancel();
        setState(() {
          ongoingActionName = null;
          doneTests.add(test['name']);
          logs.add({
            "t": "Tetkik Tamamlandı",
            "tm": _formatTime(_secondsElapsed),
            "c": const Color(0xFF0D9488),
            "i": Icons.biotech,
            "m": "${test['name']}\nSonuç: ${test['res']}"
          });
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("🔔 ${test['name']} sonucu çıktı!"), backgroundColor: const Color(0xFF0D9488)));
      }
    });
  }

  // Tedavi Uygulama - Dinamik Vital ve Stabilite Değişimi
  void _applyTreatment(Map<String, dynamic> trt) {
    if (doneTrts.contains(trt['name'])) return;
    Navigator.pop(context);

    setState(() {
      doneTrts.add(trt['name']);
      final bool isCorrect = trt['is_correct'] ?? true;
      final int delta = (trt['stability_delta'] as int?) ?? 0;
      stability = (stability + delta).clamp(5, 100);

      final Map<String, dynamic> updates = trt['vitals_update'] ?? {};
      updates.forEach((k, v) => vitals[k] = v);

      logs.add({
        "t": isCorrect ? "Tedavi Uygulandı (Doğru Karar)" : "Kritik Klinik Uyarı",
        "tm": _formatTime(_secondsElapsed),
        "c": isCorrect ? const Color(0xFF16A34A) : Colors.red,
        "i": isCorrect ? Icons.check_circle : Icons.warning_amber_rounded,
        "m": "${trt['name']}\n${trt['feed']}"
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(trt['feed']),
        backgroundColor: (trt['is_correct'] ?? true) ? const Color(0xFF16A34A) : Colors.red.shade800,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  // Konsültasyon İsteme
  void _requestConsultation(Map<String, dynamic> c) {
    Navigator.pop(context);
    setState(() {
      logs.add({
        "t": "Konsültasyon Yanıtı",
        "tm": _formatTime(_secondsElapsed),
        "c": const Color(0xFFEA580C),
        "i": Icons.group_outlined,
        "m": "${c['specialty']}\n${c['response']}"
      });
    });
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
          ...qs.map((q) => Card(
                color: const Color(0xFFF0F9FF),
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(q['q']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  trailing: const Icon(Icons.send_rounded, color: Color(0xFF0284C7), size: 18),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      logs.add({
                        "t": "Anamnez Alındı",
                        "tm": _formatTime(_secondsElapsed),
                        "c": const Color(0xFF0284C7),
                        "i": Icons.chat_bubble_outline_rounded,
                        "m": "Soru: ${q['q']}\nHasta: \"${q['a']}\""
                      });
                    });
                  },
                ),
              )),
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
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("İstenebilecek Tanısal Tetkikler", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...tests.map((t) {
              final isDone = doneTests.contains(t['name']);
              return Card(
                color: const Color(0xFFF8FAFC),
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(t['name']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  subtitle: isDone ? Text("Sonuç: ${t['res']!}", style: const TextStyle(color: Color(0xFF0D9488), fontSize: 12, fontWeight: FontWeight.bold)) : Text("Bekleme Süresi: ${t['duration']} saniye", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: isDone ? Colors.grey : const Color(0xFF6366F1)),
                    onPressed: isDone
                        ? null
                        : () {
                            Navigator.pop(ctx);
                            _startDiagnostic(t);
                          },
                    child: Text(isDone ? "Tamamlandı" : "İste"),
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
          const Text("Tedavi & Girişimsel Karar Planı", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...trts.map((t) {
            final isDone = doneTrts.contains(t['name']);
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(14), side: BorderSide(color: isDone ? Colors.grey : const Color(0xFF6366F1))),
                onPressed: isDone ? null : () => _applyTreatment(t),
                child: Row(children: [
                  Icon(isDone ? Icons.check : Icons.play_arrow, color: isDone ? Colors.grey : const Color(0xFF6366F1), size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(t['name'], style: TextStyle(color: isDone ? Colors.grey : Colors.black87, fontSize: 13, fontWeight: FontWeight.bold))),
                ]),
              ),
            );
          })
        ]),
      ),
    );
  }

  void _openConsultations() {
    final cons = widget.caseData['consultations'] as List? ?? [];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Uzman Hekim Konsültasyonu İste", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...cons.map((c) => Card(
                color: const Color(0xFFFFF7ED),
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const Icon(Icons.support_agent_rounded, color: Color(0xFFEA580C)),
                  title: Text(c['specialty']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  trailing: const Icon(Icons.phone_in_talk, color: Color(0xFFEA580C), size: 20),
                  onTap: () => _requestConsultation(c),
                ),
              )),
        ]),
      ),
    );
  }

  void _finishCase() {
    final isSuccess = stability >= 70;
    final xpEarned = isSuccess ? (widget.caseData['xp'] as int? ?? 250) : 50;

    UserProfile.addXp(xpEarned, isSuccess);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(isSuccess ? Icons.verified_rounded : Icons.warning_amber_rounded, color: isSuccess ? Colors.green : Colors.orange, size: 48),
          const SizedBox(height: 10),
          Text(isSuccess ? "Vaka Başarıyla Yönetildi" : "Klinik Kötüleşme / Riskli Taburculuk", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text("Kazanılan Deneyim: +$xpEarned XP", style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),
          Text("Nihai Teşhis: ${widget.caseData['diag']}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4F46E5))),
          const SizedBox(height: 8),
          Text(widget.caseData['pearl'] ?? "", style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.3)),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), padding: const EdgeInsets.all(14)),
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              child: const Text("Vakayı Tamamla ve Menüye Dön", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color ringColor = stability > 70 ? const Color(0xFF22C55E) : (stability > 40 ? Colors.orange : Colors.red);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.chevron_left, color: Colors.black87, size: 28), onPressed: () => Navigator.pop(context)),
        title: Row(children: [
          Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Color(0xFFFEE2E2), shape: BoxShape.circle), child: const Icon(Icons.emergency, color: Colors.red, size: 16)),
          const SizedBox(width: 8),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("Müdahale Odası", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16)),
            Row(children: [
              const Icon(Icons.timer_outlined, size: 12, color: Colors.grey),
              const SizedBox(width: 4),
              Text(_formatTime(_secondsElapsed), style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
            ]),
          ]),
        ]),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(width: 46, height: 46, child: CircularProgressIndicator(value: stability / 100, strokeWidth: 3, backgroundColor: Colors.grey.shade200, valueColor: AlwaysStoppedAnimation<Color>(ringColor))),
                CircleAvatar(radius: 18, backgroundColor: ringColor.withOpacity(0.15), child: Text("$stability%", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: ringColor))),
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

          // SADECE Gerçekten Bir İşlem Devam Ediyorsa Görünen Dinamik Bar
          if (ongoingActionName != null)
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFC7D2FE))),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFF99F6E4), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.biotech, color: Color(0xFF0D9488), size: 16)),
                  const SizedBox(width: 8),
                  Text(ongoingActionName!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ]),
                Text("$ongoingActionSeconds sn kaldı", style: const TextStyle(color: Color(0xFF4F46E5), fontWeight: FontWeight.bold, fontSize: 12)),
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
              _dock("Kons.", Icons.group_outlined, const Color(0xFFFFEDD5), const Color(0xFFEA580C), _openConsultations),
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
