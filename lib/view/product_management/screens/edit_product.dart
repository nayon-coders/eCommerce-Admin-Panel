
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_admin/common_widget/app_input/app_input.dart';
import 'package:new_admin/common_widget/app_text/title_text.dart';
import 'package:new_admin/common_widget/images/app_network_image.dart';
import 'package:new_admin/controller/firebase_controlle/firebase_image_controller.dart';
import 'package:new_admin/controller/product_controller/category_controller.dart';
import 'package:new_admin/controller/product_controller/product_controller.dart';
import 'package:new_admin/controller/product_controller/product_jsons.dart';
import 'package:new_admin/model/product/category_model.dart';
import 'package:new_admin/model/product/product_model.dart';
import 'package:new_admin/model/product/variants_model.dart';
import 'package:new_admin/utility/app_const.dart';
import 'package:new_admin/utility/colors.dart';



class EditProduct extends StatefulWidget {
  final VoidCallback onClose;
  final ProductModel? productModel;
  final String id;
  final bool isView;
  const EditProduct({super.key, required this.onClose,  this.productModel, required this.id, this.isView = false});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  bool _isLoading = false;

  final _name = TextEditingController();
  final _shortDescription = TextEditingController();
  final _longDescription = TextEditingController();
  final _tags = TextEditingController();
  final _regularPrice = TextEditingController();
  final _wholeSellPrice = TextEditingController();
  final _sellerPrice = TextEditingController();
  final _discountPrice = TextEditingController();
  final _inStock = TextEditingController();

  CategoryModel? selectCategory;
  VariantsModel? selectedVariatn;
  Variants? existingVariants;
  String? _productType;
  List image = [];
  List<CategoryModel> getCategoryList = [];
  List<VariantsModel> getVariantList = [];
  List<TextEditingController> _variantPrintController = [];

  // Function to add a new TextFormField
  void _addTextField() {
    _variantPrintController.add(TextEditingController());
    setState(() {});
  }
  
  List<String> _images = []; 

  // Function to remove a TextFormField
  void _removeTextField(int index) {
    if (_variantPrintController.length > 1) {
      _variantPrintController[index].dispose();
      _variantPrintController.removeAt(index);
      setState(() {});
    }
  }


  //get category
  getCategory(){
    getCategoryList.clear();
    FirebaseFirestore.instance.collection(categoryCollection).get().then((value) {
      for(var i in value.docs!){
        print("category list ==== ${i.data()}");
        setState(() {
          getCategoryList.add(CategoryModel.fromJson(i.data()));
        });
      }
    });

  }

  //get category
  geetVariatn(){
    getVariantList.clear();
    FirebaseFirestore.instance.collection(variantCollection).get().then((value) {
      for(var i in value.docs!){
        print("getVariantList list ==== ${i.data()}");
        setState(() {
          getVariantList.add(VariantsModel.fromJson(i.data()));
        });
      }
    });

  }

