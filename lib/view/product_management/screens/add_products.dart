
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:new_admin/common_widget/app_input/app_input.dart';
import 'package:new_admin/common_widget/app_text/title_text.dart';
import 'package:new_admin/utility/colors.dart';


class AppProducts extends StatefulWidget {
  const AppProducts({super.key});

  @override
  State<AppProducts> createState() => _AppProductsState();
}

class _AppProductsState extends State<AppProducts> {

  final _name = TextEditingController();
  final _shortDescription = TextEditingController();
  final _longDescription = TextEditingController();
  final _tags = TextEditingController();
  final _regularPrice = TextEditingController();
  final _wholeSellPrice = TextEditingController();
  final _sellerPrice = TextEditingController();
  final _discountPrice = TextEditingController();

  List i = [1, 2, 3, 4, 5, 6];

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;

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
            TitleText(text: "Add New Product"),
            SizedBox(height: 20,),
            SizedBox(
              height: size.height,
              child: Row(
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
                                  Container(
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
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: i.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (_, index){
                                          return Container(
                                            width: 100,
                                            height: 100,
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(width: 1, color: AppColors.mainColor)
                                            ),
                                            child: Center(
                                             // child: //Icon(Icons.upload_outlined, color: AppColors.mainColor, size: 30,),
                                            ),
                                          );
                                        },
                                      ),
                                    )
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
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Select Category',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: items
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
                                  value: selectedValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValue = value;
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
                              SizedBox(height: 10,),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Select Sub Category',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: items
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
                                  value: selectedValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValue = value;
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
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Select Variant',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: items
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
                                  value: selectedValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValue = value;
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
                              SizedBox(height: 10,),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Select Sub Category',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: items
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
                                  value: selectedValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValue = value;
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
                          ),
                        ),

                      ],
                    ),
                  ))
                ],
              ),
            ),
            SizedBox(height: 30,),

            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text("Add Product",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),
              ),),
            )

          ],
        ),
      ),
    );
  }
}
