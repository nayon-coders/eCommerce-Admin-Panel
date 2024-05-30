
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_admin/common_widget/app_button/app_button.dart';
import 'package:new_admin/common_widget/app_input/app_input.dart';
import 'package:new_admin/common_widget/images/app_network_image.dart';
import 'package:new_admin/controller/firebase_controlle/firebase_image_controller.dart';
import 'package:new_admin/controller/product_controller/category_controller.dart';
import 'package:new_admin/model/product/category_model.dart';
import 'package:new_admin/utility/app_const.dart';
import 'package:new_admin/utility/colors.dart';

import '../../../common_widget/alart/app_alart.dart';

class Category extends StatefulWidget {

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final _categoryName = TextEditingController();

  final _subCategoryName = TextEditingController();

  Uint8List? selectedFile;

  // Method to update the data
  void updateData(newData) {
    setState(() {
      selectedFile = newData;
    });
  }


  bool _isEdit = false;
  bool _isLoading = false;
  var selectedId, selectedDocId, selectedImage;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        width: double.infinity,
        //height: size.height - 200,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Category Management",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              Divider(height: 1, color: Colors.grey.shade200,),
              SizedBox(height: 10,),
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
                            height: 350,
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
                                Text("Add New Category",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black
                                  ),
                                ),
                                SizedBox(height: 20,),
                                InkWell(
                                  onTap: ()async{
                                    await FirebaseImageController.startWebFilePicker(updateData);
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(width: 1, color: Colors.grey),
                                    ),
                                    child: Center(
                                      child: selectedFile != null ? Image.memory(selectedFile!) :  selectedImage != null ? Image.network(selectedImage!) : Icon(Icons.upload_outlined, color: Colors.grey, size: 80,),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Expanded(
                                  child: AppInputField(
                                    controller: _categoryName,
                                    hintText: "Category Name",
                                  ),
                                ),
                                SizedBox(height: 20,),
                                AppButton(onClick: ()async{
                                  try{
                                    if(_isEdit){
                                      setState(() => _isLoading = true);
                                      //edit data
                                      if(selectedFile != null){
                                        selectedImage = await FirebaseImageController.uploadImageToFirebaseStorage(selectedFile!, "category_img");
                                      }
                                      var categoryModel = CategoryModel(id: selectedId, categoryName: _categoryName.text, categoryImage: selectedImage, createAt: todayDate.toString() );
                                      //store data
                                      await CategoryController.editCategory(selectedDocId, categoryModel);

                                      _categoryName.clear();
                                      selectedFile = null;
                                      setState(() {
                                        _isEdit = false;
                                        _isLoading = false;
                                      });

                                    }else{
                                      setState(() => _isLoading = true);
                                      //store data...
                                      int id = Random().nextInt(100000);
                                      var image = await FirebaseImageController.uploadImageToFirebaseStorage(selectedFile!, "category_img");
                                      var categoryModel = CategoryModel(id: id.toString(), categoryName: _categoryName.text, categoryImage: image.toString(), createAt: todayDate.toString() );
                                      //store data
                                      await CategoryController.addCategory(categoryModel.toJson(), context);

                                      _categoryName.clear();
                                      selectedFile = null;
                                      setState(() => _isLoading = false);
                                    }

                                  }catch(e){
                                    setState(() => _isLoading = false);
                                  }
                                  setState(() => _isLoading = false);
                                }, text: _isEdit ? "Edit" : "Add", isLoading: _isLoading,),
          
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child:  Container(
                        //height: size.height,
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
                            Text("All Category",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black
                              ),
                            ),
          
                            SizedBox(
                              child: StreamBuilder(
                                stream: CategoryController.getAllCategory(),
                                builder: (context, snapshot) {
                                  //store data into a list model
                                  List<CategoryModel> categories = [];
          
          
          
                                  if(snapshot.connectionState == ConnectionState.waiting){
                                    return Center(child: CircularProgressIndicator(),);
                                  }else{
                                    for(var i in snapshot.data!.docs!){
                                      print("i.data() === ${i.data()}");
                                      categories.add(CategoryModel.fromJson(i.data()));
                                    }
          
                                    return categories.isNotEmpty ?  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: categories.length,
                                      itemBuilder: (_, index){
                                        var data = categories[index];
                                        return Container(
                                          padding: EdgeInsets.all(5),
                                          margin: EdgeInsets.only(bottom: 10),
                                          color: Colors.grey.shade100,
                                          child: ListTile(
                                            leading: SizedBox(width: 60, height: 60, child: AppNetworkImage(src: data.categoryImage.toString(), )),
                                            title: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("${data.categoryName}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text("Create at: ${data.createAt}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            trailing: SizedBox(
                                              width: 100,
                                              child: Row(
                                                children: [
                                                  IconButton(onPressed: (){
                                                    setState(() {
                                                      selectedId = data.id;
                                                      selectedDocId = snapshot.data!.docs![index]!.id;
                                                      selectedImage = data.categoryImage;
                                                      _categoryName.text = data.categoryName!;
                                                      _isEdit = true;
                                                    });
                                                  }, icon: Icon(Icons.edit, color: Colors.amber,)),
                                                  IconButton(onPressed: ()async{
                                                    await CategoryController.deleteCategory(snapshot.data!.docs![index].id);
                                                  }, icon: Icon(Icons.delete, color: Colors.red,)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ) : Center(child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.arrow_back_sharp, size: 30, color: Colors.black,),
                                        SizedBox(width: 10,),
                                        Text("Add new category",
                                          style: TextStyle(
                                              fontSize: 20, fontWeight: FontWeight.w600
                                          ),
                                        )
                                      ],
                                    ),);
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
        )
    );
  }


}
