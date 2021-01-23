part of 'widgets.dart';

class ProductCard extends StatelessWidget {
  final Products product;
  ProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      //margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
      //color: Colors.green[50],
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsPages(product: product),
                  settings: RouteSettings(arguments: product)));
        },
        title: Text(
          product.name,
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(NumberFormat.currency(
                locale: 'id', decimalDigits: 0, symbol: 'Rp. ')
            .format(int.parse(product.price))),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(product.image, scale: 40),
          child: Text(product.name[0], style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
