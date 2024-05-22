import 'package:flutter/material.dart';

import '../../../common_widget/app_input/app_input.dart';
import '../../../common_widget/app_text/title_text.dart';
import '../../../utility/colors.dart';


class ProductVariant extends StatefulWidget {
  const ProductVariant({super.key});

  @override
  State<ProductVariant> createState() => _ProductVariantState();
}

class _ProductVariantState extends State<ProductVariant> {
  final _variants = TextEditingController();
  final _variantName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      child:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(text: "Product Variant",),
            SizedBox(height: 20,),
            SizedBox(
              height: size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //add new category
                  SizedBox(
                    width: 350,
                    child: Column(
                      children: [
                        Container(
                          width: 350,
                          height: 250,
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Add Variant",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(height: 20,),
                              Expanded(
                                child: AppInputField(
                                  controller:_variantName,
                                  hintText: "Variant Name",
                                ),
                              ),
                              SizedBox(height: 20,),
                              Expanded(
                                child: AppInputField(
                                  controller:_variants,
                                  hintText: "Variants: KG,GM,",
                                ),
                              ),
                              SizedBox(height: 20,),
                              Container(
                                width: 70,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(child: Text("Add"),),
                              )

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child:  Container(
                      height: size.height,
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("All Variant",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black
                            ),
                          ),

                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 10,
                              itemBuilder: (_, index){
                                return Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.only(bottom: 10),
                                  color: Colors.grey.shade100,
                                  child: ListTile(
                                    title: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Category Name",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.only(left: 25, top: 10),
                                          child:  Text("--- KG, GM, LM",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    trailing: SizedBox(
                                      width: 100,
                                      child: Row(
                                        children: [
                                          IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Colors.amber,)),
                                          IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Colors.red,)),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )

                        ],
                      ),
                    ),
                  )



                  //show all cagtegory list
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

