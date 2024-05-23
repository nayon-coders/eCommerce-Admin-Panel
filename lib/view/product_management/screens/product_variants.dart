import 'dart:math';

import 'package:flutter/material.dart';
import 'package:new_admin/controller/product_controller/variants_controller.dart';
import 'package:new_admin/model/product/variants_model.dart';

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
  var selectedVariantsId;
  var selectedDocId;

  bool isEdit = false;

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
                              InkWell(
                                onTap: ()async{
                                  if(isEdit){
                                    //edit existing
                                    List<String> variants = _variants.text.split(',');
                                    VariantsModel  variantsModel = VariantsModel(id: selectedVariantsId, name: _variantName.text, variants:variants );
                                    await VariantsController.editVariants( selectedDocId, variantsModel,);
                                    _variantName.clear();
                                    _variants.clear();
                                    setState(() {
                                      isEdit = false;
                                    });
                                  }else{
                                    //add new
                                    int id = Random().nextInt(100000);
                                    List<String> variants = _variants.text.split(',');
                                    VariantsModel  variantsModel = VariantsModel(id: id.toString(), name: _variantName.text, variants:variants );
                                    await VariantsController.addVariants(variantsModel);
                                    _variantName.clear();
                                    _variants.clear();
                                  }

                                },
                                child: Container(
                                  width: 70,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(child: Text( isEdit ? "Edit":"Add"),),
                                ),
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
                            child: StreamBuilder(
                              stream: VariantsController.getVariants(),
                              builder: (context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return Center(child: CircularProgressIndicator(),);
                                }else{
                                  List<VariantsModel> variantsList = [];
                                  for(var i in snapshot.data!.docs!){
                                    variantsList.add(VariantsModel.fromJson(i.data()));
                                  }
                                  return variantsList.isNotEmpty
                                      ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: variantsList.length,
                                    itemBuilder: (_, index){
                                      var data = variantsList[index];
                                      return Container(
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.only(bottom: 10),
                                        color: Colors.grey.shade100,
                                        child: ListTile(
                                          title: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("${data.name}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Padding(padding: EdgeInsets.only(left: 25, top: 10),
                                                child:  Text("--- ${data.variants}",
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
                                                IconButton(onPressed: (){
                                                  setState(() {
                                                    _variantName.text = data.name.toString();
                                                    String lowerCaseSizes = data.variants!.map((size) => size).join(',');
                                                    _variants.text = lowerCaseSizes;
                                                     isEdit = true;
                                                    selectedVariantsId = data.id;
                                                    selectedDocId = snapshot.data!.docs![index]!.id;
                                                  });
                                                }, icon: Icon(Icons.edit, color: Colors.amber,)),
                                                IconButton(onPressed: ()async{
                                                  await VariantsController.deleteVariants(snapshot.data!.docs![index]!.id);
                                                }, icon: Icon(Icons.delete, color: Colors.red,)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                      : Center(child: Text("Empty"),);
                                }

                              }
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

