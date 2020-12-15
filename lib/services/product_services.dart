part of 'services.dart';

class ProductServices {
  static CollectionReference productCollection =
      FirebaseFirestore.instance.collection("product");

  static DocumentReference productDoc;

  static Reference ref;
  static UploadTask uploadTask;

  static String imgUrl;

  static Future<bool> addProduct(Products product, PickedFile imgFile) async {
    await Firebase.initializeApp();

    productDoc = await productCollection.add({
      'pid': "",
      'productName': product.productName,
      'productPrice': product.productPrice,
      'image': "",
    });

    if (productDoc.id != null) {
      ref = FirebaseStorage.instance
          .ref()
          .child("images")
          .child(product.pid + ".png");
      uploadTask = ref.putFile(File(imgFile.path));

      await uploadTask.whenComplete(
          () => ref.getDownloadURL().then((value) => imgUrl = value));

      productCollection.doc(productDoc.id).update({
        'id': productDoc.id,
        'image': imgUrl,
      });

      return true;
    } else {
      return false;
    }
  }
}
