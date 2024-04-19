import 'package:app_produtividade/C3PO/cardapioView/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_produtividade/widgets/Custom/CustomText.dart';

import 'model_food.dart';

class ItemDetailsPage extends StatefulWidget {
  final ProdutoModel produto_selecionado;

  ItemDetailsPage({Key? key, required this.produto_selecionado})
      : super(key: key);

  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  final Map<String, bool> addSelecionados = {};

  @override
  void initState() {
    super.initState();
    iniciarAdicionais();
  }

  void iniciarAdicionais() {
    widget.produto_selecionado.Adicionais!.forEach((key, value) {
      addSelecionados[key] = false;
    });
  }

  List<ProdutoModel> getProdutoAtualizado() {
    List<ProdutoModel> produtosAtualizados = [];

    // Adiciona o produto principal sem alterações
    produtosAtualizados.add(widget.produto_selecionado);

    // Adiciona os produtos com os adicionais selecionados
    widget.produto_selecionado.Adicionais!.forEach((key, value) {
      if (addSelecionados[key] == true) {
        var novoProduto = widget.produto_selecionado
            .copyWith(preco_1: widget.produto_selecionado.preco_1 + value);
        produtosAtualizados.add(novoProduto);
      }
    });

    return produtosAtualizados;
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;

    var newPrice = getProdutoAtualizado();

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: [
              botoesSuperior(widget.produto_selecionado),
              const SizedBox(height: 16),

              // food image
              Expanded(
                child: Placeholder(),
              ),
              //CarrouselImagensWidget(produto_selecionado: widget.produto_selecionado),

              detalhesInfoProduto(),

              // add itens importante com repository
              showProdutosComSubCategorias(widget.produto_selecionado),

              showAdicionaisProduto(widget.produto_selecionado),

              CustomText(
                  text: "Total: R\$ ${newPrice.last}", color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget detalhesInfoProduto() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        // food name
        CustomText(
          text: widget.produto_selecionado.nome,
          //color: Colors.white,
          weight: FontWeight.bold,
          size: 26,
        ),
        CustomText(
          text: "R\$ ${widget.produto_selecionado.preco_1.toString()} reais",
        ),
        const SizedBox(height: 16),

        // food description
        CustomText(
          text: widget.produto_selecionado.ingredientes!,
          //color: Colors.white,
          weight: FontWeight.bold,
          size: 16,
        ),
        const Divider(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget showProdutosComSubCategorias(ProdutoModel produto) {
    if (produto.sub_categoria != null) {
      return Container(
        child: CustomText(
          text: "${widget.produto_selecionado.sub_categoria}",
          color: Colors.white,
          size: 30,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showAdicionaisProduto(ProdutoModel produto) {
    if (produto.sub_categoria == "SIM") {
      print(produto.sub_categoria);
      print('\n\nProduto com varias categorias para o cliente selecionar');
      print("Details page é diferente");

      return Column(
        children: [
          CustomText(
            text: "Turbine seu ${widget.produto_selecionado.nome}",
            //color: Colors.white,
            size: 24,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.produto_selecionado.Adicionais!.length,
              itemBuilder: (context, index) {
                final adicionais =
                    widget.produto_selecionado.Adicionais!.keys.toList();
                final adicional = adicionais[index];
                final precoAdicional =
                    widget.produto_selecionado.Adicionais![adicional];

                return CheckboxListTile(
                  title: CustomText(text: adicional),
                  subtitle: CustomText(
                    text: "Preço: R\$ $precoAdicional",
                  ),
                  value: addSelecionados[adicional] ?? false,
                  onChanged: (value) {
                    setState(() {
                      addSelecionados[adicional] = value!;
                    });
                  },
                );
              },
            ),
          ),
          Divider()
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
        color: Colors.black.withBlue(10),
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
}
