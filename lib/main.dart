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
// 40 GERÇEK TIBBİ VAKA VERİ TABANI (HER BRANŞTA TAM 10 VAKA)
// -------------------------------------------------------------
final List<Map<String, dynamic>> kAllClinicalCases = [
  // 1. NÖROLOJİ (10 VAKA)
  {
    "id": "neuro_01", "specialty": "Nöroloji", "title": "Ani Sağ Kol Kuvvetsizliği ve Afazi", "diff": "ZOR", "xp": 350, "initial_stability": 50,
    "patient": {"name": "Fatma D.", "age": 68, "gender": "Kadın", "complaint": "1 saat önce sağ kol ve bacakta felç, konuşamama."},
    "history": "Atriyal fibrilasyon, hipertansiyon. Kan sulandırıcı aksatılmış.",
    "vitals": {"hr": "106", "bp": "175/95", "spo2": "96", "rr": "18", "temp": "36.7", "gcs": "11/15", "status": "Kritik"},
    "questions": [
      {"q": "Belirtiler tam saat kaçta başladı?", "a": "50 dakika önce kahvaltıda başladı."},
      {"q": "Daha önce benzer durum oldu mu?", "a": "Hayır ilk kez oldu, ilacını aksatmıştı."},
      {"q": "Baş ağrısı var mı?", "a": "Baş ağrısı yok."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Kontrassız Beyin BT", "duration": 60, "res": "Hemoraji yok. Sol MCA erken silinme bulgusu."},
      {"name": "Koagülasyon Paneli", "duration": 45, "res": "INR: 1.15 (Trombolitik için güvenli)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "IV Trombolitik (rtPA) 0.9 mg/kg", "duration": 30, "feed": "İlk 4.5 saatte tromboliz uygulandı, motor güç toparlamaya başladı.", "score": 45, "is_correct": true, "vitals_update": {"hr": "78", "bp": "135/85", "spo2": "99", "rr": "16", "temp": "36.7", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Yüksek Doz IV Heparin Bolusu", "duration": 30, "feed": "Kritik Hata! Akut iskemide erken heparin beyin kanamasına yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "130", "bp": "200/115", "spo2": "90", "rr": "24", "temp": "37.5", "gcs": "7/15", "status": "Koma Riski"}, "stability_delta": -35},
      {"name": "Tansiyon Regülasyonu (IV Labetalol)", "duration": 30, "feed": "Tansiyon 185/110 altına çekilerek güvenli sınır sağlandı.", "score": 20, "is_correct": true, "vitals_update": {"bp": "155/90", "hr": "86", "spo2": "98", "status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Nöroloji İcapçı Hekimi", "response": "Nörolog: BT kanamayı dışladı, semptom 1 saat. rtPA başlatıp anjiyo ekibini çağırın."}
    ],
    "diag": "Akut İskemik İnme (Sol MCA)", "pearl": "İlk 4.5 saatte kontrassız BT ile kanama dışlanıp trombolitik başlanmalıdır."
  },
  {
    "id": "neuro_02", "specialty": "Nöroloji", "title": "Gök Gürültüsü Baş Ağrısı ve Kusma", "diff": "ZOR", "xp": 400, "initial_stability": 55,
    "patient": {"name": "Cemil A.", "age": 44, "gender": "Erkek", "complaint": "Balyoz vurulmuş gibi ani baş ağrısı, fışkırır kusma."},
    "history": "Polikistik böbrek hastalığı, sigara.",
    "vitals": {"hr": "62", "bp": "185/105", "spo2": "97", "rr": "16", "temp": "37.2", "gcs": "13/15", "status": "Kritik"},
    "questions": [
      {"q": "Ağrı ne kadar sürede tepeye ulaştı?", "a": "Saniyeler içinde patladı!"},
      {"q": "Ensenizi bükebiliyor musunuz?", "a": "Çenemi göğsüme değdiremiyorum, ensem taş gibi."},
      {"q": "Işık rahatsız ediyor mu?", "a": "Gözlerimi açamıyorum, ışık batıyor."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Kontrassız Beyin BT", "duration": 60, "res": "Bazal sisternlerde hiperdens akut subaraknoid kanama."},
      {"name": "Beyin BT Anjiyografi", "duration": 90, "res": "AComA üzerinde 6 mm sakküler anevrizma."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Nimodipin 60 mg + Tansiyon Titrasyonu", "duration": 30, "feed": "Serebral vazospazm profilaksisi başlandı, re-kanama riski azaltıldı.", "score": 45, "is_correct": true, "vitals_update": {"hr": "68", "bp": "130/80", "spo2": "99", "rr": "14", "temp": "36.8", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Yüksek Doz Aspirin + Heparin", "duration": 30, "feed": "Kritik Hata! Aktif kanamada antikoagülan fatal re-kanamaya yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "44", "bp": "210/120", "spo2": "88", "rr": "10", "temp": "38.0", "gcs": "6/15", "status": "Koma"}, "stability_delta": -35},
      {"name": "Acil Nöroşirürji Koilleme Hazırlığı", "duration": 30, "feed": "Anevrizma endovasküler yolla koillendi, kanama odağı kapatıldı.", "score": 20, "is_correct": true, "vitals_update": {"hr": "72", "bp": "125/75", "spo2": "99", "status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Beyin Cerrahisi", "response": "Beyin Cerrahı: SAK teyit edildi. Anjiyo salonunda acil koillemeye alıyoruz."}
    ],
    "diag": "Subaraknoid Kanama (Anevrizma Rüptürü)", "pearl": "Gök gürültüsü baş ağrısında SAK aranmalıdır; nimodipin başlanıp cerrahi konsülte edilir."
  },
  {
    "id": "neuro_03", "specialty": "Nöroloji", "title": "Durdurulamayan Nöbet (Status Epileptikus)", "diff": "ZOR", "xp": 450, "initial_stability": 35,
    "patient": {"name": "Eren K.", "age": 29, "gender": "Erkek", "complaint": "20 dakikadır süren aralıksız jeneralize kasılma."},
    "history": "Dirençli epilepsi, ilaç kesme.",
    "vitals": {"hr": "138", "bp": "160/95", "spo2": "86", "rr": "26", "temp": "38.5", "gcs": "6/15", "status": "Hayati Tehlike"},
    "questions": [
      {"q": "Nöbet ne kadar sürdü?", "a": "20 dakikadır aralıksız kasılıyor."},
      {"q": "İlaçlarını alıyor muydu?", "a": "3 gündür ilaçlarını almamıştı."},
      {"q": "Ateş veya travma oldu mu?", "a": "Hayır aniden başladı."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Parmak Ucu Glukoz Ölçümü", "duration": 30, "res": "98 mg/dL (Hipoglisemi yok)."},
      {"name": "Arteryel Kan Gazı", "duration": 45, "res": "pH: 7.18, Laktat: 6.2 mmol/L (Ağır laktik asidoz)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "IV Levetirasetam 60 mg/kg + Diazepam 10 mg", "duration": 30, "feed": "Antikonvülzan tedaviyle nöbet tamamen sonlandırıldı!", "score": 45, "is_correct": true, "vitals_update": {"hr": "82", "bp": "120/75", "spo2": "98", "rr": "16", "temp": "37.0", "gcs": "14/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Ağza Tahta Kaşık Sokmaya Çalışma", "duration": 30, "feed": "Hatalı Yaklaşım! Diş kırığı ve laringeal aspirasyon riski oluşturur.", "score": -45, "is_correct": false, "vitals_update": {"hr": "150", "bp": "170/100", "spo2": "76", "rr": "30", "status": "Kritik Boğulma"}, "stability_delta": -35},
      {"name": "Oksijen Maskesi ve Havayolu Güvenliği", "duration": 30, "feed": "Hipoksi önlendi, satürasyon toparladı.", "score": 20, "is_correct": true, "vitals_update": {"spo2": "96", "hr": "115", "status": "Toparlıyor"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Nöroloji Yoğun Bakım", "response": "Uzman: Benzodiazepin sonrası nöbet durmazsa entübasyon ve propofole geçin."}
    ],
    "diag": "Konvülzif Status Epileptikus", "pearl": "5 dakikayı aşan nöbetlerde gecikmeden IV benzodiazepin ve levetirasetam verilmelidir."
  },
  {
    "id": "neuro_04", "specialty": "Nöroloji", "title": "Ayaklardan Yükselen Felç ve Uyuşma", "diff": "ORTA", "xp": 300, "initial_stability": 65,
    "patient": {"name": "Aylin S.", "age": 33, "gender": "Kadın", "complaint": "Ayaklardan başlayıp gövdeye tırmanan kuvvetsizlik."},
    "history": "2 hafta önce geçirilmiş bakteriyel ishal.",
    "vitals": {"hr": "88", "bp": "120/75", "spo2": "97", "rr": "18", "temp": "36.8", "gcs": "15/15", "status": "Semptomatik"},
    "questions": [
      {"q": "Kuvvetsizlik nasıl ilerledi?", "a": "Önce ayaklarım uyuştu, sonra bacaklarım ve ellerim tutmaz oldu."},
      {"q": "Nefes alırken zorlanıyor musunuz?", "a": "Derin nefeste göğsüm sıkışıyor."},
      {"q": "Son 1 ayda enfeksiyon geçirdiniz mi?", "a": "2 hafta önce şiddetli ishal olmuştum."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Derin Tendon Refleksleri Muayenesi", "duration": 30, "res": "Aşil ve patella refleksleri bilateral arefleksik (yok)."},
      {"name": "FVC Solunum Kapasitesi Ölçümü", "duration": 45, "res": "FVC: 18 ml/kg (Sınırda)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "IVIG 0.4 g/kg/gün Başlanması", "duration": 30, "feed": "Otoimmün demiyelinizasyon durduruldu, motor kayıp geriledi.", "score": 45, "is_correct": true, "vitals_update": {"hr": "76", "bp": "120/80", "spo2": "99", "rr": "15", "temp": "36.6", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Yüksek Doz Sistemik Steroid", "duration": 30, "feed": "Hatalı Tedavi: GBS'de steroidlerin yeri yoktur, iyileşmeyi geciktirebilir.", "score": -45, "is_correct": false, "vitals_update": {"hr": "98", "bp": "145/95", "status": "Kötüleşiyor"}, "stability_delta": -35},
      {"name": "Solunum Kapasitesi Yakın Takibi", "duration": 30, "feed": "Vital kapasite izleme alındı.", "score": 20, "is_correct": true, "vitals_update": {"rr": "16", "spo2": "98"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Nöroloji Kliniği", "response": "Nörolog: GBS tablosu. FVC < 15 ml/kg olursa entübasyon için YBÜ hazırlığı yapın."}
    ],
    "diag": "Guillain-Barré Sendromu (GBS)", "pearl": "Simetrik asendan paralizi ve areflekside FVC takibi ve IVIG tedavisi esastır."
  },
  {
    "id": "neuro_05", "specialty": "Nöroloji", "title": "Tek Taraflı Yüz Felci ve Göz Kapatamama", "diff": "KOLAY", "xp": 200, "initial_stability": 85,
    "patient": {"name": "Hasan B.", "age": 41, "gender": "Erkek", "complaint": "Yüzün sağ yarısında felç, alnı kırıştıramama."},
    "history": "Soğuk hava/klima maruziyeti.",
    "vitals": {"hr": "76", "bp": "125/80", "spo2": "99", "rr": "14", "temp": "36.6", "gcs": "15/15", "status": "Stabil"},
    "questions": [
      {"q": "Alnınızı yukarı kırıştırmayı dener misiniz?", "a": "Sağ taraf hiç kırışmıyor, tamamen donuk."},
      {"q": "Kol veya bacağınızda güçsüzlük var mı?", "a": "Hayır kollarım sapasağlam."},
      {"q": "Ağzınızda tat değişikliği oldu mu?", "a": "Dilimin ön kısmında tatları garip alıyorum."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Kraniyal Sinir VII Muayenesi", "duration": 30, "res": "Sağ periferik fasiyal paralizi (Alın tutulumu pozitif)."},
      {"name": "Nörolojik Odak Muayenesi", "duration": 45, "res": "Ek motor/duyusal defisit yok, testler normal."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Oral Prednizolon 1 mg/kg + Suni Gözyaşı", "duration": 30, "feed": "Fasiyal sinir ödemi geriletildi, kornea kuruması önlendi.", "score": 45, "is_correct": true, "vitals_update": {"hr": "72", "bp": "120/75", "spo2": "99", "rr": "14", "temp": "36.6", "gcs": "15/15", "status": "Şifayla Taburcu"}, "stability_delta": 35},
      {"name": "Acil Trombolitik Tedavi (rtPA)", "duration": 30, "feed": "Hayati Hata! Periferik yüz felci santral inme değildir, gereksiz trombolitik kanama riski doğurur!", "score": -45, "is_correct": false, "vitals_update": {"hr": "115", "bp": "170/100", "gcs": "13/15", "status": "Kritik"}, "stability_delta": -35},
      {"name": "Göz Kapama Bandı (Gece Koruması)", "duration": 30, "feed": "Lagofitalmiye bağlı kornea ülseri engellendi.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Nöroloji Polikliniği", "response": "Nörolog: Klasik Bell paralizisi. Steroid ve göz korumasıyla taburcu edin."}
    ],
    "diag": "Bell Paralizisi", "pearl": "Alın kaslarının tutulumu periferik felci santral inmeden ayıran en belirgin bulgudur."
  },
  {
    "id": "neuro_06", "specialty": "Nöroloji", "title": "Akşama Doğru Artan Pitozis ve Yorgunluk", "diff": "ORTA", "xp": 300, "initial_stability": 70,
    "patient": {"name": "Merve T.", "age": 27, "gender": "Kadın", "complaint": "Çift görme, göz kapağı düşmesi ve çiğneme zorluğu."},
    "history": "Son 3 aydır gün sonu artan kuvvetsizlik.",
    "vitals": {"hr": "82", "bp": "115/70", "spo2": "97", "rr": "16", "temp": "36.7", "gcs": "15/15", "status": "Semptomatik"},
    "questions": [
      {"q": "Sabah kalkınca belirtiler var mı?", "a": "Sabahları gayet iyiyim, akşama doğru gözüm kapanıyor."},
      {"q": "Yutma zorluğu oldu mu?", "a": "Yemek yerken lokmalar bazen boğazıma takılıyor."},
      {"q": "Nefes darlığı hissediyor musunuz?", "a": "Hızlı yürüyünce nefes nefese kalıyorum."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Buz Testi (Ice Pack Test)", "duration": 30, "res": "Göz kapağına 2 dk buz uygulama sonrası pitoziste 3 mm düzelme (Pozitif)."},
      {"name": "Toraks BT (Timoma Taraması)", "duration": 60, "res": "Ön mediastende timus hiperplazisi."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Oral Piridostigmin 60 mg Başlanması", "duration": 30, "feed": "Asetilkolinesteraz inhibisyonuyla kas gücü hızla toparladı.", "score": 45, "is_correct": true, "vitals_update": {"hr": "74", "bp": "120/75", "spo2": "99", "rr": "14", "temp": "36.6", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Yüksek Doz Aminoglikozid Antibiyotik", "duration": 30, "feed": "Kritik Hata! Aminoglikozidler nöromüsküler kavşağı bloke ederek miyastenik krizi tetikler!", "score": -45, "is_correct": false, "vitals_update": {"hr": "128", "bp": "90/55", "spo2": "82", "rr": "28", "status": "Solunum Yetmezliği"}, "stability_delta": -35},
      {"name": "Solunum Kapasitesi Yakın Takibi", "duration": 30, "feed": "Kriz riski yakından izlendi.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Nöroloji Kliniği", "response": "Nörolog: Miyastenia Gravis tanısı kesin. Piridostigmin başlayıp timektomiye yönlendirin."}
    ],
    "diag": "Miyastenia Gravis", "pearl": "Dalgalı kas yorgunluğu MG için tipiktir; aminoglikozid ve beta blokerler kontrendikedir."
  },
  {
    "id": "neuro_07", "specialty": "Nöroloji", "title": "Ateş, Koku Halüsinasyonu ve Konfüzyon", "diff": "ZOR", "xp": 400, "initial_stability": 50,
    "patient": {"name": "Kemal V.", "age": 52, "gender": "Erkek", "complaint": "Yüksek ateş, tuhaf yanık kokuları duyma, hafıza kaybı ve dalgınlık."},
    "history": "Dudakta uçuk lezyonu.",
    "vitals": {"hr": "110", "bp": "135/85", "spo2": "95", "rr": "20", "temp": "39.2", "gcs": "11/15", "status": "Kritik"},
    "questions": [
      {"q": "Ne zamandır anlamsız konuşuyor?", "a": "2 gündür ateşi vardı, dün akşamdan beri hayal görüyor."},
      {"q": "Nöbet geçirdi mi?", "a": "Sabah dudaklarını şapırdatıp birkaç saniye donup kaldı."},
      {"q": "Baş ağrısı var mı?", "a": "Şakaklarım patlayacak diyordu."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Kontrassız Kraniyal BT / MR", "duration": 60, "res": "Unilateral temporal lobda asimetrik ödem ve hiperintensite."},
      {"name": "Lomber Ponksiyon (BOS)", "duration": 75, "res": "Lenfosit hakim pleositoz, eritrosit pozitif, protein 90 mg/dL."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Acil IV Asiklovir 10 mg/kg (8 Saatte Bir)", "duration": 30, "feed": "PCR sonucu beklenmeden başlanan antiviral hayat kurtardı, beyin nekrozu sınırlandı.", "score": 45, "is_correct": true, "vitals_update": {"hr": "84", "bp": "125/80", "spo2": "98", "rr": "16", "temp": "37.5", "gcs": "14/15", "status": "Toparlıyor"}, "stability_delta": 35},
      {"name": "Yüksek Doz Sedatif ile Uyutma (Tedavisiz)", "duration": 30, "feed": "Ölümcül Hata! Antiviral verilmeden bekletilen ensefalitte nekrotik hasar gelişti!", "score": -45, "is_correct": false, "vitals_update": {"hr": "135", "bp": "160/100", "spo2": "89", "rr": "24", "temp": "40.1", "gcs": "6/15", "status": "Koma"}, "stability_delta": -35},
      {"name": "Antiepileptik Tedavi (Levetirasetam)", "duration": 30, "feed": "Temporal lob kaynaklı subklinik nöbetler baskılandı.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Enfeksiyon Hastalıkları", "response": "Konsültan: Temporal tutulum HSV ensefalitini işaret eder. Asiklovir derhal 21 gün IV planlanmalıdır."}
    ],
    "diag": "Herpes Simpleks Ensefaliti (HSV-1)", "pearl": "Temporal lob ödemi ve koku aurasında BOS PCR beklenmeden derhal IV Asiklovir başlanmalıdır."
  },
  {
    "id": "neuro_08", "specialty": "Nöroloji", "title": "Tek Gözde Ağrılı Ani Görme Kaybı", "diff": "ORTA", "xp": 320, "initial_stability": 75,
    "patient": {"name": "Selin O.", "age": 25, "gender": "Kadın", "complaint": "Sağ göz hareketleriyle artan ağrı ve bulanık görme, renkleri soluk görme."},
    "history": "1 yıl önce sol bacakta 3 hafta süren uyuşma.",
    "vitals": {"hr": "74", "bp": "118/72", "spo2": "99", "rr": "14", "temp": "36.5", "gcs": "15/15", "status": "Stabil"},
    "questions": [
      {"q": "Görme kaybı aniden mi oldu?", "a": "Dün sabah başladı, bugün sadece gölgeleri seçebiliyorum."},
      {"q": "Gözü hareket ettirince ağrıyor mu?", "a": "Evet sağa sola bakınca göz kürem sızlıyor."},
      {"q": "Daha önce uyuşma olmuş muydu?", "a": "Geçen yıl sol bacağım uyuşmuştu, kendiliğinden geçmişti."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Marcus Gunn Pupili Muayenesi", "duration": 30, "res": "Sağ gözde rölatif aferent pupil defekti (RAPD) pozitif."},
      {"name": "Beyin ve Orbita MRG", "duration": 75, "res": "Sağ optik sinirde kontrast tutulumu ve periventriküler ovoid plaklar."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "IV Puls Metilprednizolon 1000 mg/gün", "duration": 30, "feed": "Optik sinir inflamasyonu baskılandı, görme keskinliği hızla düzelmeye başladı.", "score": 45, "is_correct": true, "vitals_update": {"hr": "72", "bp": "120/75", "spo2": "99", "rr": "14", "temp": "36.6", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Tek Başına Düşük Doz Oral Prednizolon", "duration": 30, "feed": "Hatalı Yaklaşım! Yalnızca düşük doz oral steroid verilmesi nüks riskini artırır.", "score": -45, "is_correct": false, "vitals_update": {"hr": "80", "status": "Kötüleşiyor"}, "stability_delta": -35},
      {"name": "Miyelin Profilaksisi ve Nöroloji Takibi", "duration": 30, "feed": "MS klinik izlemi planlandı.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Nöroloji Demiylinizan Hastalıklar", "response": "Uzman: Klinik tablo Multipl Skleroz ilk atağı ile uyumlu. 3 gün IV pulse steroid uygulayın."}
    ],
    "diag": "Optik Nörit (Multipl Skleroz İlk Atak)", "pearl": "Marcus Gunn pupili ve retrobulber ağrıda yüksek doz IV puls steroid verilir, tek başına düşük doz oral steroid kontrendikedir."
  },
  {
    "id": "neuro_09", "specialty": "Nöroloji", "title": "İstirahat Tremoru ve Yavaş Yürüme", "diff": "ORTA", "xp": 280, "initial_stability": 80,
    "patient": {"name": "Salih G.", "age": 71, "gender": "Erkek", "complaint": "Sağ elde para sayma tarzı titreme, düğme iliklemede zorluk ve öne eğik yürüme."},
    "history": "Son 1 yıldır koku alma duyusunda azalma.",
    "vitals": {"hr": "68", "bp": "130/80", "spo2": "98", "rr": "16", "temp": "36.6", "gcs": "15/15", "status": "Stabil"},
    "questions": [
      {"q": "Titreme dururken mi oluyor?", "a": "Televizyon izlerken titriyor, bardağı tutunca hafifliyor."},
      {"q": "Yürürken kollarınız sallanıyor mu?", "a": "Sağ kolum hiç sallanmıyor, donuk kalıyor."},
      {"q": "Düşme veya denge kaybı var mı?", "a": "Adımlarım küçüldü, bazen hızlanıp duramıyorum."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Ekstrapiramidal Sistem Muayenesi", "duration": 45, "res": "Dişli çark rijiditesi pozitif, bradikinezi belirgin, asimetrik istirahat tremoru."},
      {"name": "Kraniyal MRG", "duration": 60, "res": "Yaşa uygun serebral atrofi, sekonder parkinsonizm dışlandı."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Levodopa / Benserazid Titrasyonu", "duration": 30, "feed": "Dopamin replase edildi, rijidite ve hareket blokajı belirgin geriledi.", "score": 45, "is_correct": true, "vitals_update": {"hr": "72", "bp": "125/75", "spo2": "99", "rr": "15", "temp": "36.6", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Haloperidol (Antipsikotik) Uygulaması", "duration": 30, "feed": "Kritik Hata! D2 blokajı yaparak akut rijidite ve akinetik krize yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "105", "bp": "155/95", "gcs": "13/15", "status": "Akinetik Kriz"}, "stability_delta": -35},
      {"name": "Fizik Tedavi ve Yürüyüş Egzersizleri", "duration": 30, "feed": "Postüral stabilite desteklendi.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Hareket Bozuklukları Uzmanı", "response": "Nörolog: İdiopatik Parkinson ile uyumlu. Levodopa başlandı, poliklinik takibi önerilir."}
    ],
    "diag": "İdiopatik Parkinson Hastalığı", "pearl": "Asimetrik istirahat tremoru, rijidite ve bradikinezi kardinal bulgulardır; tipik antipsikotikler kontrendikedir."
  },
  {
    "id": "neuro_10", "specialty": "Nöroloji", "title": "Yarım Baş Ağrısı ve Işık Çakması", "diff": "KOLAY", "xp": 200, "initial_stability": 80,
    "patient": {"name": "Ece M.", "age": 28, "gender": "Kadın", "complaint": "Sol şakakta zonklayıcı baş ağrısı, zikzak çizgiler görme, bulantı."},
    "history": "Açlık ve uykusuzlukla tetiklenme.",
    "vitals": {"hr": "80", "bp": "120/75", "spo2": "98", "rr": "16", "temp": "36.6", "gcs": "15/15", "status": "Stabil"},
    "questions": [
      {"q": "Ağrıdan önce ne oldu?", "a": "20 dakika boyunca sol gözümün önünde kırık çizgiler dans etti, sonra ağrı patladı."},
      {"q": "Işık rahatsız ediyor mu?", "a": "Karanlık bir odada yatmak istiyorum, ışık beynimi deliyor."},
      {"q": "Daha önce oldu mu?", "a": "Üniversiteden beri ayda 1-2 kez benzer krizler yaşıyorum."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Nörolojik Odak Muayenesi", "duration": 30, "res": "Ense sertliği negatif, kraniyal sinirler ve motor muayene tamamen doğal."},
      {"name": "Göz Dibi Muayenesi", "duration": 30, "res": "Papilödem yok, optik disk sınırları net."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Oral Eletriptan 40 mg + IV Sıvı", "duration": 30, "feed": "5-HT 1B/1D agonisti ile vazodilatasyon ve ağrı iletimi hızla durduruldu.", "score": 45, "is_correct": true, "vitals_update": {"hr": "72", "bp": "118/72", "spo2": "99", "rr": "14", "temp": "36.6", "gcs": "15/15", "status": "Şifayla Taburcu"}, "stability_delta": 35},
      {"name": "Aşırı Opioid (Fentanil) İnfüzyonu", "duration": 30, "feed": "Hatalı Yaklaşım! Migrende opioid ilk tercih değildir, bağımlılık ve rebound ağrı yaratır.", "score": -45, "is_correct": false, "vitals_update": {"hr": "65", "bp": "105/65", "spo2": "92", "rr": "10", "status": "Solunum Depresyonu"}, "stability_delta": -35},
      {"name": "Karanlık Odada Dinlendirme ve Hidrasyon", "duration": 30, "feed": "Semptomatik rahatlama sağlandı.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Nöroloji Polikliniği", "response": "Nörolog: Auralı migren atağı. Akut kriz triptanla çözüldü, profilaksi planlanabilir."}
    ],
    "diag": "Auralı Migren Atağı", "pearl": "Sintilasyon skotomu tipik auradır; kriz tedavisinde triptanlar ve NSAİİ ilk seçenektir."
  },

  // 2. PEDİATRİ (10 VAKA)
  {
    "id": "ped_01", "specialty": "Pediatri", "title": "Ateşli Çocukta Nöbet ve Bilinç Değişikliği", "diff": "KOLAY", "xp": 200, "initial_stability": 65,
    "patient": {"name": "Ali E.", "age": 2, "gender": "Erkek", "complaint": "Yüksek ateş sonrası kasılma ve gözlerde yukarı kayma."},
    "history": "2 gündür nezle ve huzursuzluk.",
    "vitals": {"hr": "142", "bp": "95/60", "spo2": "98", "rr": "28", "temp": "39.4", "gcs": "13/15", "status": "Orta"},
    "questions": [
      {"q": "Nöbet esnasında her yer mi kasıldı?", "a": "İki kolu ve bacağı birden titredi, gözleri kaydı (1.5 dk)."},
      {"q": "Daha önce havale geçirdi mi?", "a": "Hayır ilk kez oldu."},
      {"q": "Aşıları tam mı?", "a": "Evet aşıları tam."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Menenjit Muayenesi (Ense Sertliği)", "duration": 30, "res": "Ense sertliği negatif, fontanel kabarık değil."},
      {"name": "Otoskopik KBB Muayenesi", "duration": 30, "res": "Bilateral timpanik membran hiperemik ve bombe (Akut Otit)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "IV Parasetamol 15 mg/kg + Ilık Uygulama", "duration": 30, "feed": "Ateş kademeli düştü, çocuk çevreyle göz teması kurmaya başladı.", "score": 45, "is_correct": true, "vitals_update": {"hr": "108", "bp": "95/65", "spo2": "99", "rr": "22", "temp": "37.1", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Çocuğun Ağzına Kaşık Sokma ve Soğuk Su", "duration": 30, "feed": "Hatalı ve zararlı uygulama! Diş travması ve aspirasyona neden olur.", "score": -45, "is_correct": false, "vitals_update": {"hr": "160", "bp": "110/70", "spo2": "91", "rr": "36", "status": "Ajite"}, "stability_delta": -35},
      {"name": "Oral Hidrasyon Desteği", "duration": 30, "feed": "Sıvı dengesi korundu.", "score": 20, "is_correct": true, "vitals_update": {"temp": "37.5", "hr": "115", "status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Çocuk Sağlığı ve Hastalıkları", "response": "Pediatrist: Basit febril konvülsiyon. Otit tedavisiyle taburcu edin."}
    ],
    "diag": "Basit Febril Konvülsiyon", "pearl": "6 ay - 5 yaş arası çocuklarda <15 dk süren jeneralize nöbetler basit febril konvülsiyondur."
  },
  {
    "id": "ped_02", "specialty": "Pediatri", "title": "Havlar Tarzda Öksürük ve Stridor", "diff": "ORTA", "xp": 250, "initial_stability": 60,
    "patient": {"name": "Zeynep B.", "age": 3, "gender": "Kadın", "complaint": "Gece aniden başlayan havlar öksürük, ses kısıklığı."},
    "history": "Hafif soğuk algınlığı sonrası gece kötüleşti.",
    "vitals": {"hr": "130", "bp": "98/62", "spo2": "93", "rr": "32", "temp": "38.2", "gcs": "15/15", "status": "Orta"},
    "questions": [
      {"q": "Nefes alırken mi ses çıkıyor?", "a": "Evet nefes alırken kaba düdük sesi çıkıyor."},
      {"q": "Yabancı cisim şüphesi var mı?", "a": "Hayır uykusundan öksürerek uyandı."},
      {"q": "Tükürüğünü yutabiliyor mu?", "a": "Evet salya akması yok."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Üst Havayolu Muayenesi", "duration": 30, "res": "İnspiratuar stridor, suprasternal çekilme var. Tükürük akıtma yok."},
      {"name": "Boyun Ön Grafisi", "duration": 45, "res": "Subglottik çan kulesi (steeple sign) daralma bulgusu."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Nebülize Adrenalin + Oral Deksametazon", "duration": 30, "feed": "Subglottik ödem geriledi, stridor kayboldu, solunum rahatladı.", "score": 45, "is_correct": true, "vitals_update": {"hr": "100", "bp": "98/65", "spo2": "99", "rr": "20", "temp": "37.4", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Boğaz Basacağı ile Sert Muayene", "duration": 30, "feed": "Hatalı Yaklaşım! Hava yolunu irrite ederek tam obstrüksiyonu tetikleyebilir!", "score": -45, "is_correct": false, "vitals_update": {"hr": "155", "bp": "110/70", "spo2": "82", "rr": "40", "status": "Laringospazm"}, "stability_delta": -35},
      {"name": "Nemlendirilmiş Oksijen Tedavisi", "duration": 30, "feed": "Hava yolları nemlendirildi.", "score": 20, "is_correct": true, "vitals_update": {"spo2": "96", "rr": "24", "status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Çocuk Acil Uzmanı", "response": "Uzman: Krup tablosu. Deksametazon sonrası 2 saat gözleyin, taburcu edin."}
    ],
    "diag": "Akut Krup Sendromu", "pearl": "Krup tedavisinde steroid (deksametazon) temeldir; orta-ağır olgularda nebül adrenalin eklenir."
  },
  {
    "id": "ped_03", "specialty": "Pediatri", "title": "Çökmüş Gözler ve Ağır Dehidratasyon", "diff": "ORTA", "xp": 300, "initial_stability": 50,
    "patient": {"name": "Ömer Faruk", "age": 1, "gender": "Erkek", "complaint": "Günde 10 kez sulu ishal, gözyaşsız ağlama, letarji."},
    "history": "Bulaşlı kreş salgını.",
    "vitals": {"hr": "158", "bp": "75/45", "spo2": "97", "rr": "34", "temp": "38.6", "gcs": "12/15", "status": "Kritik"},
    "questions": [
      {"q": "İdrar yaptı mı?", "a": "12 saattir bezi tamamen kuru."},
      {"q": "Su içebiliyor mu?", "a": "İçtiği her şeyi fışkırtarak kusuyor."},
      {"q": "Deri elastikiyeti nasıl?", "a": "Karnındaki deri kıvrımı çok geç düzeliyor."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Serum Elektrolitleri ve Kan Gazı", "duration": 45, "res": "Na: 132 mEq/L, K: 3.1 mEq/L, pH: 7.26, Laktat: 3.8 mmol/L."},
      {"name": "Gaita Mikroskopisi ve Rotavirüs", "duration": 45, "res": "Bol lökosit, Rotavirüs antijeni pozitif."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "20 ml/kg Hızlı IV İzotonik SF Bolusu", "duration": 30, "feed": "Dolaşım hacmi toparlandı, kapiller dolum 2 saniyeye indi, idrar çıkışı başladı.", "score": 45, "is_correct": true, "vitals_update": {"hr": "115", "bp": "95/60", "spo2": "99", "rr": "24", "temp": "37.8", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Antidiyareik (Loperamid) İlaç Verilmesi", "duration": 30, "feed": "Kritik Hata! Bebeklerde motilite baskılayıcılar toksik megakolona ve ileusa yol açar!", "score": -45, "is_correct": false, "vitals_update": {"hr": "170", "bp": "70/40", "gcs": "9/15", "status": "Toksik Tablo"}, "stability_delta": -35},
      {"name": "Oral Rehidrasyon Sıvısı (ORS)", "duration": 30, "feed": "Kademeli hidrasyon sağlandı.", "score": 20, "is_correct": true, "vitals_update": {"hr": "130", "status": "Toparlıyor"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Pediatri Kliniği", "response": "Konsültan: Ağır hipovolemik dehidratasyon. İkinci SF bolusu sonrası idame mayiye geçin."}
    ],
    "diag": "Akut Rotavirüs Gastroenteriti", "pearl": "Bebeklerde dehidratasyonda ilk tercih hızla 20 ml/kg IV izotonik sıvı resüsitasyonudur."
  },
  {
    "id": "ped_04", "specialty": "Pediatri", "title": "Hırıltılı Solunum ve İnspiratuar Çekilme", "diff": "ORTA", "xp": 280, "initial_stability": 60,
    "patient": {"name": "Elif Su", "age": 0, "gender": "Kadın", "complaint": "Nezle sonrası başlayan hırıltı, göğüste çekilmeler (6 aylık)."},
    "history": "Kış mevsimi RSV salgını.",
    "vitals": {"hr": "145", "bp": "90/55", "spo2": "90", "rr": "48", "temp": "37.8", "gcs": "15/15", "status": "Orta"},
    "questions": [
      {"q": "Beslenebiliyor mu?", "a": "Memeyi emerken nefesi yetmiyor, bırakıp ağlıyor."},
      {"q": "Ailede astım var mı?", "a": "Ablası astım hastası."},
      {"q": "Daha önce oldu mu?", "a": "İlk kez böyle hırıltısı oldu."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Akciğer Oskültasyonu", "duration": 30, "res": "Bilateral ekspiratuar sibilan ronküs ve krepitan raller."},
      {"name": "Nazofarenks RSV Antijen Testi", "duration": 45, "res": "RSV (Respiratuar Sinsityal Virüs) Pozitif."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Nazal Nazik Aspirasyon + Nemlendirilmiş Oksijen", "duration": 30, "feed": "Hava yolu sekresyonları temizlendi, oksijenasyon düzeldi, beslenme başladı.", "score": 45, "is_correct": true, "vitals_update": {"hr": "118", "bp": "92/58", "spo2": "98", "rr": "30", "temp": "37.2", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Yüksek Doz Sistemik Steroid ve Antibiyotik", "duration": 30, "feed": "Hatalı Yaklaşım: Akut bronşiolitte rutin steroid ve antibiyotiğin yeri yoktur.", "score": -45, "is_correct": false, "vitals_update": {"hr": "142", "spo2": "90", "status": "Değişmedi"}, "stability_delta": -35},
      {"name": "Serum Fizyolojik ile Nazal Lavaj", "duration": 30, "feed": "Üst hava yolu direnci azaltıldı.", "score": 20, "is_correct": true, "vitals_update": {"spo2": "94", "rr": "36", "status": "Toparlıyor"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Çocuk Kliniği", "response": "Uzman: RSV Bronşioliti. Destek tedavisi, hidrasyon ve oksijen takibi yeterlidir."}
    ],
    "diag": "Akut RSV Bronşioliti", "pearl": "Bronşiolitte temel tedavi nemlendirilmiş oksijen, nazal temizlik ve sıvı desteğidir."
  },
  {
    "id": "ped_05", "specialty": "Pediatri", "title": "Yaygın Peteşi, Ateş ve Letarji", "diff": "ZOR", "xp": 450, "initial_stability": 30,
    "patient": {"name": "Metehan K.", "age": 4, "gender": "Erkek", "complaint": "Bacaklarda basmakla solmayan morluklar, yüksek ateş, uykuya meyil."},
    "history": "Aşı takviminde eksiklik.",
    "vitals": {"hr": "160", "bp": "75/40", "spo2": "94", "rr": "30", "temp": "39.8", "gcs": "10/15", "status": "Hayati Tehlike"},
    "questions": [
      {"q": "Döküntüler ne zaman çıktı?", "a": "Birkaç saat içinde hızla yayıldı, basınca solmuyor."},
      {"q": "Gözlerini açabiliyor mu?", "a": "Sürekli uyukluyor, seslenince zor açıyor."},
      {"q": "Kusması oldu mu?", "a": "2 kez fışkırır gibi kustu."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Deri ve Cam Testi Muayenesi", "duration": 30, "res": "Bilateral alt ekstremitelerde basmakla solmayan purpurik lezyonlar (Pozitif)."},
      {"name": "Kan Gazı ve Laktat", "duration": 45, "res": "pH: 7.20, Laktat: 5.4 mmol/L (Ağır septik şok)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Acil IV Seftriakson 100 mg/kg + 20 ml/kg SF Bolus", "duration": 30, "feed": "Hızla bakterisidal tedavi ve hacim desteği verildi, kapiller kaçış sınırlandı.", "score": 45, "is_correct": true, "vitals_update": {"hr": "110", "bp": "100/65", "spo2": "98", "rr": "22", "temp": "38.2", "gcs": "14/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Ateş Düşürücü Verip Evde Takip Önermek", "duration": 30, "feed": "Ölümcül Hata! Meningokoksemi saatler içinde adrenal kanama ve kardiyak arreste yol açar!", "score": -45, "is_correct": false, "vitals_update": {"hr": "175", "bp": "50/20", "spo2": "84", "gcs": "6/15", "status": "Kardiyak Arrest"}, "stability_delta": -35},
      {"name": "İkinci Damar Yolu ve Noradrenalin Hazırlığı", "duration": 30, "feed": "Dirençli hipotansiyon için inotrop hazırlandı.", "score": 20, "is_correct": true, "vitals_update": {"bp": "88/50", "status": "Toparlıyor"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Çocuk Yoğun Bakım", "response": "Konsültan: Yıldırım meningokoksemi. Seftriaksonu gecikmeden verip hastayı YBÜ'ye nakledin."}
    ],
    "diag": "Meningokoksemi (Fulminan Sepsis)", "pearl": "Basmakla solmayan döküntü ve ateş septik şok alarmıdır; derhal IV 3. kuşak sefalosporin başlanmalıdır."
  },
  {
    "id": "ped_06", "specialty": "Pediatri", "title": "Tükürük Yutamama ve Tripod Pozisyonu", "diff": "ZOR", "xp": 450, "initial_stability": 40,
    "patient": {"name": "Aras D.", "age": 5, "gender": "Erkek", "complaint": "Boğaz ağrısı, ağızdan salya akması, öne eğilerek nefes alma."},
    "history": "Hib aşısı yapılmamış.",
    "vitals": {"hr": "135", "bp": "100/65", "spo2": "89", "rr": "36", "temp": "39.5", "gcs": "14/15", "status": "Hayati Tehlike"},
    "questions": [
      {"q": "Yutkunurken boğazı çok mu acıyor?", "a": "Hiçbir şey yutamıyor, tükürüğü ağzından akıyor."},
      {"q": "Öksürüğü var mı?", "a": "Öksürük yok sadece nefes alamıyor."},
      {"q": "Aşıları tam mı?", "a": "Bazı aşıları eksik kalmıştı."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Boyun Yan Grafisi", "duration": 30, "res": "Başparmak işareti (Thumb sign) epiglottik ödem."},
      {"name": "Kan Gazı", "duration": 45, "res": "pH: 7.28, PaO2: 60 mmHg."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Ameliyathanede Güvenli Entübasyon + IV Seftriakson", "duration": 30, "feed": "Uzman anestezi ekibiyle kontrollü entübasyon yapıldı, havayolu güvenceye alındı.", "score": 45, "is_correct": true, "vitals_update": {"hr": "88", "bp": "100/65", "spo2": "99", "rr": "18", "temp": "38.0", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Poliklinikte Boğaz Basacağı ile Muayene", "duration": 30, "feed": "Ölümcül Hata! Dil basacağı laringospazm ve ani hava yolu arrestine yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "170", "bp": "50/20", "spo2": "50", "status": "Arrest"}, "stability_delta": -35},
      {"name": "Nemli Oksijen Desteği", "duration": 30, "feed": "Hipoksi azaltıldı.", "score": 20, "is_correct": true, "vitals_update": {"spo2": "94", "status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Kulak Burun Boğaz", "response": "KBB: Akut epiglottit cerrahi acildir. Hastayı ajite etmeden ameliyathaneye alın."}
    ],
    "diag": "Akut Epiglottit", "pearl": "Dil basacağı ile muayene kontrendikedir! Ameliyathane koşullarında acil entübasyon gerekir."
  },
  {
    "id": "ped_07", "specialty": "Pediatri", "title": "Aralıklı Ağlama ve Çilek Jölesi Kaka", "diff": "ORTA", "xp": 320, "initial_stability": 65,
    "patient": {"name": "Defne Y.", "age": 0, "gender": "Kadın", "complaint": "Bacakları karnına çekerek ağlama krizleri, kanlı mukuslu dışkı (8 aylık)."},
    "history": "Öncesinde viral nezle.",
    "vitals": {"hr": "130", "bp": "95/60", "spo2": "99", "rr": "26", "temp": "37.4", "gcs": "14/15", "status": "Orta"},
    "questions": [
      {"q": "Ağlama nöbetleri nasıl geliyor?", "a": "15 dakikada bir çığlık atarak bacaklarını büküyor, sonra sakinleşiyor."},
      {"q": "Kakası nasıl?", "a": "Alt bezinde vişne-çilek jölesi gibi kanlı sümüksü kaka gördük."},
      {"q": "Kusması oldu mu?", "a": "Safra renginde yeşil kustu."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Batın Ultrasonografisi", "duration": 45, "res": "Sağ alt kadranda hedef tahtası (target sign) invajinasyon görünümü."},
      {"name": "Düz Karın Grafisi", "duration": 30, "res": "Hafif hava-sıvı seviyeleri."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Ultrason Eşliğinde Hidrostatik Redüksiyon", "duration": 30, "feed": "Serum fizyolojik basıncıyla invajine barsak halkası başarıyla açıldı, cerrahi önlendi!", "score": 45, "is_correct": true, "vitals_update": {"hr": "100", "bp": "95/60", "spo2": "99", "rr": "20", "temp": "36.8", "gcs": "15/15", "status": "Şifayla Taburcu"}, "stability_delta": 35},
      {"name": "Ağızdan Laksatif ve Bağırsak Hareketi Verilmesi", "duration": 30, "feed": "Hayati Hata! Tıkalı bağırsağa laksatif vermek barsak perforasyonuna ve peritonite yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "165", "bp": "70/40", "status": "Peritonit"}, "stability_delta": -35},
      {"name": "IV Sıvı Desteği ve Nazogastrik Dekompresyon", "duration": 30, "feed": "Batın distansiyonu hafifletildi.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Çocuk Cerrahisi", "response": "Çocuk Cerrahı: İnvajinasyon hidrostatik redüksiyonla açıldı. Perforasyon bulgusu yok, izleme alıyoruz."}
    ],
    "diag": "İnvajinasyon (İntussusepsiyon)", "pearl": "Ultrasonda hedef tahtası bulgusu tipiktir; erken evrede hidrostatik redüksiyonla cerrahi önlenir."
  },
  {
    "id": "ped_08", "specialty": "Pediatri", "title": "Fışkırır Tarzda Safrasız Kusma", "diff": "KOLAY", "xp": 220, "initial_stability": 70,
    "patient": {"name": "Kerem T.", "age": 0, "gender": "Erkek", "complaint": "Her beslenme sonrası fışkırarak kusma, sürekli açlık (4 haftalık)."},
    "history": "İlk erkek çocuk.",
    "vitals": {"hr": "138", "bp": "85/50", "spo2": "98", "rr": "24", "temp": "36.8", "gcs": "15/15", "status": "Semptomatik"},
    "questions": [
      {"q": "Kusmuk ne renk?", "a": "Tamamen anne sütü gibi beyaz, sarı veya yeşil safra yok."},
      {"q": "Kustuktan sonra ne yapıyor?", "a": "Hemen tekrar emmek istiyor, sürekli aç."},
      {"q": "Kilo alımı nasıl?", "a": "Doğum kilosunun altına düştü."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Batın Ultrasonografisi", "duration": 45, "res": "Pilor kas kalınlığı >4 mm, kanal uzunluğu >14 mm (Pilor Stenozu)."},
      {"name": "Serum Elektrolitleri", "duration": 45, "res": "Hipokloremik, hipokalemik metabolik alkaloz tablosu."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Elektrolit Düzeltilmesi + Ramstedt Piloromiyotomi", "duration": 30, "feed": "Sıvı-elektrolit dengelendi, cerrahi gevşetmeyle kusmalar tamamen bitti!", "score": 45, "is_correct": true, "vitals_update": {"hr": "110", "bp": "90/55", "spo2": "99", "rr": "22", "temp": "36.7", "gcs": "15/15", "status": "Şifayla Taburcu"}, "stability_delta": 35},
      {"name": "Kusmayı Kesmek İçin Metoklopramid Vermek", "duration": 30, "feed": "Hatalı Yaklaşım: Anatomik hipertrofik stenozda motilite ilacı etkisizdir.", "score": -45, "is_correct": false, "vitals_update": {"hr": "135", "status": "Değişmedi"}, "stability_delta": -35},
      {"name": "IV Sıvı ve Dekstroz Replasmanı", "duration": 30, "feed": "Alkaloz tablosu düzeltildi.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Çocuk Cerrahisi", "response": "Uzman: İnfantil hipertrofik pilor stenozu. Piloromiyotomi planlandı, beslenme 6 saat sonra başlanacak."}
    ],
    "diag": "İnfantil Hipertrofik Pilor Stenozu", "pearl": "Hipokloremik hipokalemik metabolik alkaloz görülür; ameliyat öncesi sıvı-elektrolit mutlaka düzeltilmelidir."
  },
  {
    "id": "ped_09", "specialty": "Pediatri", "title": "Yüzde Ödem ve Çay Rengi İdrar", "diff": "ORTA", "xp": 300, "initial_stability": 75,
    "patient": {"name": "Efe C.", "age": 7, "gender": "Erkek", "complaint": "Sabahları göz çevresinde şişlik, kola/çay rengi idrar, tansiyon 135."},
    "history": "3 hafta önce boğaz enfeksiyonu.",
    "vitals": {"hr": "85", "bp": "135/90", "spo2": "98", "rr": "18", "temp": "37.0", "gcs": "15/15", "status": "Stabil"},
    "questions": [
      {"q": "Boğaz enfeksiyonu geçirdi mi?", "a": "3 hafta önce ateşi ve boğazında beyaz iltihap vardı."},
      {"q": "İdrarı ne zaman koyulaştı?", "a": "Dünden beri kola renginde çay gibi işiyor."},
      {"q": "Baş ağrısı var mı?", "a": "Tansiyondan dolayı hafif başı ağrıyor."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Tam İdrar Tahlili", "duration": 30, "res": "Dismorfik eritrositler, eritrosit silendirleri, proteinüri."},
      {"name": "ASO ve Kompleman Düzeyi", "duration": 45, "res": "ASO: 650 IU/mL (Yüksek), C3: 32 mg/dL (Belirgin düşük)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Tuz Kısıtlaması + Oral Furosemid 1 mg/kg", "duration": 30, "feed": "Hipertansiyon regüle edildi, volüm fazlalığı idrarla atıldı.", "score": 45, "is_correct": true, "vitals_update": {"hr": "74", "bp": "110/70", "spo2": "99", "rr": "16", "temp": "36.6", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Gereksiz Agresif Antibiyotik Yüklemesi", "duration": 30, "feed": "Hatalı Tedavi: APSGN immün kompleks hastalığıdır, geç dönemde antibiyotik glomerülonefriti düzeltmez.", "score": -45, "is_correct": false, "vitals_update": {"bp": "140/95", "status": "Değişmedi"}, "stability_delta": -35},
      {"name": "Kan Basıncı Yakın Takibi", "duration": 30, "feed": "Hipertansif ensefalopati önlendi.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Çocuk Nefrolojisi", "response": "Konsültan: Poststreptokoksik glomerülonefrit. Diüretik ve tansiyon kontrolüyle taburcu edilebilir."}
    ],
    "diag": "Poststreptokoksik Glomerulonefrit (APSGN)", "pearl": "Hematüri, ödem ve hipertansiyon triadı vardır; ASO yüksek, C3 düşüktür."
  },
  {
    "id": "ped_10", "specialty": "Pediatri", "title": "5 Gündür Düşmeyen Ateş ve Çilek Dili", "diff": "ZOR", "xp": 400, "initial_stability": 60,
    "patient": {"name": "Yağmur S.", "age": 3, "gender": "Kadın", "complaint": "5 gündür 39 derece dirençli ateş, dudakta çatlaklar, çilek dili, konjonktivit."},
    "history": "Antibiyotiğe yanıtsız ateş.",
    "vitals": {"hr": "140", "bp": "95/60", "spo2": "97", "rr": "24", "temp": "39.6", "gcs": "15/15", "status": "Kritik"},
    "questions": [
      {"q": "Gözlerinde çapak var mı?", "a": "Gözleri kan çanağı gibi kızarık ama hiç çapak akmıyor."},
      {"q": "Dudakları kanıyor mu?", "a": "Dudakları kuruyup yarıldı, dili çilek gibi kabardı."},
      {"q": "Aşı yerinde kızarıklık oldu mu?", "a": "BCG aşı izi alev gibi kızardı."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Ekokardiyografi", "duration": 45, "res": "Koroner arter çapları normal sınırda, anevrizma henüz yok."},
      {"name": "Tam Kan ve CRP / Sedimantasyon", "duration": 45, "res": "CRP: 140 mg/L, Sedim: 95 mm/saat, Trombositoz."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "IVIG 2 g/kg Tek Doz + Yüksek Doz Oral Aspirin", "duration": 30, "feed": "Sistemik vaskülit baskılandı, koroner arter anevrizması gelişimi başarıyla önlendi!", "score": 45, "is_correct": true, "vitals_update": {"hr": "95", "bp": "95/60", "spo2": "99", "rr": "20", "temp": "36.8", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Yalnızca Antipiretik Şurup Verip Beklemek", "duration": 30, "feed": "Kritik Gecikme! IVIG geciktikçe koroner arter anevrizması ve miyokard enfarktüsü riski %25'e fırlar!", "score": -45, "is_correct": false, "vitals_update": {"hr": "155", "temp": "40.0", "status": "Anevrizma Riski"}, "stability_delta": -35},
      {"name": "Hidrasyon ve Koroner Ultrason Takibi", "duration": 30, "feed": "Miyokard perfüzyonu korundu.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Çocuk Kardiyolojisi", "response": "Uzman: Kawasaki hastalığı. İlk 10 günde IVIG verilerek anevrizma önlendi, 6 hafta düşük doz aspirinle devam edin."}
    ],
    "diag": "Kawasaki Hastalığı", "pearl": "5 günü aşan ateş ve mukokutanöz bulgularda derhal IVIG ve Aspirin başlanmalıdır."
  },

  // 3. KARDİYOLOJİ (10 VAKA)
  {
    "id": "cardio_01", "specialty": "Kardiyoloji", "title": "Ezici Göğüs Ağrısı ve Hipotansiyon", "diff": "ZOR", "xp": 350, "initial_stability": 45,
    "patient": {"name": "Mehmet Y.", "age": 58, "gender": "Erkek", "complaint": "1 saattir süren sol kola ve çeneye vuran göğüs ağrısı."},
    "history": "Hipertansiyon, 30 paket/yıl sigara.",
    "vitals": {"hr": "112", "bp": "85/55", "spo2": "91", "rr": "24", "temp": "36.6", "gcs": "15/15", "status": "Kritik"},
    "questions": [
      {"q": "Ağrı tam nasıl bir his?", "a": "Göğsüme tonlarca ağırlık çökmüş gibi, nefes alamıyorum."},
      {"q": "Terleme eşlik etti mi?", "a": "Soğuk soğuk terliyorum, midem bulanıyor."},
      {"q": "Aspirin aldınız mı?", "a": "Hayır hiçbir ilaç almadım."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "12 Derivasyonlu EKG", "duration": 45, "res": "V1-V4 derivasyonlarında ST elevasyonu (Akut Anterior STEMI)."},
      {"name": "Kardiyak Troponin I", "duration": 60, "res": "1.850 ng/L (Kritik Pozitif)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Aspirin 300 mg + Tikagrelor 180 mg + Acil Primer PCI", "duration": 30, "feed": "Tıkalı LAD damarı stentlenerek açıldı, miyokard perfüzyonu kurtarıldı!", "score": 45, "is_correct": true, "vitals_update": {"hr": "76", "bp": "120/75", "spo2": "99", "rr": "16", "temp": "36.6", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "2000 ml Hızlı SF Sıvı Yüklemesi", "duration": 30, "feed": "Hayati Hata! Sol ventrikül yetmezliğinde aşırı sıvı akut akciğer ödemini tetikledi!", "score": -45, "is_correct": false, "vitals_update": {"hr": "135", "bp": "70/40", "spo2": "80", "rr": "34", "status": "Akciğer Ödemi"}, "stability_delta": -35},
      {"name": "Oksijen Desteği (4 L/dk)", "duration": 30, "feed": "Doku hipoksisi geriletildi.", "score": 20, "is_correct": true, "vitals_update": {"spo2": "97", "status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Girişimsel Kardiyoloji", "response": "Kardiyolog: STEMI doğrulanmış. Anjiyo masası hazır, hastayı hemen kateter salonuna indirin."}
    ],
    "diag": "Akut Anterior STEMI", "pearl": "STEMI olgularında kapı-balon süresi <90 dk olmalı, çift antiplatelet yüklenip acil PCI yapılmalıdır."
  },
  {
    "id": "cardio_02", "specialty": "Kardiyoloji", "title": "Sırta Vuran Yırtıcı Göğüs Ağrısı", "diff": "ZOR", "xp": 450, "initial_stability": 40,
    "patient": {"name": "Hikmet R.", "age": 63, "gender": "Erkek", "complaint": "İki kürek kemiği arasına vuran çok şiddetli yırtılır tarzda ağrı."},
    "history": "Kontrolsüz hipertansiyon.",
    "vitals": {"hr": "98", "bp": "190/115", "spo2": "96", "rr": "22", "temp": "36.7", "gcs": "15/15", "status": "Hayati Tehlike"},
    "questions": [
      {"q": "Ağrı aniden mi başladı?", "a": "Sırtıma bıçak saplanıp yırtılıyor gibi aniden patladı."},
      {"q": "Kolunuzda uyuşma var mı?", "a": "Sağ kolum soğuk ve güçsüz."},
      {"q": "Tansiyon ilacı kullanır mısınız?", "a": "İhmal ediyordum, tansiyonum 18-19 gezerdi."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Toraks BT Anjiyografi (Aort)", "duration": 75, "res": "Çıkan aortta intimal flep ve yalancı lümen (Tip A Diseksiyon)."},
      {"name": "12 Derivasyonlu EKG", "duration": 45, "res": "Sol ventrikül hipertrofisi bulguları, ST elevasyonu yok."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "IV Esmolol İnfüzyonu + Acil KDC Hazırlığı", "duration": 30, "feed": "Aort duvarına binen kesme kuvveti düşürüldü, hasta acil cerrahi greftlemeye alındı.", "score": 45, "is_correct": true, "vitals_update": {"hr": "58", "bp": "115/70", "spo2": "99", "rr": "14", "temp": "36.7", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Acil Trombolitik (rtPA) ve Heparin", "duration": 30, "feed": "Fatal Hata! Aort diseksiyonunda trombolitik masif perikardiyal tamponada yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "150", "bp": "40/10", "spo2": "82", "gcs": "6/15", "status": "Kardiyak Arrest"}, "stability_delta": -35},
      {"name": "IV Morfin ile Ağrı Kontrolü", "duration": 30, "feed": "Sempatik deşarj baskılandı, kan basıncı düşüşü kolaylaştı.", "score": 20, "is_correct": true, "vitals_update": {"bp": "165/100", "status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Kalp Damar Cerrahisi", "response": "KDC Uzmanı: Tip A Diseksiyon cerrahi acildir. Tansiyonu beta blokerle kontrol edip ameliyathaneye alın."}
    ],
    "diag": "Akut Tip A Aort Diseksiyonu", "pearl": "Trombolitik KESİNLİKLE kontrendikedir! Tansiyon esmolol ile düşürülüp acil cerrahiye alınır."
  },
  {
    "id": "cardio_03", "specialty": "Kardiyoloji", "title": "Ani Başlayan Çarpıntı ve Presenkop", "diff": "ORTA", "xp": 300, "initial_stability": 60,
    "patient": {"name": "Deniz K.", "age": 34, "gender": "Kadın", "complaint": "Göğüste kuş kanat çırpar gibi çarpıntı, baş dönmesi."},
    "history": "Daha önce kısa süreli çarpıntı atakları.",
    "vitals": {"hr": "185", "bp": "100/65", "spo2": "98", "rr": "20", "temp": "36.6", "gcs": "15/15", "status": "Semptomatik"},
    "questions": [
      {"q": "Çarpıntı nasıl başladı?", "a": "Otururken aniden fırladı, sanki boğazımda atıyor."},
      {"q": "Göğsünüzde sıkışma var mı?", "a": "Sadece çok hızlı attığı için başım dönüyor."},
      {"q": "Daha önce EKG çekildi mi?", "a": "Acilde ritim normale dönmüştü dediler."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "12 Derivasyonlu EKG", "duration": 30, "res": "Dar QRS taşikardi, P dalgası seçilemiyor, KAH: 185 bpm (SVT)."},
      {"name": "Kardiyak Troponin I", "duration": 60, "res": "Troponin negatif (Normal)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Vagal Manevra + IV Adenozin 6 mg Hızlı Bolus", "duration": 30, "feed": "AV nod geçici bloke edildi, sinüs ritmine dönüldü, hız 75'e indi!", "score": 45, "is_correct": true, "vitals_update": {"hr": "74", "bp": "120/75", "spo2": "99", "rr": "14", "temp": "36.6", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Yüksek Doz Atropin Uygulanması", "duration": 30, "feed": "Hatalı İlaç! Taşikardik hastaya atropin verilmesi KAH'ı daha da tehlikeli boyuta çıkardı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "215", "bp": "80/45", "status": "Kritik Çarpıntı"}, "stability_delta": -35},
      {"name": "Soğuk Suyla Yüz Yıkama (Diving Refleksi)", "duration": 30, "feed": "Vagal tonus uyarıldı.", "score": 20, "is_correct": true, "vitals_update": {"hr": "170", "status": "Semptomatik"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Kardiyoloji Polikliniği", "response": "Konsültan: AVNRT ile uyumlu. Adenozin ile döndürüldü, elektif EPS ablasyon planlayın."}
    ],
    "diag": "Paroksismal Supraventriküler Taşikardi (SVT)", "pearl": "Stabil SVT'de ilk basamak modifiye Valsalva manevrası, ardından hızlı IV Adenozin bolusudur."
  },
  {
    "id": "cardio_04", "specialty": "Kardiyoloji", "title": "Sırtüstü Yatamama (Ortopne) ve Pembe Balgam", "diff": "ZOR", "xp": 400, "initial_stability": 45,
    "patient": {"name": "Cevdet U.", "age": 72, "gender": "Erkek", "complaint": "Sırtüstü yatamama, boğulur gibi nefes darlığı, pembe köpüklü balgam."},
    "history": "Koroner arter hastalığı, kalp yetmezliği.",
    "vitals": {"hr": "122", "bp": "180/105", "spo2": "82", "rr": "32", "temp": "36.9", "gcs": "14/15", "status": "Kritik"},
    "questions": [
      {"q": "Kaç yastıkla yatıyorsunuz?", "a": "3 yastıkla bile nefesim kesiliyor, koltukta oturuyorum."},
      {"q": "Bacaklarınızda şişlik var mı?", "a": "İki bacağım da dize kadar şiş ve sert."},
      {"q": "İlaçlarınızı aldınız mı?", "a": "İdrar söktürücümü 3 gündür içmemiştim."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Akciğer Oskültasyonu ve Grafisi", "duration": 30, "res": "Bilateral orta-üst zonlara yayılan yaş raller, kelebek kanadı konjesyon."},
      {"name": "Kardiyak BNP / NT-proBNP", "duration": 45, "res": "NT-proBNP: 8.450 pg/mL (Ağır kalp yetmezliği alevlenmesi)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "CPAP Solunum Desteği + IV Furosemid 80 mg + IV Nitrogliserin", "duration": 30, "feed": "Önyük ve artyük düşürüldü, alveoler sıvı çekildi, satürasyon hızla yükseldi.", "score": 45, "is_correct": true, "vitals_update": {"hr": "80", "bp": "125/80", "spo2": "98", "rr": "18", "temp": "36.8", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "1000 ml IV Serum Fizyolojik Hidrasyonu", "duration": 30, "feed": "Ölümcül Hata! Akut pulmoner ödemdeki hastaya sıvı bolusu tam solunum arrestine yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "145", "bp": "210/120", "spo2": "65", "rr": "40", "status": "Solunum Arresti"}, "stability_delta": -35},
      {"name": "Oturur Pozisyona Getirme ve Bacak Sarkıtma", "duration": 30, "feed": "Venöz dönüş azaltılarak kalbin iş yükü hafifletildi.", "score": 20, "is_correct": true, "vitals_update": {"spo2": "88", "rr": "26", "status": "Toparlıyor"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Kardiyoloji Yoğun Bakım", "response": "Uzman: Akut dekompanse kalp yetmezliği. Vazodilatatör ve diüretik tedavisine devam edin."}
    ],
    "diag": "Akut Akciğer Ödemi (Kalp Yetersizliği)", "pearl": "Akut akciğer ödeminde CPAP/NIV, IV Furosemid ve vazodilatatör (nitrogliserin) temel taştır."
  },
  {
    "id": "cardio_05", "specialty": "Kardiyoloji", "title": "Öne Eğilince Azalan Göğüs Ağrısı ve Ateş", "diff": "ORTA", "xp": 280, "initial_stability": 75,
    "patient": {"name": "Murat T.", "age": 26, "gender": "Erkek", "complaint": "Derin nefesle ve yatmakla artan, öne eğilince hafifleyen göğüs ağrısı."},
    "history": "1 hafta önce grip geçirme.",
    "vitals": {"hr": "92", "bp": "120/75", "spo2": "98", "rr": "16", "temp": "37.8", "gcs": "15/15", "status": "Stabil"},
    "questions": [
      {"q": "Ağrı ne zaman azalıyor?", "a": "Yatakta öne doğru iki büklüm oturunca rahatlıyorum."},
      {"q": "Derin nefes alınca batıyor mu?", "a": "Evet bıçak gibi batıyor."},
      {"q": "Ateşiniz oldu mu?", "a": "2 gündür 38 derece hafif ateşim var."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "12 Derivasyonlu EKG", "duration": 30, "res": "Tüm derivasyonlarda yaygın konkav ST elevasyonu ve PR depresyonu (Perikardit)."},
      {"name": "Ekokardiyografi", "duration": 45, "res": "Hafif perikardiyal efüzyon, tamponad bulgusu yok."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "İbuprofen 600 mg + Kolşisin 0.5 mg", "duration": 30, "feed": "Perikardiyal inflamasyon geriletildi, göğüs ağrısı tamamen geçti.", "score": 45, "is_correct": true, "vitals_update": {"hr": "72", "bp": "118/72", "spo2": "99", "rr": "14", "temp": "36.6", "gcs": "15/15", "status": "Şifayla Taburcu"}, "stability_delta": 35},
      {"name": "Trombolitik Tedavi Başlanması", "duration": 30, "feed": "Hayati Hata! Perikardit ST elevasyonunu STEMI sanıp trombolitik vermek hemoperikardiyuma yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "130", "bp": "75/40", "status": "Kardiyak Tamponad"}, "stability_delta": -35},
      {"name": "Yatak İstirahati ve Kardiyoloji Takibi", "duration": 30, "feed": "Miyoperikardit riski izlendi.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Kardiyoloji Kliniği", "response": "Kardiyolog: Akut perikardit. Kolşisin ve NSAİİ ile semptomlar düzeldi, elektif poliklinik kontrolü önerilir."}
    ],
    "diag": "Akut Perikardit", "pearl": "Tüm derivasyonlarda yaygın konkav ST elevasyonu ve PR depresyonu tipiktir; NSAİİ+Kolşisin verilir."
  },
  {
    "id": "cardio_06", "specialty": "Kardiyoloji", "title": "Geniş QRS Taşikardi ve Nabızsızlık Riski", "diff": "ZOR", "xp": 450, "initial_stability": 30,
    "patient": {"name": "Şükrü B.", "age": 65, "gender": "Erkek", "complaint": "Göğüs ağrısı sonrası aniden gelişen aşırı taşikardi ve fenalık hissi."},
    "history": "Geçirilmiş anterior MI.",
    "vitals": {"hr": "210", "bp": "70/40", "spo2": "88", "rr": "26", "temp": "36.5", "gcs": "12/15", "status": "Hayati Tehlike"},
    "questions": [
      {"q": "Gözünüz kararıyor mu?", "a": "Her yer dönüyor, bayılıyorum."},
      {"q": "Göğsünüz sıkışıyor mu?", "a": "Kalbim göğsümden fırlayacak gibi."},
      {"q": "Bypass veya stent öykünüz var mı?", "a": "5 yıl önce kriz geçirip stent taktırmıştım."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "12 Derivasyonlu EKG", "duration": 30, "res": "Geniş QRS düzenli taşikardi, AV disosiasyon (Ventriküler Taşikardi)."},
      {"name": "Serum Potasyum ve Magnezyum", "duration": 45, "res": "K: 3.2 mEq/L, Mg: 1.4 mg/dL (Hipokalemi ve hipomagnezemi)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Senkronize DC Kardiyoversiyon (100J) + Amiodaron", "duration": 30, "feed": "Kardiyoversiyonla normal sinüs ritmine dönüldü, tansiyon hızla 120'ye çıktı!", "score": 45, "is_correct": true, "vitals_update": {"hr": "76", "bp": "120/75", "spo2": "98", "rr": "15", "temp": "36.6", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Verapamil (Kalsiyum Kanal Blokeri) IV Verilmesi", "duration": 30, "feed": "Ölümcül Hata! Geniş QRS taşikardide verapamil verilmesi ventriküler fibrilasyon ve arreste yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "0", "bp": "0/0", "status": "Ventriküler Fibrilasyon"}, "stability_delta": -35},
      {"name": "IV Magnezyum ve Potasyum İnfüzyonu", "duration": 30, "feed": "Miyokardiyal eksitabilite stabilize edildi.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Aritmi Uzmanı", "response": "Kardiyolog: Monomorfik VT tablosu. Ritim kardiyoversiyonla döndü, ICD implantasyonu planlayın."}
    ],
    "diag": "Ventriküler Taşikardi (VT)", "pearl": "Anstabil VT olgularında gecikmeden senkronize kardiyoversiyon uygulanmalıdır; verapamil kontrendikedir."
  },
  {
    "id": "cardio_07", "specialty": "Kardiyoloji", "title": "Eforla Bayılma ve Ejeksiyon Üfürümü", "diff": "ORTA", "xp": 320, "initial_stability": 70,
    "patient": {"name": "Nazif E.", "age": 76, "gender": "Erkek", "complaint": "Merdiven çıkarken ani bayılma, efor dispnesi ve göğüs ağrısı."},
    "history": "Aort kalsifikasyonu.",
    "vitals": {"hr": "64", "bp": "105/80", "spo2": "96", "rr": "16", "temp": "36.6", "gcs": "15/15", "status": "Stabil"},
    "questions": [
      {"q": "Bayılmadan önce ne yapıyordunuz?", "a": "Yokuş yukarı yürüyordum, gözlerim karardı yere düştüm."},
      {"q": "Göğsünüz sıkışıyor mu?", "a": "Yürürken baskı oluyor, durunca geçiyor."},
      {"q": "Nefesiniz daralıyor mu?", "a": "Eskiye göre çok çabuk yoruluyorum."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Kardiyak Oskültasyon", "duration": 30, "res": "Sağ 2. İK aralıkta boyna yayılan kreşendo-dekreşendo sistolik ejeksiyon üfürümü."},
      {"name": "Transtorasik Ekokardiyografi", "duration": 60, "res": "Aort kapak alanı: 0.7 cm2, pik gradiyent: 65 mmHg (Ciddi AS)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Ağır Efor Kısıtlaması + TAVI / Cerrahi Kapak Replasmanı", "duration": 30, "feed": "Kapak darlığı giderildi, serebral perfüzyon düzeldi, senkop atakları bitti.", "score": 45, "is_correct": true, "vitals_update": {"hr": "70", "bp": "125/80", "spo2": "99", "rr": "14", "temp": "36.6", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Yüksek Doz Vazodilatatör (Nitrogliserin) Vermek", "duration": 30, "feed": "Hayati Hata! Ciddi aort darlığında nitrat verilmesi ani serebral perfüzyon çöküşü ve senkopa yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "115", "bp": "60/30", "status": "Kollaps"}, "stability_delta": -35},
      {"name": "Kardiyoloji Servis Takibi", "duration": 30, "feed": "Ani ölüm riski izlendi.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Kalp Damar Cerrahisi", "response": "KDC: Semptomatik ciddi aort darlığı (SAD triadı). TAVI veya cerrahi kapak replasmanı kararı alındı."}
    ],
    "diag": "Ciddi Aort Stenozu (AS)", "pearl": "Ciddi aort darlığında nitratlar ve vazodilatatörler kontrendikedir; kesin çözüm kapak replasmanıdır."
  },
  {
    "id": "cardio_08", "specialty": "Kardiyoloji", "title": "Aşırı Halsizlik ve Derin Bradikardi", "diff": "ZOR", "xp": 350, "initial_stability": 45,
    "patient": {"name": "Mualla H.", "age": 80, "gender": "Kadın", "complaint": "Baş dönmesi, fenalık, dakikada 30 atan aşırı yavaş nabız."},
    "history": "Kronik iskemik kalp hastalığı.",
    "vitals": {"hr": "32", "bp": "80/45", "spo2": "94", "rr": "14", "temp": "36.2", "gcs": "14/15", "status": "Kritik"},
    "questions": [
      {"q": "Gözünüz kararıyor mu?", "a": "Ayağa kalkınca dünya dönüyor, bayılacak gibi oluyorum."},
      {"q": "Kalp ilacı alıyor musunuz?", "a": "Tansiyon ve ritim ilacı alıyordum."},
      {"q": "Göğüs ağrınız var mı?", "a": "Sadece aşırı halsizlik ve yorgunluk var."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "12 Derivasyonlu EKG", "duration": 30, "res": "P dalgaları ile QRS kompleksleri tamamen bağımsız, KAH: 32 bpm (3. Derece AV Blok)."},
      {"name": "Serum Elektrolitleri", "duration": 45, "res": "Potasyum: 4.8 mEq/L (Normal)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Transkutan / Geçici Pacemaker (Kalp Pili) Takılması", "duration": 30, "feed": "Kalp hızı pille 75 bpm'e ayarlandı, tansiyon hızla 125'e yükseldi, hasta canlandı!", "score": 45, "is_correct": true, "vitals_update": {"hr": "75", "bp": "125/80", "spo2": "99", "rr": "15", "temp": "36.6", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Beta Bloker (Metoprolol) Verilmesi", "duration": 30, "feed": "Ölümcül Hata! Tam bloklu hastaya beta bloker verilmesi asistoliye ve ölüme yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "0", "bp": "0/0", "status": "Asistoli"}, "stability_delta": -35},
      {"name": "IV Atropin 1 mg Uygulanması", "duration": 30, "feed": "Geçici hızlanma denendi.", "score": 20, "is_correct": true, "vitals_update": {"hr": "38", "bp": "88/50", "status": "Kısmi Yanıt"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Kardiyoloji Aritmi", "response": "Kardiyolog: Tam kalp bloğu. Geçici pacemaker takıldı, kalıcı pacemaker için ameliyathane planlayın."}
    ],
    "diag": "Tam Kalp Bloğu (3. Derece AV Blok)", "pearl": "Tam blok olgularında AV nodu bloke eden ilaçlar kesinlikle verilmez; kesin tedavi pacemaker takılmasıdır."
  },
  {
    "id": "cardio_09", "specialty": "Kardiyoloji", "title": "Düzensiz Hızlı Nabız ve Çarpıntı", "diff": "KOLAY", "xp": 220, "initial_stability": 75,
    "patient": {"name": "Feridun K.", "age": 59, "gender": "Erkek", "complaint": "Düzensiz ve hızlı atan kalp, göğüste kanat çırpma hissi, yorgunluk."},
    "history": "Hipertansiyon, uyku apnesi.",
    "vitals": {"hr": "132", "bp": "135/85", "spo2": "97", "rr": "18", "temp": "36.7", "gcs": "15/15", "status": "Semptomatik"},
    "questions": [
      {"q": "Kalp atışlarınız ritmik mi?", "a": "Hayır bazen hızlı bazen yavaş, tamamen kafasına göre düzensiz atıyor."},
      {"q": "Nefes darlığınız var mı?", "a": "Merdiven çıkarken hemen tıkanıyorum."},
      {"q": "Daha önce oldu mu?", "a": "Arada olur geçerdi ama 2 gündür hiç durmadı."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "12 Derivasyonlu EKG", "duration": 30, "res": "P dalgası yok, tabanda f dalgaları, düzensiz RR aralıkları (Hızlı Ventrikül Yanıtlı AF)."},
      {"name": "Tiroid Fonksiyon Testleri", "duration": 60, "res": "TSH ve T4 normal sınırlarda."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Hız Kontrolü (IV Diltiazem 0.25 mg/kg) + Antikoagülasyon", "duration": 30, "feed": "Ventrikül hızı 78'e frenlendi, kardiyak doluş ve debi rahatladı, inme riski önlendi.", "score": 45, "is_correct": true, "vitals_update": {"hr": "78", "bp": "120/75", "spo2": "99", "rr": "14", "temp": "36.6", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Antikoagülasyonsuz Acil Elektriksel Kardiyoversiyon", "duration": 30, "feed": "Kritik Hata! 48 saati aşan AF'de transözofageal eko yapılmadan kardiyoversiyon embolik inmeye yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "80", "gcs": "10/15", "status": "Embolik İnme"}, "stability_delta": -35},
      {"name": "Oral Beta Bloker ve Dinlenme", "duration": 30, "feed": "Hız kontrolü desteklendi.", "score": 20, "is_correct": true, "vitals_update": {"hr": "95", "status": "Toparlıyor"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Kardiyoloji Polikliniği", "response": "Kardiyolog: Hızlı yanıtlı AF. Diltiazemle hız kontrolü sağlandı, CHA2DS2-VASc skoruna göre antikoagülan planlayın."}
    ],
    "diag": "Atriyal Fibrilasyon (AF)", "pearl": "48 saati aşan AF'de atriyal trombüs ekarte edilmeden kardiyoversiyon yapılmaz; hız kontrolü ve antikoagülasyon esastır."
  },
  {
    "id": "cardio_10", "specialty": "Kardiyoloji", "title": "Eforla Gelen Göğüs Ağrısı (Troponin Negatif)", "diff": "ORTA", "xp": 260, "initial_stability": 80,
    "patient": {"name": "Tahsin L.", "age": 54, "gender": "Erkek", "complaint": "Yokuş çıkarken gelen, 10 dakika dinlenince geçen baskı tarzı göğüs ağrısı."},
    "history": "Tip 2 Diyabet, Hiperlipidemi.",
    "vitals": {"hr": "84", "bp": "130/80", "spo2": "98", "rr": "16", "temp": "36.6", "gcs": "15/15", "status": "Stabil"},
    "questions": [
      {"q": "Ağrı ne zaman geçiyor?", "a": "Yorulunca başlıyor, bir yere oturup 5-10 dakika dinlenince tamamen geçiyor."},
      {"q": "Ağrı nereye yayılıyor?", "a": "Sol omzuma ve göğüs kafesimin ortasına."},
      {"q": "İstirahat halindeyken ağrınız oldu mu?", "a": "Hayır durup dururken hiç olmadı."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Seri Kardiyak Troponin Takibi", "duration": 60, "res": "0. ve 3. saat troponinler negatif (Akut nekroz yok)."},
      {"name": "İstirahat EKG'si", "duration": 30, "res": "Normal sinüs ritmi, akut iskemi bulgusu yok."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Aspirin 100 mg + Statin + Sublingual Nitrat + Elektif Anjiyo", "duration": 30, "feed": "Antiiskemik tedavi başlandı, elektif koroner anjiyografi planlanarak taburcu edildi.", "score": 45, "is_correct": true, "vitals_update": {"hr": "70", "bp": "120/75", "spo2": "99", "rr": "14", "temp": "36.6", "gcs": "15/15", "status": "Şifayla Taburcu"}, "stability_delta": 35},
      {"name": "Acil Trombolitik Tedavi (rtPA)", "duration": 30, "feed": "Hatalı Tedavi! Kararlı anjinada troponin negatifken trombolitik verilmesi gereksiz kanama riski doğurur.", "score": -45, "is_correct": false, "vitals_update": {"hr": "90", "bp": "110/70", "status": "Riskli"}, "stability_delta": -35},
      {"name": "Sublingual Nitrogliserin ile Ağrının Geçirilmesi", "duration": 30, "feed": "Koroner vazodilatasyonla göğüs baskısı hızla çözüldü.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Kardiyoloji Polikliniği", "response": "Kardiyolog: Kararlı Angina Pektoris. Medikal tedavi düzenlendi, elektif koroner BT anjiyo randevusu verildi."}
    ],
    "diag": "Stabil Angina Pektoris", "pearl": "Eforla gelip dinlenmekle geçen ağrılarda troponin negatiftir; medikal tedavi ve elektif anjiyografi planlanır."
  },

  // 4. ACİL TIP (10 VAKA)
  {
    "id": "em_01", "specialty": "Acil Tıp", "title": "Sol Bacakta Ani Şiddetli Ağrı ve Şişlik", "diff": "ORTA", "xp": 250, "initial_stability": 70,
    "patient": {"name": "Burak Y.", "age": 24, "gender": "Erkek", "complaint": "Sol baldırda aniden başlayan şiddetli gerginlik, ağrı ve basamama."},
    "history": "3 gün önce 14 saatlik otobüs yolculuğu.",
    "vitals": {"hr": "94", "bp": "125/80", "spo2": "98", "rr": "16", "temp": "36.8", "gcs": "15/15", "status": "Semptomatik"},
    "questions": [
      {"q": "Ağrı tam nerede?", "a": "Sol baldırımda taş gibi gerginlik var, yürüyemiyorum."},
      {"q": "Nefes darlığı var mı?", "a": "Hayır göğsüm rahat, sadece bacağım zonkluyor."},
      {"q": "Daha önce pıhtı oldu mu?", "a": "Hayır ilk kez oluyor."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Alt Ekstremite Venöz Doppler", "duration": 60, "res": "Sol femoral ve popliteal vende tam oklüziv DVT."},
      {"name": "D-Dimer Testi", "duration": 45, "res": "3.420 ng/mL (Kritik Pozitif)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Enoksaparin (LMWH) 1 mg/kg SC", "duration": 30, "feed": "Antikoagülan tedavi başlandı, emboli riski baskılandı, ödem geriledi.", "score": 45, "is_correct": true, "vitals_update": {"hr": "74", "bp": "120/75", "spo2": "99", "rr": "14", "temp": "36.6", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Sol Bacağa Sıcak Uygulama ve Masaj", "duration": 30, "feed": "Kritik Hata! Masaj trombüsün kopmasına ve masif pulmoner emboliye yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "138", "bp": "80/45", "spo2": "80", "rr": "32", "status": "Pulmoner Emboli"}, "stability_delta": -35},
      {"name": "Bacak Elevasyonu ve İstirahat", "duration": 30, "feed": "Venöz dönüş rahatlatıldı.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Kalp Damar Cerrahisi", "response": "KDC: Doppler DVT ile uyumlu. Cerrahi gerekmez, LMWH tedavisine devam edin."}
    ],
    "diag": "Derin Ven Trombozu (DVT)", "pearl": "Renkli Doppler USG ile tanı konur; masaj kontrendikedir, LMWH başlanır."
  },
  {
    "id": "em_02", "specialty": "Acil Tıp", "title": "Trafik Kazası Sonrası Solunum Durması", "diff": "ZOR", "xp": 450, "initial_stability": 30,
    "patient": {"name": "Serkan B.", "age": 28, "gender": "Erkek", "complaint": "Kaza sonrası sağ göğüs ağrısı, nefes alamama, boyun venleri dolgun."},
    "history": "Motosiklet kazası.",
    "vitals": {"hr": "138", "bp": "65/40", "spo2": "76", "rr": "36", "temp": "36.2", "gcs": "10/15", "status": "Hayati Tehlike"},
    "questions": [
      {"q": "Göğsünüzü bir yere çarptınız mı?", "a": "Gidona çok sert çarptım, nefesim tıkandı."},
      {"q": "Hangi taraf daha çok ağrıyor?", "a": "Sağ tarafım parçalanıyor gibi."},
      {"q": "Baş dönmesi var mı?", "a": "Gözlerim kararıyor, bayılacak gibiyim."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Göğüs Muayenesi & Dinleme", "duration": 30, "res": "Sağda solunum sesleri tamamen yok, trakea sola deviye."},
      {"name": "E-FAST Ultrasonografi", "duration": 45, "res": "Sağ hemitoraksta plevral kayma kaybı (Pnömotoraks)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Acil İğne Torakostomi + Göğüs Tüpü", "duration": 30, "feed": "Hava büyük bir tıslamayla boşaldı! Kalbe venöz dönüş açıldı, tansiyon hızla toparladı.", "score": 45, "is_correct": true, "vitals_update": {"hr": "84", "bp": "120/75", "spo2": "99", "rr": "16", "temp": "36.6", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Grafi İçin Hastayı Radyolojiye Gönderme", "duration": 30, "feed": "Ölümcül Gecikme! Tansiyon pnömotoraks klinik tanıdır; röntgen beklerken arrest gelişti!", "score": -45, "is_correct": false, "vitals_update": {"hr": "160", "bp": "40/10", "spo2": "60", "status": "Arrest"}, "stability_delta": -35},
      {"name": "Rezervuarlı Maske ile %100 Oksijen", "duration": 30, "feed": "Oksijen desteği sağlandı.", "score": 20, "is_correct": true, "vitals_update": {"spo2": "88", "status": "Toparlıyor"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Göğüs Cerrahisi", "response": "Göğüs Cerrahı: İğne dekompresyonu hayat kurtarmış. 28F göğüs tüpünü su altı drenajına bağlayın."}
    ],
    "diag": "Tansiyon Pnömotoraks", "pearl": "Grafi beklenmeden derhal 2. İK aralıktan iğne dekompresyonu ve göğüs tüpü takılmalıdır."
  },
  {
    "id": "em_03", "specialty": "Acil Tıp", "title": "Arı Sokması Sonrası Nefes Alamama ve Şok", "diff": "ZOR", "xp": 400, "initial_stability": 35,
    "patient": {"name": "Büşra N.", "age": 22, "gender": "Kadın", "complaint": "Arı sokmasından 10 dakika sonra dudakta anjiyoödem, stridor, baygınlık."},
    "history": "Daha önce böcek alerjisi.",
    "vitals": {"hr": "132", "bp": "60/35", "spo2": "84", "rr": "30", "temp": "36.8", "gcs": "11/15", "status": "Hayati Tehlike"},
    "questions": [
      {"q": "Nerenizden soktu?", "a": "Boynumdan soktu, boğazım düğümlendi."},
      {"q": "Vücudunuzda kaşıntı var mı?", "a": "Her yerim alev gibi yanıyor ve kabardı."},
      {"q": "Göz kararması oldu mu?", "a": "Ayakta duramadım yere yığıldım."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Üst Havayolu Muayenesi", "duration": 30, "res": "Dudak, dil ve uvulada yaygın anjiyoödem, laringeal stridor."},
      {"name": "Kan Gazı Ölçümü", "duration": 45, "res": "pH: 7.28, PaO2: 55 mmHg."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "IM Adrenalin 0.5 mg (Uyluk Ön-Dış) + Hızlı IV Sıvı", "duration": 30, "feed": "Vasküler tonus sağlandı, hava yolu ödemi hızla çözüldü, tansiyon fırladı!", "score": 45, "is_correct": true, "vitals_update": {"hr": "86", "bp": "115/75", "spo2": "99", "rr": "16", "temp": "36.7", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Yalnızca Ağızdan Antihistaminik Hap Vermek", "duration": 30, "feed": "Hayati Hata! Anafilaktik şokta oral hap etkisizdir ve aspirasyona yol açar!", "score": -45, "is_correct": false, "vitals_update": {"hr": "155", "bp": "45/20", "spo2": "70", "status": "Kollaps"}, "stability_delta": -35},
      {"name": "IV Metilprednizolon + Feniramin", "duration": 30, "feed": "Geç faz alerjik reaksiyon engellendi.", "score": 20, "is_correct": true, "vitals_update": {"bp": "95/60", "status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Acil Tıp Uzmanı", "response": "Uzman: Anafilaktik şok tablosu. Adrenalin sonrası hasta 8 saat bifazik reaksiyon için gözlenmelidir."}
    ],
    "diag": "Anafilaktik Şok", "pearl": "İlk ve en hayat kurtarıcı adım uyluk anterolateraline IM Adrenalin 0.5 mg uygulamaktır."
  },
  {
    "id": "em_04", "specialty": "Acil Tıp", "title": "Kussmaul Solunumu ve Aseton Kokusu", "diff": "ORTA", "xp": 320, "initial_stability": 50,
    "patient": {"name": "Gizem N.", "age": 19, "gender": "Kadın", "complaint": "Derin hızlı soluk alma, karın ağrısı, bulantı ve şuur bulanıklığı."},
    "history": "Tip 1 DM (2 gündür insülini bırakmış).",
    "vitals": {"hr": "126", "bp": "88/55", "spo2": "98", "rr": "34", "temp": "37.1", "gcs": "13/15", "status": "Kritik"},
    "questions": [
      {"q": "İnsülininizi yaptınız mı?", "a": "İnsülinim bittiği için 2 gündür yapamadım."},
      {"q": "Karnınız neden ağrıyor?", "a": "Mide bulantısıyla beraber tüm karnım kramp şeklinde sancıyor."},
      {"q": "Ağzınızda kuruluk var mı?", "a": "Dudaklarım kurudu, çok susuyorum."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Parmak Ucu Kan Şekeri ve Keton", "duration": 30, "res": "Glukoz: 485 mg/dL, Kan Ketonu: 4.8 mmol/L (Pozitif)."},
      {"name": "Arteryel Kan Gazı", "duration": 45, "res": "pH: 7.12, HCO3: 8 mEq/L (Ağır anyon açıklı metabolik asidoz)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Agresif IV İzotonik Hidrasyonu + IV İnsülin İnfüzyonu", "duration": 30, "feed": "Ketoasidoz tablosu geriledi, asidoz düzeldi, kan şekeri kademeli indi.", "score": 45, "is_correct": true, "vitals_update": {"hr": "80", "bp": "120/75", "spo2": "99", "rr": "16", "temp": "36.8", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Potasyumu Görmeden Yüksek Doz IV İnsülin Bolusu", "duration": 30, "feed": "Kritik Hata! Potasyum düzeyi bilinmeden insülin verilmesi fatal hipokalemik arrest yaptı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "165", "bp": "60/30", "status": "Aritmi"}, "stability_delta": -35},
      {"name": "Potasyum Replasmanı (KCL)", "duration": 30, "feed": "Hipokalemi önlendi.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Endokrinoloji", "response": "Uzman: Diyabetik Ketoasidoz (DKA). Sıvı ve insülin protokolüne devam edip keton takibi yapın."}
    ],
    "diag": "Diyabetik Ketoasidoz (DKA)", "pearl": "İlk adım agresif IV SF hidrasyonudur; potasyum düzeyi görülmeden insülin başlanmaz."
  },
  {
    "id": "em_05", "specialty": "Acil Tıp", "title": "Toplu İğne Başı Pupiller ve Solunum Depresyonu", "diff": "ORTA", "xp": 300, "initial_stability": 40,
    "patient": {"name": "Murat S.", "age": 24, "gender": "Erkek", "complaint": "Evde baygın bulunma, solunum sayısı dakikada 6, siyanoz."},
    "history": "Madde kullanım şüphesi.",
    "vitals": {"hr": "52", "bp": "85/45", "spo2": "78", "rr": "6", "temp": "35.8", "gcs": "6/15", "status": "Hayati Tehlike"},
    "questions": [
      {"q": "Arkadaşına: Ne kullandı?", "a": "Ağrı kesici haplar ve adını bilmediğim toz madde aldı."},
      {"q": "Ne zamandır nefes almıyor?", "a": "10 dakikadır morarmaya başladı, uyandıramadık."},
      {"q": "Kusması oldu mu?", "a": "Yan yatırdık kusmadı."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Pupil ve Solunum Muayenesi", "duration": 30, "res": "Bilateral miyotik (toplu iğne başı) pupiller, solunum dakikada 6."},
      {"name": "Arteryel Kan Gazı", "duration": 45, "res": "pH: 7.15, PaCO2: 72 mmHg (Ağır hiperkapnik solunum depresyonu)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "IV Nalokson 0.4 mg Titrasyonu + Balon Maske", "duration": 30, "feed": "Opioid reseptörleri hızla temizlendi! Hasta derin nefes alarak gözlerini açtı.", "score": 45, "is_correct": true, "vitals_update": {"hr": "78", "bp": "120/75", "spo2": "99", "rr": "16", "temp": "36.6", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Hastaya Yüksek Doz Sedatif (Midazolam) Vermek", "duration": 30, "feed": "Fatal Hata! Solunumu durmuş hastaya sedatif verilmesi tam solunum arrestine yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "30", "bp": "40/15", "spo2": "50", "status": "Solunum Arresti"}, "stability_delta": -35},
      {"name": "Balon Valf Maske ile Havalandırma", "duration": 30, "feed": "Hipoksi engellendi.", "score": 20, "is_correct": true, "vitals_update": {"spo2": "88", "status": "Toparlıyor"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Klinik Toksikoloji", "response": "Konsültan: Opioid toksisitesi. Nalokson etki süresi kısa olduğu için tekrar solunum depresyonu izlenmelidir."}
    ],
    "diag": "Akut Opioid Zehirlenmesi", "pearl": "Balon valf maske ventilasyonu ve spesifik antidot olan IV Nalokson titrasyonu yapılır."
  },
  {
    "id": "em_06", "specialty": "Acil Tıp", "title": "Sağ Alt Kadran Ağrısı ve Defans", "diff": "KOLAY", "xp": 200, "initial_stability": 75,
    "patient": {"name": "Emre V.", "age": 22, "gender": "Erkek", "complaint": "Göbek çevresinde başlayıp sağ kasığa inen şiddetli karın ağrısı, bulantı."},
    "history": "İştahsızlık.",
    "vitals": {"hr": "98", "bp": "120/75", "spo2": "99", "rr": "18", "temp": "38.2", "gcs": "15/15", "status": "Semptomatik"},
    "questions": [
      {"q": "Ağrı nerede başladı?", "a": "Dün göbeğimde başladı, bu sabah sağ kasığıma indi, yürürken zıplatıyor."},
      {"q": "Kusmanız oldu mu?", "a": "Bir kez midem bulandı kustum, iştahım sıfır."},
      {"q": "İdrar yaparken yanma var mı?", "a": "Hayır idrarda yanma yok."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Batın Muayenesi (McBurney)", "duration": 30, "res": "Sağ alt kadranda McBurney hassasiyeti, rebound ve defans pozitif."},
      {"name": "Batın Ultrasonografisi", "duration": 45, "res": "Çapı 8 mm, komprese olmayan aperistaltik apendiks (Akut Apandisit)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Oral Stop + IV Sıvı + Acil Laparoskopik Apendektomi", "duration": 30, "feed": "İltihaplı apendiks perfore olmadan başarıyla çıkarıldı, hasta şifayla taburcu edildi.", "score": 45, "is_correct": true, "vitals_update": {"hr": "74", "bp": "120/75", "spo2": "99", "rr": "14", "temp": "36.8", "gcs": "15/15", "status": "Şifayla Taburcu"}, "stability_delta": 35},
      {"name": "Oral Müshil / Laksatif İlaç Vermek", "duration": 30, "feed": "Kritik Hata! Apandisitte motilite artırıcı ilaç apendiksin patlamasına ve peritonite yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "140", "bp": "80/45", "temp": "39.5", "status": "Perfore Apandisit"}, "stability_delta": -35},
      {"name": "Geniş Spektrumlu IV Antibiyotik", "duration": 30, "feed": "Bakteriyel translokasyon baskılandı.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Genel Cerrahi", "response": "Genel Cerrah: Akut apandisit doğrulandı. Hasta ameliyathaneye alındı, laparoskopik apendektomi yapılıyor."}
    ],
    "diag": "Akut Apandisit", "pearl": "Göbekten sağ alt kadrana göç eden ağrıda apandisit düşünülmelidir; laksatifler perforasyon riski nedeniyle kesinlikle yasaktır."
  },
  {
    "id": "em_07", "specialty": "Acil Tıp", "title": "Yüksekten Düşme ve Batında Distansiyon", "diff": "ZOR", "xp": 450, "initial_stability": 35,
    "patient": {"name": "Cihan M.", "age": 38, "gender": "Erkek", "complaint": "İnşaatta 2. kattan düşme, sol kaburgada kırık, soluk cilt, tansiyon 75."},
    "history": "Travma hastası.",
    "vitals": {"hr": "140", "bp": "75/40", "spo2": "92", "rr": "26", "temp": "35.9", "gcs": "12/15", "status": "Hayati Tehlike"},
    "questions": [
      {"q": "Nereye düştünüz?", "a": "İskeleden sol tarafımın üstüne tahtaların üzerine düştüm."},
      {"q": "Başınızı çarptınız mı?", "a": "Kaskım vardı ama sol kaburgalarım ezildi."},
      {"q": "Gözleriniz kararıyor mu?", "a": "Başım dönüyor, çok üşüyorum."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "E-FAST Ultrasonografi", "duration": 30, "res": "Splenorenal mesafede ve pelviste masif serbest sıvı (Masif Hemoperitoneum)."},
      {"name": "Kan Grubu ve Çapraz Karşılaştırma", "duration": 30, "res": "Acil 4 ünite 0 Rh negatif süspansiyon hazırlandı."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Masif Transfüzyon Protokolü + Acil Laparotomi / Splenektomi", "duration": 30, "feed": "Yırtılan dalak kanaması durduruldu, volüm replase edildi, tansiyon normale döndü.", "score": 45, "is_correct": true, "vitals_update": {"hr": "84", "bp": "120/75", "spo2": "99", "rr": "16", "temp": "36.7", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Yalnızca SF Sıvısı Verip Beklemek", "duration": 30, "feed": "Fatal Hata! Masif iç kanamada tek başına SF verilmesi hemodilüsyon, koagülopati ve ölüme yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "170", "bp": "40/15", "status": "Hemorajik Şok"}, "stability_delta": -35},
      {"name": "Isıtılmış Sıvı ve Kan Transfüzyonu", "duration": 30, "feed": "Hipotermi ve asidoz önlendi.", "score": 20, "is_correct": true, "vitals_update": {"bp": "95/60", "status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Genel Cerrahi Travma", "response": "Cerrah: E-FAST masif batın içi kanamayı doğruladı. Hasta acil ameliyathaneye laparotomiye alınıyor."}
    ],
    "diag": "Hemorajik Şok (Dalak Laserasyonu)", "pearl": "Künt batın travmasında şok tablosunda E-FAST altın değerdedir; gecikmeden cerrahi hemostaz sağlanmalıdır."
  },
  {
    "id": "em_08", "specialty": "Acil Tıp", "title": "Titreme, Yüksek Ateş ve Tansiyon Çökmesi", "diff": "ZOR", "xp": 420, "initial_stability": 40,
    "patient": {"name": "Rıza C.", "age": 74, "gender": "Erkek", "complaint": "İdrar yolu enfeksiyonu sonrası titreme, konfüzyon, ciltte beneklenme, laktat 4.5."},
    "history": "Prostat hiperplazisi, idrar sondası.",
    "vitals": {"hr": "128", "bp": "78/42", "spo2": "93", "rr": "26", "temp": "39.6", "gcs": "11/15", "status": "Hayati Tehlike"},
    "questions": [
      {"q": "Ne zamandır idrar yaparken yanması var?", "a": "3 gündür sondayı çekiştiriyordu, idrarı çok bulanık ve kokuluydu."},
      {"q": "Konuşabiliyor mu?", "a": "Sabah bilinci kapandı, bizi tanımıyor."},
      {"q": "Ateşi kaç derece?", "a": "Titreyerek 39.6'ya çıktı."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Kan Gazı ve Laktat Ölçümü", "duration": 30, "res": "pH: 7.24, Laktat: 4.8 mmol/L (Doku hipoperfüzyonu)."},
      {"name": "Tam İdrar ve Kan Kültürü", "duration": 45, "res": "İdrarda bol lökosit ve Gram negatif basiller."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "30 ml/kg IV Kristaloid + IV Meropenem + Noradrenalin", "duration": 30, "feed": "İlk 1 saat paket tedavisi uygulandı, ortalama arteryel basınç >65 sağlandı, sepsis kontrol edildi.", "score": 45, "is_correct": true, "vitals_update": {"hr": "82", "bp": "115/70", "spo2": "98", "rr": "18", "temp": "37.5", "gcs": "14/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Vazopressörsüz Bekleyip Sadece Parasetamol Vermek", "duration": 30, "feed": "Ölümcül Hata! Septik şokta vazopressör ve antibiyotik gecikmesi multiorgan yetmezliğine yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "150", "bp": "50/20", "status": "Septik Arrest"}, "stability_delta": -35},
      {"name": "Oksijen Desteği ve Foley Sonda Değişimi", "duration": 30, "feed": "Enfeksiyon odağı temizlendi.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Yoğun Bakım Kliniği", "response": "Uzman: Ürosepsis kaynaklı septik şok. Sıvı ve noradrenalinle hemodinami sağlandı, YBÜ yatağı hazırlandı."}
    ],
    "diag": "Ürosepsis Kaynaklı Septik Şok", "pearl": "Septik şokta ilk 1 saatte 30 ml/kg sıvı, kan kültürü, geniş spektrumlu antibiyotik ve noradrenalin esastır."
  },
  {
    "id": "em_09", "specialty": "Acil Tıp", "title": "Çok Sayıda Parasetamol Alımı", "diff": "ORTA", "xp": 280, "initial_stability": 75,
    "patient": {"name": "Derya P.", "age": 20, "gender": "Kadın", "complaint": "6 saat önce kutuyla 30 adet parasetamol 500mg yutmuş, bulantı ve kusma."},
    "history": "Majör depresyon.",
    "vitals": {"hr": "86", "bp": "115/70", "spo2": "98", "rr": "16", "temp": "36.7", "gcs": "15/15", "status": "Stabil"},
    "questions": [
      {"q": "Kaç adet hap aldınız?", "a": "Ağrı kesiciden tam 30 tane (15 gram) içtim."},
      {"q": "Alalı kaç saat oldu?", "a": "Öğlen 12'de almıştım, 6 saat geçti."},
      {"q": "Kusmanız oldu mu?", "a": "Midem çok bulandı 2 kez kustum."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Serum Parasetamol Düzeyi", "duration": 60, "res": "Parasetamol düzeyi: 180 ug/mL (Toksik eşiğin üzerinde - Rumack Nomogramı Pozitif)."},
      {"name": "Karaciğer Fonksiyon Testleri (ALT/AST)", "duration": 45, "res": "AST: 45 U/L, ALT: 38 U/L (Erken evre, henüz yükselmemiş)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "IV N-Asetilsistein (NAC) 3 Aşamalı Protokolü", "duration": 30, "feed": "Glutatyon depoları dolduruldu, toksik NAPQI metaboliti nötralize edildi, karaciğer nekrozu engellendi.", "score": 45, "is_correct": true, "vitals_update": {"hr": "72", "bp": "120/75", "spo2": "99", "rr": "14", "temp": "36.6", "gcs": "15/15", "status": "Şifayla Taburcu"}, "stability_delta": 35},
      {"name": "Karaciğer Enzimleri Normal Diye Hastayı Taburcu Etmek", "duration": 30, "feed": "Ölümcül Hata! Parasetamolde karaciğer nekrozu 48-72. saatte ortaya çıkar, antidotsuz hasta karaciğer iflasına gitti!", "score": -45, "is_correct": false, "vitals_update": {"hr": "120", "status": "Fulminan Hepatit"}, "stability_delta": -35},
      {"name": "Oral Aktif Kömür Uygulaması", "duration": 30, "feed": "İlk saatlerde kalan ilaç bağlandı.", "score": 20, "is_correct": true, "vitals_update": {"status": "Stabil"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Klinik Toksikoloji", "response": "Konsültan: Toksik doz parasetamol. 21 saatlik IV NAC protokolünü eksiksiz tamamlayın."}
    ],
    "diag": "Akut Parasetamol Toksisitesi", "pearl": "Rumack-Matthew nomogramına göre toksik düzeyde karaciğer enzimleri henüz normal olsa dahi derhal NAC başlanmalıdır."
  },
  {
    "id": "em_10", "specialty": "Acil Tıp", "title": "Kaza Sonrası Bilinç Açılması ve Tekrar Koma", "diff": "ZOR", "xp": 450, "initial_stability": 35,
    "patient": {"name": "Tolga F.", "age": 31, "gender": "Erkek", "complaint": "Motosiklet kazasında kafasını çarptı, kendine geldi, 2 saat sonra koma ve anizokori."},
    "history": "Kask takılmamış.",
    "vitals": {"hr": "54", "bp": "170/100", "spo2": "95", "rr": "12", "temp": "36.8", "gcs": "7/15", "status": "Hayati Tehlike"},
    "questions": [
      {"q": "Kazadan hemen sonra nasıldı?", "a": "Önce bayıldı, sonra ayağa kalktı 'iyiyim' dedi, 2 saat sonra yere yığıldı."},
      {"q": "Göz bebekleri nasıl?", "a": "Sağ göz bebeği büyüdü ve ışığa yanıt vermiyor."},
      {"q": "Kusması oldu mu?", "a": "Kendinden geçmeden önce fışkırarak kustu."},
      {"q": "Göğüs ağrısı, nefes darlığı veya bayılma eşlik etti mi?", "a": "Mevcut ana şikayetim dışında belirgin göğüs ağrım yok."}
    ],
    "tests": [
      {"name": "Kontrassız Beyin BT", "duration": 45, "res": "Sağ temporoparietalde bikonveks (lens şeklinde) hiperdens epidural hematom ve 10 mm orta hat şifti."},
      {"name": "Pupil Işık Refleksi Muayenesi", "duration": 15, "res": "Sağ pupil fikse ve dilate (Unkal herniasyon bulgusu)."},
      {"name": "Tam Kan Sayımı ve Biyokimya Paneli", "duration": 45, "res": "Elektrolitler ve lökosit düzeyleri incelendi."}
    ],
    "treatments": [
      {"name": "Mannitol 1 g/kg + Acil Nöroşirürji Kraniyotomi", "duration": 30, "feed": "Hematom hızla boşaltıldı, A. meningea media kanaması bağlandı, herniasyon geri döndü!", "score": 45, "is_correct": true, "vitals_update": {"hr": "74", "bp": "120/75", "spo2": "99", "rr": "15", "temp": "36.6", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 35},
      {"name": "Hastayı Serviste 'Uykusunu Alsın' Diye Bekletmek", "duration": 30, "feed": "Ölümcül Hata! Epidural hematomda lüsid intervali kaçırmak beyin sapı basısı ve herniasyona yol açtı!", "score": -45, "is_correct": false, "vitals_update": {"hr": "35", "bp": "220/130", "status": "Beyin Ölümü"}, "stability_delta": -35},
      {"name": "Hiperventilasyon ile Geçici ICP Düşürülmesi", "duration": 30, "feed": "Ameliyathaneye gidene kadar beyin ödemi frenlendi.", "score": 20, "is_correct": true, "vitals_update": {"status": "Toparlıyor"}, "stability_delta": 15},
      {"name": "İntravenöz Hidrasyon ve Yakın Takip", "duration": 30, "feed": "Doku perfüzyonu desteklendi.", "score": 15, "is_correct": true, "vitals_update": {}, "stability_delta": 10}
    ],
    "consultations": [
      {"specialty": "Beyin ve Sinir Cerrahisi", "response": "Beyin Cerrahı: Akut epidural hematom. Anestezi ve cerrahi hazır, hastayı hemen kraniyotomiye alıyoruz."}
    ],
    "diag": "Akut Epidural Hematom (Lüsid İnterval)", "pearl": "Lüsid interval (iyilik dönemi) epidural hematomun klasiğidir; acil cerrahi boşaltma hayat kurtarır."
  }
];

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
// ACİL SERVİS BİLDİRİMİ EKRANI
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
// 2. KEŞFET (HER BRANŞTA TAM 10 VAKA)
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
        title: Text("$specialtyName (10 Vaka)", style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16)),
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
// 4. VAKALARIM EKRANI (DİNAMİK LİSTE VE TİK İŞARETİ)
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
                    {"name": "IV Sıvı ve Semptomatik Tedavi", "duration": 30, "feed": "Hasta rahatladı, vitaller stabil.", "score": 30, "is_correct": true, "vitals_update": {"hr": "76", "bp": "120/75", "spo2": "99", "rr": "14", "temp": "36.6", "gcs": "15/15", "status": "Stabil"}, "stability_delta": 20},
                    {"name": "Uygunsuz Doz Sedatif Tedavisi", "duration": 30, "feed": "Klinik Hata! Solunum depresyonu riski oluştu!", "score": -30, "is_correct": false, "vitals_update": {"hr": "110", "bp": "95/55", "spo2": "89", "rr": "10", "status": "Solunum Depresyonu"}, "stability_delta": -25}
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
// 6. MÜDAHALE ODASI (GERÇEK SAYAÇ, KESİNTİSİZ HIZLANDIRMA VE DİNAMİK VİTAL)
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
  VoidCallback? _onActionComplete;

  // Anında Tamamlama / Hızlandırma Fonksiyonu
  void _finishOngoingActionNow() {
    _actionCountdownTimer?.cancel();
    if (_onActionComplete != null) {
      _onActionComplete!();
      _onActionComplete = null;
    }
  }

  @override
  void initState() {
    super.initState();
    stability = widget.caseData['initial_stability'] ?? 60;
    vitals = Map<String, dynamic>.from(widget.caseData['vitals']);

    _caseTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() => _secondsElapsed++);
    });

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

    _onActionComplete = () {
      setState(() {
        ongoingActionName = null;
        ongoingActionSeconds = 0;
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
    };

    _actionCountdownTimer?.cancel();
    _actionCountdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (ongoingActionSeconds > 1) {
        setState(() => ongoingActionSeconds--);
      } else {
        _finishOngoingActionNow();
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

    _onActionComplete = () {
      setState(() {
        ongoingActionName = null;
        ongoingActionSeconds = 0;
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
          "m": "${trt['name']}\n${trt['feed']}\n🩺 Monitör Güncellendi: KAH: ${vitals['hr']} bpm, TA: ${vitals['bp']}, SpO2: %${vitals['spo2']}"
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(trt['feed']),
          backgroundColor: (trt['is_correct'] ?? true) ? const Color(0xFF16A34A) : Colors.red.shade800,
          duration: const Duration(seconds: 4),
        ),
      );
    };

    _actionCountdownTimer?.cancel();
    _actionCountdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (ongoingActionSeconds > 1) {
        setState(() => ongoingActionSeconds--);
      } else {
        _finishOngoingActionNow();
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

          // DEVAM EDEN İŞLEMLER VE KESİNTİSİZ ÇALIŞAN HIZLANDIRMA BUTONU
          if (ongoingActionName != null)
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFC7D2FE))),
              child: Row(
                children: [
                  Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFF99F6E4), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.hourglass_top_rounded, color: Color(0xFF0D9488), size: 16)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(ongoingActionName!, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                  const SizedBox(width: 8),
                  Text("$ongoingActionSeconds sn", style: const TextStyle(color: Color(0xFF4F46E5), fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: _finishOngoingActionNow,
                    child: const Text("Hızlandır ⏩", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
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
