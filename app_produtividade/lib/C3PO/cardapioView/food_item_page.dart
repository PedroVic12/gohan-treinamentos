import 'package:app_produtividade/C3PO/cardapioView/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_produtividade/widgets/Custom/CustomText.dart';

import 'model_food.dart';

class MyWidget extends StatelessWidget {
  //final Food food;
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // food image
        Image.asset(""),

        // food name
        CustomText(text: "widget.food.name"),

        CustomText(text: "widget.food.name"),

        // fodd description

        // add itens importante com repository

        //return checkbox

        // botao voltar para o zap
      ],
    );
  }
}

class ItemDetailsPage extends StatelessWidget {
  ItemDetailsPage({super.key, required this.produto_selecionado});
  // final CarrinhoPedidoController carrinho =
  //     Get.find<CarrinhoPedidoController>();
  // final CardapioFormController form_controller =
  //     Get.put(CardapioFormController());
  var produto_selecionado = ProdutoModel;
  final carrinho = Get.put(CarrinhoPedidoController());

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black.withGreen(1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: [
              botoesSuperior(produto_selecionado),
              //CarrouselImagensWidget(produto_selecionado: produto_selecionado),
              detalhesProdutos("Conheça mais sobre o produto "),
              //showProdutosComSubCategorias(                produto_selecionado,              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showProdutosComSubCategorias(ProdutoModel produto) {
    if (produto.sub_categoria != null) {
      print(produto.sub_categoria);
      print('\n\nProduto com varias categorias para o cliente selecionar');
      print("Details page é diferente");

      return Column(
        children: [
          Container(
            child: CustomText(
              text: "Item = ${produto.nome} ${produto.sub_categoria}",
              color: Colors.white,
              size: 30,
            ),
          ),
          RadioButtonGroup(
            niveis: ["nivel 1", "nivel 2", "nivel 3", "nivel 4", "nivel 5"],
            nivelSelecionado: RxString("nivel 1"),
          ),
        ],
      );
    } else {
      return Text('Sem descrição');
    }
  }

  Widget botoesSuperior(produto) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          CustomText(
            text: "produto_selecionado",
            color: Colors.white,
            size: 28,
          ),
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.shopping_cart_rounded,
              color: Colors.white,
              size: 32,
            ),
          )
        ],
      ),
    );
  }

  Widget btnQuantidade() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            //carrinho.removerProduto(produto_selecionado);
          },
          child: Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Icon(CupertinoIcons.minus_circle_fill, size: 32),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Obx(() {
          final quantidade = 7;
          return CustomText(
            text: ' $quantidade',
            size: 28,
            color: Colors.white,
            weight: FontWeight.bold,
          );
        }),
        SizedBox(
          width: 12,
        ),
        InkWell(
          onTap: () {
            //carrinho.adicionarCarrinho(produto_selecionado);
          },
          child: Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Icon(
              CupertinoIcons.plus_circle_fill,
              size: 32,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget detalhesProdutos(String txt) {
    //final produto = carrinho.SACOLA.keys.toList()[index];
    //final quantidade = carrinho.SACOLA[produto] ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          //end crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(
              text: "${txt} produto.nome\nQue tal matar a fome com ele? hmmm",
              size: 18,
              color: Colors.white,
              weight: FontWeight.bold,
            ),
            SizedBox(
              width: 30,
            ),
            //btnQuantidade()
          ],
        ),
        CustomText(
          text: '\nIngredientes: {produto.nome.}',
          size: 18,
          color: Colors.white,
          weight: FontWeight.bold,
        )
      ],
    );
  }
}
