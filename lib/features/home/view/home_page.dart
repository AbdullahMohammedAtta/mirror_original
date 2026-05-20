import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';
import 'package:mirror_original/features/home/view_model/home_state.dart';




class HomePage extends StatelessWidget {

  HomePage({super.key});
  final List<Map<String, dynamic>> trendingProducts = [
    {
      'name': 'VORTEX RACER 01',
      'price': '\$180.00',
      'bgColor': const Color(0xFFF0F0F0),
    },
    {
      'name': 'ZENITH RUNNER',
      'price': '\$210.00',
      'bgColor': const Color(0xFF98C4C4),
    },
    {
      'name': 'DUNE HIGH-TOP',
      'price': '\$195.00',
      'bgColor': const Color(0xFF333333),
    },
    {
      'name': 'POP-COLOR LO',
      'price': '\$165.00',
      'bgColor': const Color(0xFFF5F5F5),
    },
  ];



  @override
  Widget build(BuildContext context) {

    var homeCubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit,HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  buildSearchBar(),
                  const SizedBox(height: 25),
                  buildPromoBanner(),
                  const SizedBox(height: 25),
                  buildCategories(homeCubit,context),
                  const SizedBox(height: 25),
                  buildSectionHeader('Trending Now', 'View All'),
                  const SizedBox(height: 15),
                  buildProductGrid(trendingProducts),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            bottomNavigationBar: buildBottomNavigationBar(homeCubit),
          );
        },
    );
  }

}

  // --- (AppBar) ---
  PreferredSizeWidget buildAppBar() {
    return AppBar(
      elevation: 1,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black, size: 28),
        onPressed: () {},
      ),
      title: Column(
        children: [
          const Text(
            'ABU MOUSA',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 70,
            height: 2,
            color: Colors.black,
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black, size: 28),
              onPressed: () {},
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEDF1F9),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for your style',
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  // ---  (Promo Banner) ---
  Widget buildPromoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1014),
        borderRadius: BorderRadius.circular(25),
        //  DecorationImage
        // image: DecorationImage(image: AssetImage('assets/banner_shoe.png'), fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Retro Horizon',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            'LIMITED EDITION RELEASE',
            style: TextStyle(
                color: Colors.grey, fontSize: 12, letterSpacing: 1.2),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('SHOP NOW', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget buildCategories(HomeCubit homeCubit,context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.sizeOf(context).width*0.8,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: ()
              {
                homeCubit.changeCategories(index);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: homeCubit.selectedCategoriesIndex == index? Colors.black : const Color(0xFFF0F0F0),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(homeCubit.categories[index],style: TextStyle(
                      color: homeCubit.selectedCategoriesIndex == index? Colors.white : Colors.black,
                      fontSize: 18,fontWeight: FontWeight.bold),),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(width: 15,),
          itemCount: homeCubit.categories.length,
      ),
    );
  }


  Widget buildSectionHeader(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          actionText,
          style: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ],
    );
  }

  // ---  (Product Grid) ---
  Widget buildProductGrid(List trendingProducts ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7, //
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemBuilder: (context, index) {
        final product = trendingProducts[index];
        return buildProductCard(product);
      },
      itemCount: 4,
    );
  }

  // ---  ---
  Widget buildProductCard(Map<String, dynamic> product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: product['bgColor'],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(Icons.snowshoeing, size: 50, color: Colors.black26),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_border, size: 18, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          product['name'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          product['price'],
          style: const TextStyle(color: Colors.black54, fontSize: 14),
        ),
      ],
    );
  }

  Widget buildBottomNavigationBar(HomeCubit homeCubit) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildNavItem(homeCubit,Icons.home_outlined, 'Home', 0),
          buildNavItem(homeCubit,Icons.search, 'Search', 1),
          buildNavItem(homeCubit,Icons.favorite_border, 'Favorites', 2),
          buildNavItem(homeCubit,Icons.shopping_cart_outlined, 'Cart', 3),
          buildNavItem(homeCubit,Icons.person_outline, 'Profile', 4),
        ],
      ),
    );
  }

  Widget buildNavItem(HomeCubit homeCubit,IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        homeCubit.changeNavBar(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: homeCubit.selectedNavBarIndex==index ? const Color(0xFF0F1014) : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: homeCubit.selectedNavBarIndex==index ? Colors.white : Colors.black87,
              size: 24,
            ),
            if (homeCubit.selectedNavBarIndex==index) ...[
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              )
            ]
          ],
        ),
      ),
    );
  }


