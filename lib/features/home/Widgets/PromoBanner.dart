import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerModel {
  final String image;
  final String title;

  BannerModel({
    required this.image,
    required this.title,
  });
}

final List<BannerModel> banners = [
  BannerModel(
    image: 'https://thumbs.dreamstime.com/b/design-mock-up-banner-illustration-white-sport-sneaker-shoes-banner-footwear-commercials-retail-offers-isolated-335060242.jpg',
    title: 'Retro Horizon',
  ),
  BannerModel(
    image: 'https://images.pexels.com/photos/29521391/pexels-photo-29521391.jpeg?_gl=1*rj6j56*_ga*NzYxNjIwOTk2LjE3ODAzMDQ5MTM.*_ga_8JE65Q40S6*czE3ODIyNzMwNzgkbzIkZzEkdDE3ODIyNzMxMjgkajEwJGwwJGgw',
    title: 'Summer Collection',
  ),
  BannerModel(
    image: 'https://images.pexels.com/photos/4061385/pexels-photo-4061385.jpeg?_gl=1*1s1et1d*_ga*NzYxNjIwOTk2LjE3ODAzMDQ5MTM.*_ga_8JE65Q40S6*czE3ODIyNzMwNzgkbzIkZzEkdDE3ODIyNzMxNjUkajQyJGwwJGgw',
    title: 'Street Style',
  ),
];

Widget buildPromoBanner() {
  return CarouselSlider.builder(
    itemCount: banners.length,
    options: CarouselOptions(
      height: 180,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 6),
      enlargeCenterPage: true,
      viewportFraction: 1,
    ),
    itemBuilder: (context, index, realIndex) {
      final banner = banners[index];

      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
            image: NetworkImage(banner.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              colors: [
                Colors.black.withValues(alpha: 0.7),
                Colors.transparent,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'NEW COLLECTION',
                style: TextStyle(
                  color: Colors.white70,
                  letterSpacing: 1.5,
                  fontSize: 12,
                ),
              ),
              Text(
                banner.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              ElevatedButton(
                onPressed: () {},
                child: const Text('SHOP NOW'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
