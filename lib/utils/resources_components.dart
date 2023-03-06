import 'package:flutter/material.dart';
import 'package:volunteer_app/utils/size_config.dart';

class ResourceCard extends StatelessWidget {
  final String title;
  final String smallerTitle;
  final String image;
  final Color color;

  const ResourceCard({
    super.key,
    required this.title,
    required this.smallerTitle,
    required this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: SizeConfig.safeBlockHorizontal! * 100,
      height: SizeConfig.safeBlockVertical! * 42,
      child: Stack(alignment: Alignment.bottomCenter, children: [
        Container(
          width: SizeConfig.safeBlockHorizontal! * 85,
          height: SizeConfig.safeBlockVertical! * 38,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                child: Column(
                  children: [
                    Text(
                      smallerTitle,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 1,
                    ),
                    TopResourceCard(
                      title: "Sejarah Last Minute Quick Notes",
                      tutor: "jinzhetan",
                      likes: 123,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 2,
                    ),
                    TopResourceCard(
                      title: "Chemistry Tips and Tricks",
                      tutor: "halo_tongxue",
                      likes: 79,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 15,
          child: Image.asset(
            image,
            scale: 1.4,
          ),
        )
      ]),
    );
  }
}

class TopResourceCard extends StatelessWidget {
  final String title;
  final String tutor;
  final int likes;
  const TopResourceCard({
    super.key,
    required this.title,
    required this.tutor,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //TOP RESOURCES CONTAINER
      width: SizeConfig.safeBlockHorizontal! * 75,
      height: SizeConfig.safeBlockVertical! * 11,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: SizedBox(
            width: SizeConfig.safeBlockHorizontal! * 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: (SizeConfig.safeBlockVertical! * 2),
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    "by $tutor",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: (SizeConfig.safeBlockVertical! * 1.8),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              const Icon(
                Icons.favorite_outline,
                size: 20,
              ),
              Text(likes.toString()),
            ],
          ),
        )
      ]),
    );
  }
}
