import 'package:flutter/material.dart';

class katalog extends StatefulWidget {
  const katalog({super.key});

  static const List<Map<String, String>> items = [
    {
      'nama': 'Tas Ransel Laptop',
      'kategori': 'Tas',
      'harga': 'Rp 350.000',
      'rating': '4.8',
      'gambar':
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=600&q=80',
    },
    {
      'nama': 'Kaos Slim Fit Pria',
      'kategori': 'Pakaian',
      'harga': 'Rp 120.000',
      'rating': '4.5',
      'gambar':
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=600&q=80',
    },
    {
      'nama': 'Jaket Katun Pria',
      'kategori': 'Pakaian',
      'harga': 'Rp 425.000',
      'rating': '4.7',
      'gambar':
          'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&w=600&q=80',
    },
    {
      'nama': 'Kemeja Casual',
      'kategori': 'Pakaian',
      'harga': 'Rp 180.000',
      'rating': '4.6',
      'gambar':
          'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?auto=format&fit=crop&w=600&q=80',
    },
    {
      'nama': 'Headphone Wireless',
      'kategori': 'Elektronik',
      'harga': 'Rp 250.000',
      'rating': '4.7',
      'gambar':
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=600&q=80',
    },
    {
      'nama': 'Smartwatch Sport',
      'kategori': 'Elektronik',
      'harga': 'Rp 499.000',
      'rating': '4.9',
      'gambar':
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=600&q=80',
    },
    {
      'nama': 'Sepatu Sneaker',
      'kategori': 'Sepatu',
      'harga': 'Rp 299.000',
      'rating': '4.8',
      'gambar':
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=600&q=80',
    },
    {
      'nama': 'Kacamata Hitam',
      'kategori': 'Aksesoris',
      'harga': 'Rp 145.000',
      'rating': '4.4',
      'gambar':
          'https://images.unsplash.com/photo-1572635196237-14b3f281503f?auto=format&fit=crop&w=600&q=80',
    },
    {
      'nama': 'Kamera Mirrorless',
      'kategori': 'Elektronik',
      'harga': 'Rp 3.450.000',
      'rating': '4.9',
      'gambar':
          'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?auto=format&fit=crop&w=600&q=80',
    },
  ];

  @override
  State<katalog> createState() => _KatalogState();
}

class _KatalogState extends State<katalog> {
  String _modeTampilan = 'list';
  final Set<String> _favorit = {};

  void _toggleFavorit(String nama) {
    final sudahFavorit = _favorit.contains(nama);
    setState(() {
      if (sudahFavorit) {
        _favorit.remove(nama);
      } else {
        _favorit.add(nama);
      }
    });

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            sudahFavorit
                ? '$nama dihapus dari favorit'
                : '$nama ditambahkan ke favorit',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  Widget _gambar(String url, {double? size}) {
    return Image.network(
      url,
      width: size,
      height: size,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      },
      errorBuilder: (context, error, stack) =>
          const Icon(Icons.image_not_supported),
    );
  }

  Widget _tombolFilter(String label, String mode, IconData ikon) {
    final aktif = _modeTampilan == mode;
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () => setState(() => _modeTampilan = mode),
        icon: Icon(ikon, size: 18),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: aktif ? Colors.indigo : Colors.white,
          foregroundColor: aktif ? Colors.white : Colors.indigo,
          elevation: aktif ? 2 : 0,
          side: const BorderSide(color: Colors.indigo),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: katalog.items.length,
      itemBuilder: (context, index) {
        final item = katalog.items[index];
        final isFav = _favorit.contains(item['nama']);
        return Card(
          child: ListTile(
            leading: _gambar(item['gambar']!, size: 60),
            title: Text(
              item['nama']!,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${item['harga']} • ${item['kategori']}'),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      item['rating']!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : Colors.grey,
              ),
              onPressed: () => _toggleFavorit(item['nama']!),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 600 ? 3 : 2;
        return GridView.count(
          padding: const EdgeInsets.all(8),
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.78,
          children: List.generate(katalog.items.length, (index) {
            final item = katalog.items[index];
            final isFav = _favorit.contains(item['nama']);
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => _toggleFavorit(item['nama']!),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: _gambar(item['gambar']!),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['nama']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            item['harga']!,
                            style: const TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 15,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              item['rating']!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Katalog Produk'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
            child: Row(
              children: [
                _tombolFilter('ListView', 'list', Icons.list),
                const SizedBox(width: 8),
                _tombolFilter('GridView', 'grid', Icons.grid_view),
              ],
            ),
          ),
          Expanded(
            child: _modeTampilan == 'list'
                ? _buildListView()
                : _buildGridView(),
          ),
        ],
      ),
    );
  }
}
