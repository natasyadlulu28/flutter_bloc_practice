part of 'models.dart';

class Products extends Equatable{
  
  final String pid;
  final String productName;
  final String productPrice;
  final String productPic;
  
  Products(this.pid, this.productName, this.productPrice, this.productPic);
                      // {} berarti ga wajib
  @override
  List<Object> get props => [pid, productName, productPrice, productPic];

}