# 🎮 Game UI Flutter dengan ListView.builder dan API FreeToGame

Proyek ini menampilkan contoh implementasi UI daftar game menggunakan Flutter.  
Data diambil dari **FreeToGame API** dan ditampilkan dalam daftar menggunakan `ListView.builder()`.  

Tujuan utamanya adalah memahami penggunaan **ListView**, **Container**, **Row & Column**, dan **HTTP request** untuk mengambil data dari API.

---

## 📌 Tentang Proyek

- **Nama Proyek:** game_ui  
- **Deskripsi:** Aplikasi menampilkan daftar game gratis dengan thumbnail, judul, genre, tanggal rilis, dan tombol info.  
- **Tujuan:**  
  - Mengambil data dari **FreeToGame API**.  
  - Menampilkan data secara dinamis menggunakan `ListView.builder()`.  
  - Membuat UI modern dengan `Container`, `BoxShadow`, dan `BorderRadius`.  

---

## 🔲 Konsep Utama

### 1. ListView.builder
Digunakan untuk menampilkan daftar item secara efisien.  

```dart
ListView.builder(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
  itemCount: dataGame.length,
  itemBuilder: (context, index) {
    return _listItem(
      dataGame[index]['thumbnail'] ?? 'https://via.placeholder.com/150',
      dataGame[index]['title'] ?? 'Tidak ada judul',
      dataGame[index]['genre'] ?? 'Tidak ada genre',
      dataGame[index]['release_date'] ?? 'Tidak ada tanggal',
    );
  },
)
```
