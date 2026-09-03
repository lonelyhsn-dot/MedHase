import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const MedHaseApp());

class MedHaseApp extends StatelessWidget {
  const MedHaseApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedHase',
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
// KULLANICI PROFİLİ VE GLOBAL SİSTEM DURUMU (STATE)
// -------------------------------------------------------------
class UserProfile {
  static String name = "Dr. Burcu Çödel";
  static String title = "İntörn Doktor";
  static int level = 1;
  static int xp = 0;
  static int xpToNext = 500;
  static int totalDiagnoses = 0;
  static int correctDiagnoses = 0;

  static Set<String> completedCaseIds = {};
  static List<Map<String, dynamic>> userCreatedCases = [];

  static void addXp(String caseId, int amount, bool isCorrect) {
    totalDiagnoses++;
    if (isCorrect) {
      correctDiagnoses++;
      completedCaseIds.add(caseId);
    }
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
// GERÇEK TIBBİ VAKA VERİ TABANI
// -------------------------------------------------------------
final List<Map<String, dynamic>> kAllClinicalCases = [
  // NÖROLOJİ (VAKALAR)
  {
    "id": "neuro_01", "specialty": "Nöroloji", "title": "Ani Sağ Kol Kuvvetsizliği ve Afazi", "diff": "ZOR", "xp": 350, "initial_stability": 50,
    "patient": {"name": "Fatma D.", "age": 68, "gender": "Kadın", "complaint": "1 saat önce sağ kol ve bacakta felç, konuşamama."},
    "history": "Atriyal fibrilasyon, hipertansiyon. Kan sulandırıcı aksatılmış.",
    "vitals": {"hr": "106", "bp": "175/95", "spo2": "96", "rr": "18", "temp": "36.7", "gcs": "11/15", "status": "Kritik"},
    "questions": [
      {"q": "Belirtiler tam olarak saat kaçta başladı?", "a": "Tam 50 dakika önce kahvaltıda başladı."},
      {"q": "Daha önce geçici felç veya uyuşma yaşadı mı?", "a": "Hayır ilk kez oldu, ilacını 1 haftadır almıyordu."},
      {"q": "Baş ağrısı veya kusması oldu mu?", "a": "Hayır baş ağrısı yok, sadece sağ tarafı tutmuyor."},
      {"q": "Bilinç kaybı veya bayılma gelişti mi?", "a": "Gözleri açık ama söylediklerimizi anlamıyor."}
    ],
    "tests": [
      {"name": "Kontrassız Beyin BT", "duration": 60, "res": "Hemoraji yok. Sol MCA sulkuslarında erken silinme."},
      {"name": "Parmak Ucu Kan Şekeri", "duration": 45, "res": "114 mg/dL (İnme taklidi hipoglisemi dışlandı)."},
      {"name": "Koagülasyon Paneli (INR/aPTT)", "duration": 60, "res": "INR: 1.15, aPTT: 28 sn (Trombolitik için güvenli)."}
    ],
    "treatments": [
      {"name": "IV Trombolitik (rtPA) 0.9 mg/kg", "duration": 30, "feed": "İlk 4.5 saatte tromboliz uygulandı, motor güç toparlamaya başladı.", "score": 50, "is_correct": true, "vitals_update": {"gcs": "14/15", "status": "Stabil", "bp": "150/85"}, "stability_delta": 35},
      {"name": "Yüksek Doz IV Heparin Bolusu", "duration": 30, "feed": "Kritik Hata! Akut iskemide erken heparin hemorajik transformasyona yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"gcs": "8/15", "status": "Koma Riski", "bp": "195/110"}, "stability_delta": -35},
      {"name": "Tansiyon Regülasyonu (IV Labetalol)", "duration": 30, "feed": "Tansiyon 185/110 altına çekilerek güvenli sınır sağlandı.", "score": 25, "is_correct": true, "vitals_update": {"bp": "160/90"}, "stability_delta": 10},
      {"name": "Oksijen Desteği ve Hemodinamik İzlem", "duration": 30, "feed": "Vital stabilizasyon sağlandı.", "score": 20, "is_correct": true, "vitals_update": {"spo2": "99"}, "stability_delta": 10}
    ],
    "consultations": [{"specialty": "Nöroloji İcapçı Hekimi", "response": "Nörolog: BT kanamayı dışladı, semptom süresi 1 saat. rtPA başlatın ve anjiyo ekibini trombektomiye çağırın."}],
    "diag": "Akut İskemik İnme (Sol MCA Enfarktı)", "pearl": "İnmede ilk iş hipoglisemiyi dışlamak ve kontrassız BT ile kanamayı ekarte etmektir."
  },
  {
    "id": "neuro_02", "specialty": "Nöroloji", "title": "Gök Gürültüsü Baş Ağrısı ve Kusma", "diff": "ZOR", "xp": 400, "initial_stability": 55,
    "patient": {"name": "Cemil A.", "age": 44, "gender": "Erkek", "complaint": "Balyoz vurulmuş gibi ani baş ağrısı, fışkırır kusma."},
    "history": "Polikistik böbrek hastalığı, sigara.", "vitals": {"hr": "62", "bp": "185/105", "spo2": "97", "rr": "16", "temp": "37.2", "gcs": "13/15", "status": "Kritik"},
    "questions": [
      {"q": "Ağrı ne kadar sürede tepeye ulaştı?", "a": "Saniyeler içinde, hayatımda böyle ağrı görmedim!"},
      {"q": "Boynunuzu bükebiliyor musunuz?", "a": "Çenemi göğsüme değdiremiyorum, ensem taş gibi."},
      {"q": "Işık rahatsız ediyor mu?", "a": "Gözlerimi açamıyorum, ışık çok batıyor."},
      {"q": "Bilinç bulanıklığı oldu mu?", "a": "Ağrıdan sonra birkaç dakika nerede olduğumu bilemedim."}
    ],
    "tests": [
      {"name": "Kontrassız Beyin BT", "duration": 60, "res": "Bazal sisternlerde hiperdens akut subaraknoid kanama."},
      {"name": "Beyin BT Anjiyografi", "duration": 90, "res": "AComA üzerinde 6 mm rüptüre sakküler anevrizma."},
      {"name": "Elektrolit Paneli", "duration": 45, "res": "Sodyum ve potasyum normal."}
    ],
    "treatments": [
      {"name": "Nimodipin 60 mg + Tansiyon Titrasyonu", "duration": 30, "feed": "Serebral vazospazm profilaksisi başlandı, re-kanama riski azaltıldı.", "score": 40, "is_correct": true, "vitals_update": {"bp": "140/85", "status": "Stabil"}, "stability_delta": 25},
      {"name": "Yüksek Doz Aspirin + Heparin", "duration": 30, "feed": "Kritik Hata! Aktif intrakraniyal kanamada antikoagülan fatal kanamaya yol açtı!", "score": -50, "is_correct": false, "vitals_update": {"gcs": "7/15", "status": "Koma"}, "stability_delta": -40},
      {"name": "Acil Nöroşirürji Koilleme Hazırlığı", "duration": 30, "feed": "Anevrizma endovasküler yolla koillendi, kanama odağı kapatıldı.", "score": 50, "is_correct": true, "vitals_update": {"status": "Stabil", "gcs": "15/15"}, "stability_delta": 30},
      {"name": "İntravenöz Analjezi ve Antiemetik", "duration": 30, "feed": "Ağrı ve ıkınma basıncı düşürüldü.", "score": 20, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [{"specialty": "Beyin Cerrahisi", "response": "Beyin Cerrahı: SAK teyit edildi. Hastayı anjiyografi ünitesine acil koillemeye alıyoruz."}],
    "diag": "Subaraknoid Kanama (Anevrizma Rüptürü)", "pearl": "Gök gürültüsü baş ağrısında SAK aranmalıdır; nimodipin başlanıp cerrahi konsülte edilir."
  },
  {
    "id": "neuro_03", "specialty": "Nöroloji", "title": "Durdurulamayan Nöbet (Status)", "diff": "ZOR", "xp": 450, "initial_stability": 35,
    "patient": {"name": "Eren K.", "age": 29, "gender": "Erkek", "complaint": "20 dakikadır süren aralıksız jeneralize kasılma."},
    "history": "Dirençli epilepsi, ilaç kesme.", "vitals": {"hr": "138", "bp": "160/95", "spo2": "86", "rr": "26", "temp": "38.5", "gcs": "6/15", "status": "Hayati Tehlike"},
    "questions": [
      {"q": "Yakınlarına: Nöbet ne kadar sürdü?", "a": "20 dakikadır hiç durmadan kasılıyor."},
      {"q": "İlaçlarını alıyor muydu?", "a": "3 gündür ilaçlarını almamıştı."},
      {"q": "Ateş veya kafa travması oldu mu?", "a": "Hayır travma yok, aniden başladı."},
      {"q": "Daha önce yoğun bakıma yattı mı?", "a": "Evet 2 yıl önce benzer nöbette entübe edilmişti."}
    ],
    "tests": [
      {"name": "Parmak Ucu Glukoz Ölçümü", "duration": 45, "res": "98 mg/dL (Hipoglisemi yok)."},
      {"name": "Arteryel Kan Gazı", "duration": 60, "res": "pH: 7.18, Laktat: 6.2 mmol/L (Ağır laktik asidoz)."},
      {"name": "Acil Beyin BT", "duration": 60, "res": "Akut kitle veya kanama izlenmedi."}
    ],
    "treatments": [
      {"name": "IV Diazepam 10 mg Yavaş Bolus", "duration": 30, "feed": "İlk basamak tedavi verildi, kasılmalar seyrelmeye başladı.", "score": 35, "is_correct": true, "vitals_update": {"spo2": "93", "hr": "115"}, "stability_delta": 20},
      {"name": "IV Levetirasetam 60 mg/kg İnfüzyonu", "duration": 30, "feed": "İkinci basamak tedaviyle nöbet tamamen sonlandırıldı!", "score": 45, "is_correct": true, "vitals_update": {"hr": "88", "bp": "125/80", "spo2": "98", "status": "Stabil", "gcs": "12/15"}, "stability_delta": 35},
      {"name": "Ağza Tahta Kaşık Sokmaya Çalışma", "duration": 30, "feed": "Hatalı Yaklaşım! Diş kırığı ve laringeal aspirasyon riski oluşturur.", "score": -25, "is_correct": false, "vitals_update": {"spo2": "80"}, "stability_delta": -15},
      {"name": "Oksijen Maskesi ve Havayolu Güvenliği", "duration": 30, "feed": "Hipoksi önlendi.", "score": 20, "is_correct": true, "vitals_update": {"spo2": "95"}, "stability_delta": 10}
    ],
    "consultations": [{"specialty": "Nöroloji Yoğun Bakım", "response": "Uzman: Benzodiazepin sonrası nöbet durmazsa entübasyon ve propofol infüzyonuna geçin."}],
    "diag": "Konvülzif Status Epileptikus", "pearl": "5 dakikayı aşan nöbetlerde gecikmeden IV benzodiazepin ve levetirasetam verilmelidir."
  },
  {
    "id": "neuro_04", "specialty": "Nöroloji", "title": "Ayaklardan Yükselen Felç ve Uyuşma", "diff": "ORTA", "xp": 300, "initial_stability": 65,
    "patient": {"name": "Aylin S.", "age": 33, "gender": "Kadın", "complaint": "Ayaklardan başlayıp gövdeye tırmanan kuvvetsizlik."},
    "history": "2 hafta önce geçirilmiş bakteriyel ishal.", "vitals": {"hr": "88", "bp": "120/75", "spo2": "97", "rr": "18", "temp": "36.8", "gcs": "15/15", "status": "Semptomatik"},
    "questions": [
      {"q": "Kuvvetsizlik nasıl ilerledi?", "a": "Önce ayak parmaklarım uyuştu, ertesi gün dizlerimi kaldıramadım."},
      {"q": "Nefes alırken zorlanıyor musunuz?", "a": "Derin nefes alırken göğsümde baskı hissediyorum."},
      {"q": "Son 1 ayda enfeksiyon geçirdiniz mi?", "a": "Evet 2 hafta önce şiddetli ishal olmuştum."},
      {"q": "İdrar kaçırma veya tutamama oldu mu?", "a": "Hayır sfinkter kusuru yok."}
    ],
    "tests": [
      {"name": "Derin Tendon Refleksleri Muayenesi", "duration": 45, "res": "Aşil ve patella refleksleri bilateral arefleksik (yok)."},
      {"name": "FVC Solunum Kapasitesi Ölçümü", "duration": 60, "res": "FVC: 18 ml/kg (Solunum yetmezliği sınırında)."},
      {"name": "BOS İncelemesi (Lomber Ponksiyon)", "duration": 90, "res": "Albüminositolojik disosiasyon: Protein 140 mg/dL, hücre yok."}
    ],
    "treatments": [
      {"name": "IVIG 0.4 g/kg/gün Başlanması", "duration": 30, "feed": "Otoimmün demiyelinizasyon durduruldu, motor kayıp geriledi.", "score": 45, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 25},
      {"name": "Yüksek Doz Sistemik Steroid", "duration": 30, "feed": "Hatalı Tedavi: GBS'de steroidlerin yeri yoktur, iyileşmeyi geciktirebilir.", "score": -25, "is_correct": false, "vitals_update": {}, "stability_delta": -10},
      {"name": "Solunum Kapasitesi Yakın Takibi", "duration": 30, "feed": "Vital kapasite izleme alındı.", "score": 20, "is_correct": true, "vitals_update": {}, "stability_delta": 10},
      {"name": "Derin Ven Trombozu Profilaksisi (LMWH)", "duration": 30, "feed": "Hareketsizliğe bağlı emboli riski önlendi.", "score": 20, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [{"specialty": "Nöroloji Kliniği", "response": "Nörolog: GBS tablosu. FVC < 15 ml/kg olursa entübasyon için YBÜ hazırlığı yapın, IVIG başlayın."}],
    "diag": "Guillain-Barré Sendromu (GBS)", "pearl": "Simetrik asendan paralizi ve areflekside FVC takibi ve IVIG tedavisi esastır."
  },
  {
    "id": "neuro_05", "specialty": "Nöroloji", "title": "Tek Taraflı Yüz Felci ve Göz Kapatamama", "diff": "KOLAY", "xp": 200, "initial_stability": 85,
    "patient": {"name": "Hasan B.", "age": 41, "gender": "Erkek", "complaint": "Yüzün sağ yarısında felç, alnı kırıştıramama."},
    "history": "Soğuk hava/klima maruziyeti.", "vitals": {"hr": "76", "bp": "125/80", "spo2": "99", "rr": "14", "temp": "36.6", "gcs": "15/15", "status": "Stabil"},
    "questions": [
      {"q": "Alnınızı yukarı kırıştırmayı dener misiniz?", "a": "Sağ taraf hiç kırışmıyor, tamamen hareketsiz."},
      {"q": "Kol veya bacağınızda güçsüzlük var mı?", "a": "Hayır kollarım ve bacaklarım gayet güçlü."},
      {"q": "Ağzınızda tat değişikliği oldu mu?", "a": "Dilimin ön kısmında tatları garip alıyorum."},
      {"q": "Kulak arkasında ağrı oldu mu?", "a": "Evet felç başlamadan önce kulağımın arkası sızlıyordu."}
    ],
    "tests": [
      {"name": "Kraniyal Sinir VII Muayenesi", "duration": 45, "res": "Sağ periferik fasiyal paralizi (Alın tutulumu pozitif, Bell fenomeni var)."},
      {"name": "Nörolojik Odak Muayenesi", "duration": 45, "res": "Ek motor/duyusal defisit yok, serebellar testler normal."}
    ],
    "treatments": [
      {"name": "Oral Prednizolon 1 mg/kg + Suni Gözyaşı", "duration": 30, "feed": "Fasiyal sinir ödemi geriletildi, kornea kuruması önlendi.", "score": 40, "is_correct": true, "vitals_update": {"status": "Şifayla Taburcu"}, "stability_delta": 15},
      {"name": "Acil Trombolitik Tedavi (rtPA)", "duration": 30, "feed": "Hayati Hata! Periferik yüz felci santral inme değildir, gereksiz trombolitik kanama riski doğurur!", "score": -50, "is_correct": false, "vitals_update": {"status": "Kritik"}, "stability_delta": -35},
      {"name": "Göz Kapama Bandı (Gece Koruması)", "duration": 30, "feed": "Lagofitalmiye bağlı kornea ülseri engellendi.", "score": 20, "is_correct": true, "vitals_update": {}, "stability_delta": 10},
      {"name": "Fizik Tedavi ve Yüz Egzersizleri Eğitimi", "duration": 30, "feed": "Rehabilitasyon süreci başlatıldı.", "score": 20, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [{"specialty": "Nöroloji Polikliniği", "response": "Nörolog: Klasik Bell paralizisi. Steroid ve göz korumasıyla taburcu edin, 10 gün sonra kontrole gelsin."}],
    "diag": "Bell Paralizisi", "pearl": "Alın kaslarının tutulumu periferik felci santral inmeden ayıran en belirgin bulgudur."
  },

  // PEDİATRİ (VAKALAR)
  {
    "id": "ped_01", "specialty": "Pediatri", "title": "Ateşli Çocukta Nöbet ve Bilinç Değişikliği", "diff": "KOLAY", "xp": 200, "initial_stability": 65,
    "patient": {"name": "Ali E.", "age": 2, "gender": "Erkek", "complaint": "Yüksek ateş sonrası kasılma ve gözlerde yukarı kayma."},
    "history": "2 gündür nezle ve huzursuzluk.", "vitals": {"hr": "142", "bp": "95/60", "spo2": "98", "rr": "28", "temp": "39.4", "gcs": "13/15", "status": "Orta"},
    "questions": [
      {"q": "Nöbet esnasında vücudun her yeri mi kasıldı?", "a": "İki kolu ve bacağı birden titredi, gözleri yukarı kaydı (1.5 dakika)."},
      {"q": "Daha önce hiç havale geçirmiş miydi?", "a": "Hayır ilk kez oldu."},
      {"q": "Aşıları takvime uygun mu?", "a": "Evet tüm aşıları tam."},
      {"q": "Kusma veya ishal oldu mu?", "a": "Hafif kusması oldu ama ishal yok."}
    ],
    "tests": [
      {"name": "Menenjit Muayenesi (Ense Sertliği)", "duration": 45, "res": "Ense sertliği negatif, fontanel kabarık değil."},
      {"name": "Otoskopik KBB Muayenesi", "duration": 45, "res": "Bilateral timpanik membran hiperemik ve bombe (Akut Otitis Media)."}
    ],
    "treatments": [
      {"name": "IV Parasetamol 15 mg/kg + Ilık Uygulama", "duration": 30, "feed": "Ateş kademeli düştü, çocuk çevreyle göz teması kurmaya başladı.", "score": 40, "is_correct": true, "vitals_update": {"temp": "37.2", "hr": "110", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 30},
      {"name": "Çocuğun Ağzına Kaşık Sokma ve Soğuk Su", "duration": 30, "feed": "Hatalı ve zararlı uygulama! Diş travması ve aspirasyona neden olur.", "score": -30, "is_correct": false, "vitals_update": {"status": "Ajite"}, "stability_delta": -20},
      {"name": "Oral Hidrasyon Desteği", "duration": 30, "feed": "Sıvı dengesi korundu.", "score": 20, "is_correct": true, "vitals_update": {}, "stability_delta": 10},
      {"name": "Aileye Ateş Yönetimi Bilgilendirmesi", "duration": 30, "feed": "Aileye güven verildi.", "score": 20, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [{"specialty": "Çocuk Sağlığı ve Hastalıkları", "response": "Pediatrist: Basit febril konvülsiyon. Menenjit ekarte edildi, otit tedavisi verip taburcu edin."}],
    "diag": "Basit Febril Konvülsiyon", "pearl": "6 ay - 5 yaş arası çocuklarda <15 dk süren jeneralize nöbetler basit febril konvülsiyondur."
  },
  {
    "id": "ped_02", "specialty": "Pediatri", "title": "Havlar Tarzda Öksürük ve Stridor", "diff": "ORTA", "xp": 250, "initial_stability": 60,
    "patient": {"name": "Zeynep B.", "age": 3, "gender": "Kadın", "complaint": "Gece aniden başlayan havlar öksürük, ses kısıklığı."},
    "history": "Hafif soğuk algınlığı sonrası gece kötüleşti.", "vitals": {"hr": "130", "bp": "98/62", "spo2": "93", "rr": "32", "temp": "38.2", "gcs": "15/15", "status": "Orta"},
    "questions": [
      {"q": "Nefes alırken mi hırıltı oluyor?", "a": "Evet nefes alırken kaba bir düdük sesi gibi ses çıkıyor."},
      {"q": "Yabancı cisim yutma şüphesi var mı?", "a": "Hayır uykusundan öksürerek uyandı."},
      {"q": "Tükürüğünü yutabiliyor mu?", "a": "Evet salya akması yok."},
      {"q": "Daha önce astım tanısı aldı mı?", "a": "Hayır astımı yok."}
    ],
    "tests": [
      {"name": "Üst Havayolu Muayenesi", "duration": 45, "res": "İnspiratuar stridor, suprasternal çekilme var. Tükürük akıtma yok."},
      {"name": "Boyun Ön Grafisi", "duration": 60, "res": "Subglottik çan kulesi (steeple sign) daralma bulgusu."}
    ],
    "treatments": [
      {"name": "Nebülize Adrenalin + Oral Deksametazon", "duration": 30, "feed": "Subglottik ödem geriledi, stridor kayboldu, satürasyon hızla yükseldi.", "score": 45, "is_correct": true, "vitals_update": {"spo2": "98", "rr": "22", "hr": "105", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Boğaz Basacağı ile Sert Muayene", "duration": 30, "feed": "Hatalı Yaklaşım! Hava yolunu irrite ederek tam obstrüksiyonu tetikleyebilir!", "score": -35, "is_correct": false, "vitals_update": {"spo2": "86", "status": "Kötüleşiyor"}, "stability_delta": -25},
      {"name": "Nemlendirilmiş Soğuk Buhar Tedavisi", "duration": 30, "feed": "Hava yolları rahatlatıldı.", "score": 20, "is_correct": true, "vitals_update": {"spo2": "95"}, "stability_delta": 10},
      {"name": "Sakinleştirici Pozisyonlama", "duration": 30, "feed": "Anksiyete ve solunum iş yükü azaltıldı.", "score": 20, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [{"specialty": "Çocuk Acil Uzmanı", "response": "Uzman: Krup tablosu. Deksametazon sonrası 2 saat gözleyin, stridor tekrarlamazsa taburcu edin."}],
    "diag": "Akut Krup Sendromu", "pearl": "Krup tedavisinde steroid (deksametazon) temeldir; orta-ağır olgularda nebül adrenalin eklenir."
  },

  // KARDİYOLOJİ (VAKALAR)
  {
    "id": "cardio_01", "specialty": "Kardiyoloji", "title": "Ezici Göğüs Ağrısı ve Hipotansiyon", "diff": "ZOR", "xp": 350, "initial_stability": 45,
    "patient": {"name": "Mehmet Y.", "age": 58, "gender": "Erkek", "complaint": "1 saattir süren sol kola ve çeneye vuran göğüs ağrısı."},
    "history": "Hipertansiyon, 30 paket/yıl sigara.", "vitals": {"hr": "112", "bp": "85/55", "spo2": "91", "rr": "24", "temp": "36.6", "gcs": "15/15", "status": "Kritik"},
    "questions": [
      {"q": "Ağrı tam olarak nasıl bir his?", "a": "Göğsüme tonlarca ağırlık çökmüş gibi, sol kolumu hissetmiyorum."},
      {"q": "Terleme veya bulantı eşlik etti mi?", "a": "Soğuk soğuk terliyorum, midem çok bulanıyor."},
      {"q": "Daha önce eforla ağrınız olur muydu?", "a": "Merdiven çıkarken hafif sıkışma olurdu ama bu bambaşka."},
      {"q": "Aspirin aldınız mı?", "a": "Hayır hiçbir ilaç almadım."}
    ],
    "tests": [
      {"name": "12 Derivasyonlu EKG", "duration": 60, "res": "V1-V4 derivasyonlarında ST elevasyonu (Akut Anterior STEMI)."},
      {"name": "Kardiyak Troponin I", "duration": 60, "res": "1.850 ng/L (Kritik Pozitif)."},
      {"name": "Yatak Başı Ekokardiyografi", "duration": 75, "res": "Anterior duvarda belirgin hipokinezi, EF: %35."}
    ],
    "treatments": [
      {"name": "Aspirin 300 mg çiğnetme + Tikagrelor 180 mg", "duration": 30, "feed": "İkili antiplatelet tedavi hızla verildi.", "score": 30, "is_correct": true, "vitals_update": {}, "stability_delta": 15},
      {"name": "Acil Kateter Laboratuvarı & Primer PCI", "duration": 30, "feed": "LAD tam tıkalı bulundu, stent ile damar açıldı!", "score": 50, "is_correct": true, "vitals_update": {"hr": "76", "bp": "120/75", "spo2": "98", "status": "Stabil"}, "stability_delta": 40},
      {"name": "2000 ml Hızlı SF Sıvı Yüklemesi", "duration": 30, "feed": "Hayati Hata! Sol ventrikül yetmezliğinde sıvı yükü akciğer ödemini tetikledi!", "score": -45, "is_correct": false, "vitals_update": {"spo2": "82", "rr": "32", "status": "Arrest Riski"}, "stability_delta": -35},
      {"name": "Oksijen Tedavisi (Nazal 4 L/dk)", "duration": 30, "feed": "Doku hipoksisi düzeltildi.", "score": 20, "is_correct": true, "vitals_update": {"spo2": "97"}, "stability_delta": 10}
    ],
    "consultations": [{"specialty": "Girişimsel Kardiyoloji", "response": "Kardiyolog: STEMI doğrulanmış. Anjiyo masası hazır, hastayı hemen kateter salonuna indirin."}],
    "diag": "Akut Anterior STEMI", "pearl": "STEMI olgularında kapı-balon süresi <90 dk olmalı, çift antiplatelet yüklenip acil PCI yapılmalıdır."
  },
  {
    "id": "cardio_02", "specialty": "Kardiyoloji", "title": "Sırta Vuran Yırtıcı Göğüs Ağrısı", "diff": "ZOR", "xp": 450, "initial_stability": 40,
    "patient": {"name": "Hikmet R.", "age": 63, "gender": "Erkek", "complaint": "İki kürek kemiği arasına vuran çok şiddetli yırtılır tarzda ağrı."},
    "history": "Kontrolsüz hipertansiyon.", "vitals": {"hr": "98", "bp": "190/115", "spo2": "96", "rr": "22", "temp": "36.7", "gcs": "15/15", "status": "Hayati Tehlike"},
    "questions": [
      {"q": "Ağrı aniden mi başladı?", "a": "Evet sırtıma bıçak saplanıp yırtılıyor gibi aniden başladı."},
      {"q": "İki kolunuz arasında nabız farkı hissediyor musunuz?", "a": "Sağ kolum uyuşuk gibi."},
      {"q": "Tansiyon ilacınızı düzenli alır mısınız?", "a": "İhmal ediyordum, tansiyonum genelde 18-19 gezerdi."},
      {"q": "Ses kısıklığı oldu mu?", "a": "Ağrıyla beraber sesim çatallaştı."}
    ],
    "tests": [
      {"name": "Toraks BT Anjiyografi (Aort)", "duration": 90, "res": "Çıkan aortta intimal flep ve yalancı lümen (Tip A Diseksiyon)."},
      {"name": "12 Derivasyonlu EKG", "duration": 45, "res": "Sol ventrikül hipertrofisi bulguları, ST elevasyonu yok."},
      {"name": "D-Dimer Testi", "duration": 60, "res": "Belirgin yüksek pozitif (>5000 ng/mL)."}
    ],
    "treatments": [
      {"name": "IV Esmolol İnfüzyonu (Hedef KAH < 60, TA < 120)", "duration": 30, "feed": "Aort duvarına binen kesme kuvveti düşürüldü, diseksiyon ilerlemesi frenlendi.", "score": 45, "is_correct": true, "vitals_update": {"bp": "115/70", "hr": "58", "status": "Stabil"}, "stability_delta": 30},
      {"name": "Acil Trombolitik (rtPA) ve Heparin", "duration": 30, "feed": "Fatal Hata! Aort diseksiyonunda trombolitik masif perikardiyal tamponada ve ölüme yol açtı!", "score": -50, "is_correct": false, "vitals_update": {"bp": "50/20", "status": "Kardiyak Arrest"}, "stability_delta": -40},
      {"name": "Acil Kalp Damar Cerrahisi Ameliyathane Hazırlığı", "duration": 30, "feed": "Acil greft replasmanı için ameliyathaneye devredildi.", "score": 45, "is_correct": true, "vitals_update": {}, "stability_delta": 25},
      {"name": "IV Morfin ile Ağrı Kontrolü", "duration": 30, "feed": "Sempatik deşarj baskılandı.", "score": 20, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [{"specialty": "Kalp Damar Cerrahisi", "response": "KDC Uzmanı: Tip A Diseksiyon cerrahi acildir. Tansiyonu beta blokerle kontrol edip hastayı hemen ameliyathaneye alın."}],
    "diag": "Akut Tip A Aort Diseksiyonu", "pearl": "Trombolitik KESİNLİKLE kontrendikedir! Tansiyon esmolol ile düşürülüp acil cerrahiye alınır."
  },

  // ACİL TIP (VAKALAR)
  {
    "id": "em_01", "specialty": "Acil Tıp", "title": "Sol Bacakta Ani Şiddetli Ağrı ve Şişlik", "diff": "ORTA", "xp": 250, "initial_stability": 70,
    "patient": {"name": "Burak Y.", "age": 24, "gender": "Erkek", "complaint": "Sol baldırda aniden başlayan şiddetli gerginlik, ağrı."},
    "history": "3 gün önce 14 saatlik otobüs yolculuğu.", "vitals": {"hr": "94", "bp": "125/80", "spo2": "98", "rr": "16", "temp": "36.8", "gcs": "15/15", "status": "Semptomatik"},
    "questions": [
      {"q": "Ağrı tam olarak nerede?", "a": "Sol baldırımda taş gibi bir sertlik var, basamıyorum."},
      {"q": "Nefes darlığı veya göğüs ağrısı var mı?", "a": "Hayır sadece bacağımda ağrı var."},
      {"q": "Daha önce pıhtı öyküsü var mı?", "a": "Hayır ilk defa oluyor."},
      {"q": "Ailenizde pıhtı atması yaşayan oldu mu?", "a": "Teyzemde derin ven trombozu olmuştu."}
    ],
    "tests": [
      {"name": "Alt Ekstremite Venöz Doppler", "duration": 60, "res": "Sol femoral ve popliteal vende tam oklüziv DVT."},
      {"name": "D-Dimer Testi", "duration": 45, "res": "3.420 ng/mL (Kritik Pozitif)."},
      {"name": "Tam Kan Sayımı", "duration": 45, "res": "Hemogram normal sınırlarda."}
    ],
    "treatments": [
      {"name": "Enoksaparin (LMWH) 1 mg/kg SC", "duration": 30, "feed": "Antikoagülan tedavi başlandı, emboli riski baskılandı.", "score": 40, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 25},
      {"name": "Sol Bacağa Sıcak Masaj Yapılması", "duration": 30, "feed": "Kritik Hata! Masaj trombüsün kopmasına ve masif akciğer embolisine yol açtı!", "score": -40, "is_correct": false, "vitals_update": {"hr": "128", "spo2": "84", "rr": "28", "status": "Kritik Kötüleşme"}, "stability_delta": -35},
      {"name": "Bacak Elevasyonu ve İstirahat", "duration": 30, "feed": "Venöz dönüş rahatlatıldı.", "score": 20, "is_correct": true, "vitals_update": {}, "stability_delta": 10},
      {"name": "Klinik Takip ve Hidrasyon", "duration": 30, "feed": "Hasta izleme alındı.", "score": 20, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [{"specialty": "Kalp Damar Cerrahisi", "response": "KDC: Doppler DVT ile uyumlu. Cerrahi gerekmez, LMWH tedavisine devam edin."}],
    "diag": "Derin Ven Trombozu (DVT)", "pearl": "Renkli Doppler USG ile tanı konur; masaj kontrendikedir, LMWH başlanır."
  },
  {
    "id": "em_02", "specialty": "Acil Tıp", "title": "Trafik Kazası Sonrası Solunum Durması", "diff": "ZOR", "xp": 450, "initial_stability": 30,
    "patient": {"name": "Serkan B.", "age": 28, "gender": "Erkek", "complaint": "Kaza sonrası sağ göğüs ağrısı, nefes alamama, boyun venleri dolgun."},
    "history": "Motosiklet kazası.", "vitals": {"hr": "138", "bp": "65/40", "spo2": "76", "rr": "36", "temp": "36.2", "gcs": "10/15", "status": "Hayati Tehlike"},
    "questions": [
      {"q": "Göğsünüzü bir yere çarptınız mı?", "a": "Gidona çok sert çarptım, nefesim tıkandı."},
      {"q": "Hangi tarafınız daha çok ağrıyor?", "a": "Sağ tarafım parçalanıyor gibi."},
      {"q": "Baş dönmesi veya baygınlık hissi var mı?", "a": "Gözlerim kararıyor, bayılacak gibiyim."},
      {"q": "Kan tükürdünüz mü?", "a": "Hayır kan gelmedi."}
    ],
    "tests": [
      {"name": "Göğüs Oskültasyonu & Muayene", "duration": 30, "res": "Sağda solunum sesleri tamamen yok, trakea sola deviye."},
      {"name": "E-FAST Ultrasonografi", "duration": 45, "res": "Sağ hemitoraksta plevral kayma kaybı (Pnömotoraks). Batın temiz."},
      {"name": "Arteryel Kan Gazı", "duration": 60, "res": "pH: 7.22, PaO2: 48 mmHg (Ağır hipoksemi)."}
    ],
    "treatments": [
      {"name": "Acil İğne Torakostomi (2. İK Aralık)", "duration": 30, "feed": "Hava büyük bir tıslamayla boşaldı! Kalbe venöz dönüş açıldı, tansiyon hızla toparladı.", "score": 50, "is_correct": true, "vitals_update": {"bp": "110/70", "hr": "95", "spo2": "94", "status": "Stabil"}, "stability_delta": 40},
      {"name": "Tüp Torakostomi (Göğüs Tüpü)", "duration": 30, "feed": "Akciğer tam reekspanse oldu, su altı drenajı sağlandı.", "score": 45, "is_correct": true, "vitals_update": {"spo2": "98", "rr": "18", "gcs": "15/15"}, "stability_delta": 25},
      {"name": "Grafi İçin Hastayı Radyolojiye Gönderme", "duration": 30, "feed": "Ölümcül Gecikme! Tansiyon pnömotoraks klinik tanıdır; röntgen beklerken kardiyak arrest gelişti!", "score": -50, "is_correct": false, "vitals_update": {"bp": "40/10", "hr": "160", "status": "Arrest"}, "stability_delta": -40},
      {"name": "%100 Rezervuarlı Maske ile Oksijen", "duration": 30, "feed": "Oksijen desteği sağlandı.", "score": 20, "is_correct": true, "vitals_update": {"spo2": "88"}, "stability_delta": 10}
    ],
    "consultations": [{"specialty": "Göğüs Cerrahisi", "response": "Göğüs Cerrahı: İğne dekompresyonu hayat kurtarmış. 28F göğüs tüpü takıp su altı drenajına bağlayın."}],
    "diag": "Tansiyon Pnömotoraks", "pearl": "Grafi beklenmeden derhal 2. İK aralıktan iğne dekompresyonu ve göğüs tüpü takılmalıdır."
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (_) => EmergencyDispatchScreen(caseData: kAllClinicalCases[0])));
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
                      Text("Tüm tetkik ve tedavilerin ansiklopedisi (12 Kılavuz)", style: TextStyle(color: Colors.grey, fontSize: 12)),
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
// ACİL SERVİS BİLDİRİMİ EKRANI (GÖRSEL 2 İLE BİREBİR)
// -------------------------------------------------------------
class EmergencyDispatchScreen extends StatelessWidget {
  final Map<String, dynamic> caseData;
  const EmergencyDispatchScreen({super.key, required this.caseData});

  @override
  Widget build(BuildContext context) {
    final p = caseData['patient'];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.chevron_left, color: Colors.black87, size: 28), onPressed: () => Navigator.pop(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(color: Color(0xFFFEE2E2), shape: BoxShape.circle),
                child: const Icon(Icons.monitor_heart, color: Colors.red, size: 40),
              ),
            ),
            const SizedBox(height: 16),
            const Text("ACİL SERVİS BİLDİRİMİ ALINDI...", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 0.5)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(12)),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, color: Colors.red, size: 8),
                  SizedBox(width: 6),
                  Text("Yüksek Öncelikli Vaka", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black.withOpacity(0.05))),
              child: Row(
                children: [
                  const CircleAvatar(radius: 24, backgroundColor: Color(0xFFEDE9FE), child: Icon(Icons.person, color: Color(0xFF6366F1))),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text("${p['age']} Yaş, ${p['gender']} • ${p['complaint']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, height: 1.3)),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: const Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(6)),
                        child: Text("● ${caseData['specialty'].toUpperCase()}", style: const TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
                      )
                    ]),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(10)),
              child: const Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 14),
                SizedBox(width: 6),
                Text("Veri çekme BAŞARILI", style: TextStyle(color: Color(0xFF16A34A), fontWeight: FontWeight.bold, fontSize: 12)),
              ]),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black.withOpacity(0.05))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Row(children: [
                  Icon(Icons.history_toggle_off, color: Color(0xFF6366F1), size: 16),
                  SizedBox(width: 6),
                  Text("ÖZGEÇMİŞ", style: TextStyle(color: Color(0xFF6366F1), fontWeight: FontWeight.bold, fontSize: 12)),
                ]),
                const SizedBox(height: 8),
                Text(caseData['history'] as String, style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4)),
              ]),
            ),
            const Spacer(),
            const Text("ANAMNEZ AL, VİTALLERİ İNCELE.\nYANLIŞ KARARDA ZAMAN ALEYHİNE İŞLER!", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, height: 1.4)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), padding: const EdgeInsets.all(16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProcedureRoomScreen(caseData: caseData)));
                },
                child: const Text("Müdahale Odasına Başla", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// 2. KEŞFET
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
        title: Text("$specialtyName Vakaları", style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.chevron_left, color: Colors.black87, size: 28), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cases.length,
        itemBuilder: (context, idx) {
          final c = cases[idx];
          final isCompleted = UserProfile.completedCaseIds.contains(c['id']);

          return Card(
            color: Colors.white,
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.black.withOpacity(0.04))),
            child: ListTile(
              contentPadding: const EdgeInsets.all(14),
              leading: CircleAvatar(backgroundColor: isCompleted ? const Color(0xFFDCFCE7) : const Color(0xFFEDE9FE), child: Icon(isCompleted ? Icons.check : Icons.medical_services, color: isCompleted ? const Color(0xFF16A34A) : const Color(0xFF7C3AED))),
              title: Row(
                children: [
                  Expanded(child: Text(c['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                  if (isCompleted)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(6)),
                      child: const Text("✓ Çözüldü", style: TextStyle(color: Color(0xFF16A34A), fontSize: 10, fontWeight: FontWeight.bold)),
                    )
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text("${c['patient']['age']}y, ${c['patient']['gender']} • ${c['diff']} • ${c['xp']} XP", style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ),
              trailing: const Icon(Icons.play_circle_fill, color: Color(0xFF6366F1), size: 32),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EmergencyDispatchScreen(caseData: c))),
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
// 4. VAKALARIM EKRANI (TİK İŞARETİ VE DİNAMİK LİSTE)
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
            _buildGrid(context, kAllClinicalCases),
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
        final isCompleted = UserProfile.completedCaseIds.contains(c['id']);

        return InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EmergencyDispatchScreen(caseData: c))),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: isCompleted ? Colors.green.shade300 : (isHard ? const Color(0xFFFCA5A5) : const Color(0xFFFDE68A)))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: isHard ? const Color(0xFFFEE2E2) : const Color(0xFFFEF9C3), shape: BoxShape.circle), child: Icon(Icons.biotech, color: isHard ? Colors.red : Colors.orange, size: 18)),
                    if (isCompleted)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(6)),
                        child: const Row(children: [
                          Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 12),
                          SizedBox(width: 2),
                          Text("Tamam", style: TextStyle(color: Color(0xFF16A34A), fontSize: 9, fontWeight: FontWeight.bold)),
                        ]),
                      )
                  ],
                ),
                Text(c['patient']['complaint'] ?? c['title'], maxLines: 4, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Colors.black87)),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: isHard ? Colors.red.shade100 : Colors.amber.shade100, borderRadius: BorderRadius.circular(6)), child: Text(c['diff'] ?? "ORTA", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isHard ? Colors.red.shade800 : Colors.amber.shade900))),
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
                  "diff": "ORTA",
                  "xp": 300,
                  "initial_stability": 65,
                  "patient": {
                    "name": "Özel Vaka Hastası",
                    "age": 35,
                    "gender": "Kadın",
                    "complaint": _complaintController.text.isEmpty ? "Akut semptomlarla başvuru." : _complaintController.text
                  },
                  "history": "Özgeçmişinde özellik saptanmadı.",
                  "vitals": {"hr": "88", "bp": "120/80", "spo2": "98", "rr": "16", "temp": "36.7", "gcs": "15/15", "status": "Stabil"},
                  "questions": [
                    {"q": "Ağrı ne zamandan beri var?", "a": "Dünden beri devam ediyor."},
                    {"q": "İlaç kullandınız mı?", "a": "Ağrı kesici aldım ama fayda etmedi."},
                    {"q": "Bulantı kusma oldu mu?", "a": "Hafif bulantı hissi var."},
                    {"q": "Kronik rahatsızlık var mı?", "a": "Bildiğim bir kronik hastalığım yok."}
                  ],
                  "tests": [
                    {"name": "Tam Kan Sayımı", "duration": 45, "res": "Lökosit ve hemoglobin normal."},
                    {"name": "Radyolojik İnceleme", "duration": 60, "res": "Akut patoloji izlenmedi."}
                  ],
                  "treatments": [
                    {"name": "IV Sıvı ve Semptomatik Tedavi", "duration": 30, "feed": "Hasta rahatladı, vitaller stabil.", "score": 30, "is_correct": true, "vitals_update": {}, "stability_delta": 20},
                    {"name": "Uygunsuz Doz Sedatif Tedavisi", "duration": 30, "feed": "Klinik Hata! Solunum depresyonu riski oluştu!", "score": -30, "is_correct": false, "vitals_update": {"spo2": "90"}, "stability_delta": -25}
                  ],
                  "consultations": [
                    {"specialty": "Klinik Uzmanı", "response": "Uzman: Vaka yönetimi başarılı."}
                  ],
                  "diag": _titleController.text,
                  "pearl": "Kendi oluşturduğunuz klinik senaryonuz."
                };
                UserProfile.userCreatedCases.add(newCase);
                kAllClinicalCases.add(newCase);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vakanız kaydedildi ve 'Vakalarım' sekmesine eklendi!")));
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
// 6. MÜDAHALE ODASI (CANLI GERÇEK SAYAC, 1-2 DK TETKİK, 30 SN TEDAVİ)
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

    // Canlı Kronometre (00:00, 00:01...)
    _caseTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() => _secondsElapsed++);
    });

    // Başlangıçta sadece Vaka Başladı kartı
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

  // Tetkik Başlatma (1 ila 2 dakika arası gerçek geri sayım)
  void _startDiagnostic(Map<String, dynamic> test) {
    if (doneTests.contains(test['name'])) return;
    if (ongoingActionName != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Halen devam eden bir işlem var, lütfen bekleyin!")));
      return;
    }

    final duration = (test['duration'] as int?) ?? 60;
    setState(() {
      ongoingActionName = "Tetkik: ${test['name']}";
      ongoingActionSeconds = duration;
      logs.add({
        "t": "Tetkik Başlatıldı",
        "tm": _formatTime(_secondsElapsed),
        "c": const Color(0xFF6366F1),
        "i": Icons.hourglass_top_rounded,
        "m": "${test['name']}\nLaboratuvara iletildi (Süre: $duration sn)."
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

  // Tedavi Uygulama (30 saniyelik devam eden işlem barı ve dinamik vital değişimi)
  void _applyTreatment(Map<String, dynamic> trt) {
    if (doneTrts.contains(trt['name'])) return;
    if (ongoingActionName != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Halen devam eden bir işlem var, lütfen bekleyin!")));
      return;
    }
    Navigator.pop(context);

    const duration = 30; // 30 saniye kuralı
    setState(() {
      ongoingActionName = "Tedavi Uygulanıyor: ${trt['name']}";
      ongoingActionSeconds = duration;
      logs.add({
        "t": "Tedavi Başlatıldı",
        "tm": _formatTime(_secondsElapsed),
        "c": const Color(0xFFEA580C),
        "i": Icons.medication_liquid_rounded,
        "m": "${trt['name']}\nİlaç/Müdahale veriliyor (30 saniye bekleniyor)..."
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
          doneTrts.add(trt['name']);
          final bool isCorrect = trt['is_correct'] ?? true;
          final int delta = (trt['stability_delta'] as int?) ?? 0;
          stability = (stability + delta).clamp(5, 100);

          // MONİTÖR VİTALLERİNİ GERÇEK ZAMANLI GÜNCELLEME
          final Map<String, dynamic> updates = trt['vitals_update'] ?? {};
          updates.forEach((k, v) => vitals[k] = v);

          logs.add({
            "t": isCorrect ? "Tedavi Etkisini Gösterdi (Stabilizasyon)" : "Kritik Klinik Kötüleşme",
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
    });
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
          const Text("Hastaya Soru Sor (Detaylı Anamnez)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
          const Text("Tedavi & Girişimsel Karar Planı (30 sn Bekleme)", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                  onTap: () {
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
                  },
                ),
              )),
        ]),
      ),
    );
  }

  void _openMonitor() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => MonitorBottomSheet(vitals: vitals),
    );
  }

  void _finishCase() {
    final isSuccess = stability >= 70;
    final xpEarned = isSuccess ? (widget.caseData['xp'] as int? ?? 250) : 50;

    UserProfile.addXp(widget.caseData['id'], xpEarned, isSuccess);

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

          if (ongoingActionName != null)
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFC7D2FE))),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFF99F6E4), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.hourglass_top_rounded, color: Color(0xFF0D9488), size: 16)),
                  const SizedBox(width: 8),
                  Text(ongoingActionName!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ]),
                Text("$ongoingActionSeconds sn kaldı", style: const TextStyle(color: Color(0xFF4F46E5), fontWeight: FontWeight.bold, fontSize: 12)),
              ]),
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
// 7. HASTA MONİTÖRÜ MODALI (DİNAMİK VİTALLER - EKRAN 2)
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
              Text("6 parametre izleniyor (Canlı)", style: TextStyle(color: Colors.grey, fontSize: 12)),
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
