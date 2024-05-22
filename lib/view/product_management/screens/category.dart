import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_admin/common_widget/app_input/app_input.dart';
import 'package:new_admin/utility/colors.dart';

class Category extends StatefulWidget {

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final _categoryName = TextEditingController();

  final _subCategoryName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: ListView(
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
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1, color: Colors.grey),
                              ),
                              child: Center(
                                child: Icon(Icons.upload_outlined, color: Colors.grey, size: 80,),
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
                            Text("Add Sub Category",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black
                              ),
                            ),

                            SizedBox(height: 20,),
                            Expanded(
                              child: AppInputField(
                                controller: _categoryName,
                                hintText: "Sub Category Name",
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
                      )
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
                        Text("All Category",
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
                                  leading: Image.network("assets/images/category.jpeg", height: 60, width: 60,),
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
                                        child:  Text("--- Sub Category Name",
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
      )
    );
  }
}
