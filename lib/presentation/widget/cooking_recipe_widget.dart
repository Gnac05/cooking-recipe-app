import 'package:cooking_recipe_app/domain/entities/cooking_recipe.dart';
import 'package:flutter/material.dart';

class CookingRecipeWidget extends StatelessWidget {
  const CookingRecipeWidget({Key? key, required this.cR, required this.index})
      : super(key: key);
  final CookingRecipe cR;
  final int index;

  @override
  Widget build(BuildContext context) {
    String image = "assets/pate-legume.png";
    switch (index % 4) {
      case 0:
        image = "assets/recipe1.jpg";
        break;

      case 1:
        image = "assets/recipe2.jpg";
        break;

      case 2:
        image = "assets/recipe3.jpg";
        break;

      case 3:
        image = "assets/recipe4.jpg";
        break;

      default:
        image = "assets/pate-legume.png";
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 175,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset(
                      image,
                      // loadingBuilder: (context, child, loadingProgress) =>
                      //     const CardLoading(height: 155),
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Text("404 Not Found")),
                    ).image
                    // Image.asset(
                    //   "assets/pate-legume.png",
                    // ).image
                    ,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                width: double.infinity,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  color: Color(0xFFD8CDCD),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cR.nomPlat,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${cR.time}min",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
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

// Future<String?> getVideoThumbnail(String url) async {
//   String videoUrl = url; // Remplacez par l'URL de votre vidéo
//   final thumbnailPath = await VideoThumbnail.thumbnailFile(
//     video: videoUrl,
//     thumbnailPath: (await VideoThumbnail.thumbnailFile(
//       video: videoUrl,
//       thumbnailPath: (await getTemporaryDirectory()).path,
//       imageFormat: ImageFormat.JPEG,
//       maxHeight: 170,
//       quality: 75,
//     ))
//         .path,
//     imageFormat: ImageFormat.WEBP,
//     maxHeight: 170,
//     quality: 75,
//   );

//   return thumbnailPath;
// }
