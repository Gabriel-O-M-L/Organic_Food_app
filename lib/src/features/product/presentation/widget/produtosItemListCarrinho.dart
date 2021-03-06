import 'package:flutter/material.dart';
import 'package:pdm/src/features/product/presentation/page/produtos.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pdm/theme_manager.dart';

class ProdutoItemListCarrinho extends StatelessWidget {
  const ProdutoItemListCarrinho({
    Key? key,
    required this.produto,
    required this.onDelete,
  }) : super(key: key);

  final Produtos produto;
  final Function(Produtos) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Slidable(
        actionExtentRatio: 0.25,
        actionPane: const SlidableStrechActionPane(),
        secondaryActions: [
          IconSlideAction(
            caption: "Deletar",
            color: getTheme().colorScheme.secondary,
            icon: Icons.delete,
            onTap: () {
              onDelete(produto);
            },
          )
        ],
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[500],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Icon(Icons.shopping_basket_outlined, size: 70.0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nome: " + produto.P_name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "Preço: " + produto.P_value.toString() + "R\$",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "Tipo: " + produto.P_type,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "Rating: " + produto.P_ratings.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "Vendedor: " + produto.P_seller_name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