  //store images into list
  updateCallback(file){
    setState(() {
      image.add(file);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();
    geetVariatn();

    print("Widget ---- ${widget.id}");

    //product assign
    _name.text = widget.productModel!.name!;
    _shortDescription.text = widget.productModel!.shortDescription!;
    _longDescription.text = widget.productModel!.longDescription!;
    _tags.text = widget.productModel!.productsTags!.join(", ");
    _regularPrice.text = widget.productModel!.regularPrice.toString()!;
    _wholeSellPrice.text = widget.productModel!.wholePrice.toString()!;
    _sellerPrice.text = widget.productModel!.sellingPrice.toString()!;
    _discountPrice.text = widget.productModel!.discountPrice.toString()!;
    _inStock.text = widget.productModel!.isStock.toString()!;
    selectCategory =  CategoryModel.fromJson(widget.productModel!.categoryS!.toJson());
    //variant
    existingVariants = Variants.fromJson(widget.productModel!.variants!.toJson());
    for(var i = 0; i< widget.productModel!.variants!.valiantsList!.length; i++){
      _variantPrintController.add(TextEditingController());
      _variantPrintController[i].text = widget.productModel!.variants!.valiantsList![i].prince!;
    }
    
    for(var i in widget.productModel!.images!){
      _images.add(i); 
    }
    _productType = widget.productModel!.productType.toString()!;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              widget.isView?   TitleText(text: "View Product") : TitleText(text: "Edi Product"),

                IconButton(onPressed: widget.onClose, icon: Icon(Icons.close, color: Colors.red,))
              ],
            ),
            SizedBox(height: 20,),
            SizedBox(
              //height: size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Gnarel information
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("General Information",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black
                              )
                          ),
                          SizedBox(height: 20,),
                          Text("Product Name",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13, color: Colors.black
                            ),
                          ),
                          SizedBox(height: 5,),
                          AppInputField(controller: _name, hintText: "Product name"),
                          SizedBox(height: 10,),
                          const Text("Product Short Description",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13, color: Colors.black
                            ),
                          ),
                          SizedBox(height: 5,),
                          AppInputField(controller: _shortDescription, hintText: "Short description (200 Charters)", maxLine: 3,),
                          SizedBox(height: 10,),
                          const Text("Product Long Description",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13, color: Colors.black
                            ),
                          ),
                          SizedBox(height: 5,),
                          AppInputField(controller: _longDescription, hintText: "Long description (Min 200 Charters)", maxLine: 6,),
                          SizedBox(height: 10,),
                          const Text("Product Tag's",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13, color: Colors.black
                            ),
                          ),
                          SizedBox(height: 5,),
                          AppInputField(controller: _tags, hintText: "Product Tags (Tags, Tags, Tags...) ", maxLine: 1,),
                          SizedBox(height: 5,),
                          SizedBox(height: 85,
                            child: Row(
                              children: [

                                Expanded(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10,),
                                    const Text("Product Type",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13, color: Colors.black
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isExpanded: true,
                                        hint: Text(
                                          'Select Type',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                        items: ProductJson.productTypeList
                                            .map((String item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                            .toList(),
                                        value: _productType,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _productType = value;
                                          });
                                        },
                                        buttonStyleData:  ButtonStyleData(
                                            padding: EdgeInsets.symmetric(horizontal: 16),
                                            height: 40,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(width: 1, color: Colors.grey.shade200)
                                            )
                                        ),
                                        menuItemStyleData: const MenuItemStyleData(
                                          height: 40,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                                SizedBox(width: 10,),
                                Expanded(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10,),
                                    const Text("In Store",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13, color: Colors.black
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    AppInputField(controller: _inStock, hintText: "1000", maxLine: 1,),
                                  ],
                                )),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          const Text("Product Images",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13, color: Colors.black
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                              width: double.infinity,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1, color: Colors.grey.shade200)
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap:()async{
                                      await FirebaseImageController.startWebFilePicker(updateCallback);
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(width: 1, color: AppColors.mainColor)
                                      ),
                                      child: Center(
                                        child: Icon(Icons.upload_outlined, color: AppColors.mainColor, size: 30,),
                                      ),
                                    ),
                                  ),
                                  image.isNotEmpty?  Expanded(
                                    child: ListView.builder(
                                      itemCount: image.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (_, index){
                                        return Stack(
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 100,
                                              margin: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(width: 1, color: AppColors.mainColor)
                                              ),
                                              child: Center(
                                                  child: Image.memory(image[index])
                                              ),
                                            ),
                                            Positioned(
                                              right: 15,
                                              top: 15,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(100)
                                                ),
                                                child: IconButton(onPressed: (){
                                                  setState(() {
                                                    image.removeAt(index);
                                                  });
                                                }, icon: Icon(Icons.delete, color: Colors.red,)),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  ) :   _images.isNotEmpty ?   Expanded(
                                    child: ListView.builder(
                                      itemCount: _images.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (_, index){
                                        return Stack(
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 100,
                                              margin: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(width: 1, color: AppColors.mainColor)
                                              ),
                                              child: Center(
                                                  child: AppNetworkImage(src: _images[index])
                                              ),
                                            ),
                                            Positioned(
                                              right: 15,
                                              top: 15,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(100)
                                                ),
                                                child: IconButton(onPressed: (){
                                                  setState(() {
                                                    _images.removeAt(index);
                                                  });
                                                }, icon: Icon(Icons.delete, color: Colors.red,)),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  ): Center()
                                ],
                              )
                          )

                        ],
                      ),
                    ),
                  ),


                  //price, category
                  SizedBox(width: 20,),
                  Expanded(child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //pricing part
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pricing",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black
                                  )
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 75,
                                    width: 230,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Product Price",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13, color: Colors.black
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        AppInputField(controller: _regularPrice, hintText: "Product prince"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  SizedBox(
                                    width: 230,
                                    height: 75,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Seller Price",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13, color: Colors.black
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        AppInputField(controller: _sellerPrice, hintText: "Seller prince"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 75,
                                    width: 230,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Whole Price",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13, color: Colors.black
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        AppInputField(controller: _wholeSellPrice, hintText: "Whole prince"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  SizedBox(
                                    width: 230,
                                    height: 75,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Deicount",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13, color: Colors.black
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Expanded(child: AppInputField(controller: _discountPrice, hintText: "Discount")),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Category",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black
                                  )
                              ),
                              SizedBox(height: 20,),
                              InkWell(
                                onTap: ()=>selectCategorymethod(),
                                child: Container(
                                  width: double.infinity,
                                  //height: 40,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    //color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(width: 1, color: Colors.grey.shade200),
                                  ),
                                  child: selectCategory != null ?  Text(
                                    '${selectCategory!.categoryName}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ):  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Select Category',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      Icon(Icons.arrow_drop_down, color: Colors.grey,)
                                    ],
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Product Variation",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black
                                  )
                              ),
                              SizedBox(height: 20,),

                              selectedVariatn != null ? InkWell(
                                onTap: ()=> selectVariantMethod(),
                                child: Container(
                                  width: double.infinity,
                                  //height: 40,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    //color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(width: 1, color: Colors.grey.shade200),
                                  ),
                                  child: selectedVariatn != null ?  Text(
                                    '${selectedVariatn!.name}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ):  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Variants',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      Icon(Icons.arrow_drop_down, color: Colors.grey,)
                                    ],
                                  ),
                                ),
                              ) : InkWell(
                                onTap: ()=> selectVariantMethod(),
                                child: Container(
                                  width: double.infinity,
                                  //height: 40,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    //color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(width: 1, color: Colors.grey.shade200),
                                  ),
                                  child: existingVariants != null ?  Text(
                                    '${existingVariants!.variants}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ):  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Variants',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      Icon(Icons.arrow_drop_down, color: Colors.grey,)
                                    ],
                                  ),
                                ),
                              ),


                              selectedVariatn != null ?  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20,),
                                  Text("Selected Variant: ${selectedVariatn!.name}"),
                                  SizedBox(height: 5,),
                                  Divider(),
                                  SizedBox(height: 5,),
                                  for(var i=0; i<selectedVariatn!.variants!.length; i++)
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1, color: Colors.grey.shade200),
                                      ),
                                      margin: EdgeInsets.only(bottom: 10),
                                      width: double.infinity,
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${selectedVariatn!.variants![i]}"),
                                          SizedBox(width: 100, height: 40, child: AppInputField(controller: _variantPrintController[i], hintText: "\$0.00"))

                                        ],
                                      ),
                                    )
                                ],
                              ) :  existingVariants != null ?
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20,),
                                  Text("Selected Variant: ${existingVariants!.variants}"),
                                  SizedBox(height: 5,),
                                  Divider(),
                                  SizedBox(height: 5,),
                                  for(var i=0; i<existingVariants!.valiantsList!.length; i++)
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1, color: Colors.grey.shade200),
                                      ),
                                      margin: EdgeInsets.only(bottom: 10),
                                      width: double.infinity,
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${existingVariants!.valiantsList![i].name}"),
                                          SizedBox(width: 100, height: 40, child: AppInputField(controller: _variantPrintController[i], hintText: "\$0.00"))

                                        ],
                                      ),
                                    )
                                ],
                              ) : Center()

                            ],
                          ),
                        ),

                      ],
                    ),
                  ))
                ],
              ),
            ),
            SizedBox(height: 30,),

         widget.isView ? Center() :   InkWell(
              onTap: ()async{
                setState(() => _isLoading = true);
                //add product
                try{
                  int id = Random().nextInt(99999);
                  List<String> tagList = _tags.text.split(",");

                  //image to string link convert
                  List convertedImage = [];
                  if(image.isNotEmpty ){
                    for(var i=0; i<image.length; i++){
                      convertedImage.add(await FirebaseImageController.uploadImageToFirebaseStorage(image[i], "product_image"));
                    }
                  }else{
                    for(var i=0; i<_images.length; i++){
                      print("_images[i] ----- ${_images[i]}");
                      convertedImage.add(_images[i]);
                    }
                  }


                  var date = DateTime.now();

                  List<ValiantsList> _selectedVariantsList = [];


                  var variant;
                  if(selectedVariatn!=null){
                    for(var i=0; i<selectedVariatn!.variants!.length; i++){
                      _selectedVariantsList.add(ValiantsList(name: selectedVariatn!.variants![i], prince: _variantPrintController[i].text));
                    }
                    variant = Variants(
                        variants: selectedVariatn!.name.toString(),
                        valiantsList: _selectedVariantsList
                    );
                  }else{
                    variant = existingVariants;
                  }

                  var data = ProductModel(
                      id: id.toString(),
                      name: _name.text,
                      productsTags: tagList,
                      productType: _productType,
                      discountPrice: _discountPrice.text,
                      wholePrice: _wholeSellPrice.text,
                      sellingPrice: _sellerPrice.text,
                      regularPrice: _regularPrice.text,
                      images: convertedImage,
                      shortDescription: _shortDescription.text,
                      longDescription: _longDescription.text,
                      isStock: _inStock.text,
                      createAt: date.toString(),
                      categoryS: CategoryS.fromJson(selectCategory!.toJson()) ,
                      variants: variant,
                      status: "Active"
                  );

                  //send to the database
                  await ProductController.editProducts(widget.id, data, context);
                  setState(() => _isLoading = false);
                }catch(e){
                  print("Edit error --- ${e}");
                  setState(() => _isLoading = false);
                }

              },
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: _isLoading ? CircularProgressIndicator(color: Colors.white,) : Text("Edit Product",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  ),
                ),),
              ),
            )

          ],
        ),
      ),
    );
  }

  selectVariantMethod() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Variant'),
          content: Container(
              width: 300,
              //height: 500,
              child: ListView.builder(
                itemCount: getVariantList.length,
                itemBuilder: (_, index){
                  return Container(
                    //height: 40,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200
                    ),
                    child: ListTile(
                      onTap: (){
                        setState(() {
                          selectedVariatn = getVariantList[index];
                        });
                        for(var i =0; i< selectedVariatn!.variants!.length; i++){
                          _variantPrintController.add(TextEditingController());
                          print("_variantPrintController === ${_variantPrintController.length}");
                        }
                        Navigator.pop(context);
                      },
                      title: Text("${getVariantList[index].name}"),
                    ),
                  );
                },
              )
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancle'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  selectCategorymethod() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Category'),
          content: Container(
              width: 300,
              //height: 500,
              child: ListView.builder(
                itemCount: getCategoryList.length,
                itemBuilder: (_, index){
                  return Container(
                    //height: 40,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200
                    ),
                    child: ListTile(
                      onTap: (){
                        setState(() {
                          selectCategory = getCategoryList[index];
                        });

                        Navigator.pop(context);
                      },
                      leading: AppNetworkImage(src: "${getCategoryList[index].categoryImage}",),
                      title: Text("${getCategoryList[index].categoryName}"),
                    ),
                  );
                },
              )
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancle'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
