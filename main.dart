import 'package:flutter/material.dart';

void main() {
  runApp(const BadmintonShopApp());
}

class BadmintonShopApp extends StatelessWidget {
  const BadmintonShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.network(
          'https://shopvnb.com/themes/vnb2023/images/logo.png', // Thay bằng logo local nếu có
          height: 40,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.black)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart, color: Colors.black)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Menu Ngang (Trang chủ, Sản phẩm...)
            Container(
              color: const Color(0xFFF15A24), // Màu cam đặc trưng của VNB
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  MenuNavItem(title: 'TRANG CHỦ'),
                  MenuNavItem(title: 'SẢN PHẨM'),
                  MenuNavItem(title: 'SALE OFF'),
                  MenuNavItem(title: 'TIN TỨC'),
                ],
              ),
            ),
            
            // Banner Quảng Cáo
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://shopvnb.com/uploads/images/banner/vot-cau-long-taro-phu-hop-cho-nguoi-moi-choi.webp',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Bố cục chính: Sidebar + Grid Sản phẩm
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sidebar Bộ lọc (Chỉ hiển thị trên màn hình rộng hoặc ẩn đi trên mobile)
                  Container(
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Column(
                      children: [
                        FilterSection(title: 'MỨC GIÁ'),
                        FilterItem(label: 'Dưới 500k'),
                        FilterItem(label: '500k - 1tr'),
                        FilterSection(title: 'THƯƠNG HIỆU'),
                        FilterItem(label: 'VNB'),
                        FilterItem(label: 'Yonex'),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Danh sách sản phẩm
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return const ProductCard();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget con: Menu Item
class MenuNavItem extends StatelessWidget {
  final String title;
  const MenuNavItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }
}

// Widget con: Card Sản phẩm
class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network('https://shopvnb.com/uploads/gallery/vot-cau-long-vnb-v200-xanh-chinh-hang.webp'),
              Positioned(
                top: 5, right: 5,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  color: Colors.red,
                  child: const Text('-3%', style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Text('Vợt Cầu Lông VNB V200 Xanh', maxLines: 2, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('790.000đ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// Các widget bổ trợ cho Sidebar
class FilterSection extends StatelessWidget {
  final String title;
  const FilterSection({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(8),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
    );
  }
}

class FilterItem extends StatelessWidget {
  final String label;
  const FilterItem({super.key, required this.label});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          const Icon(Icons.check_box_outline_blank, size: 16, color: Colors.grey),
          const SizedBox(width: 4),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 10))),
        ],
      ),
    );
  }
}