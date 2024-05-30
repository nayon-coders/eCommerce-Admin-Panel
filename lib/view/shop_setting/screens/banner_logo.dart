import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_admin/common_widget/app_button/app_button.dart';
import 'package:new_admin/common_widget/app_text/title_text.dart';
import 'package:new_admin/common_widget/images/app_network_image.dart';
import 'package:new_admin/controller/app_setting/app_setting_controller.dart';
import 'package:new_admin/controller/firebase_controlle/firebase_image_controller.dart';
import 'package:new_admin/utility/app_const.dart';

import '../../../model/product/category_model.dart';


class BannerLogos extends StatefulWidget {
  const BannerLogos({super.key});

  @override
  State<BannerLogos> createState() => _BannerLogosState();
}

class _BannerLogosState extends State<BannerLogos> {

  var logoImage, bannerImage;
  //store images into list
  updateCallback(file){
    setState(() {
      logoImage = file;
    });
  }
  //store images into list
  updateBannerCallback(file){
    setState(() {
      bannerImage = file;
    });
  }

  CategoryModel? selectCategory;

  selectCategorymethod() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Category'),
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

  List<CategoryModel> getCategoryList = [];
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();
  }

  bool _isLogoUploding = false;
  bool _isBannerUploding = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(20),
      child: ListView(
        children: [
          //logo
          Row(
            children: [
              Container(
                width: 150,
                height: 185,

                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text("Upload Your Logo"),
                    SizedBox(height: 5,),
                    InkWell(
                      onTap: ()async{
                          await FirebaseImageController.startWebFilePicker(updateCallback);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: logoImage != null ? Image.memory(logoImage, height: 70, width: 70,) : Icon(Icons.upload_outlined, color: Colors.grey, size: 70,),),
                      ),
                    ),
                    SizedBox(height: 10,),
                    AppButton(onClick: ()async{
                      if(logoImage != null){
                        setState(() => _isLogoUploding = true);

                        var logo = await FirebaseImageController.uploadImageToFirebaseStorage(logoImage, "app_logo");
                        AppSettingController.addLogo(context, logo);
                        logoImage = null;
                        setState(() => _isLogoUploding = false);
                      }else{
                        appSnackBar(context: context, text: "You forget to upload new logo");
                      }

                    }, isLoading: _isLogoUploding, text: "Upload")
                  ],
                ),
              ),
              SizedBox(width: 20,),
              Container(
                width: 250,
                height: 185,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: StreamBuilder(
                  stream: AppSettingController.getLogo(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    return snapshot.data!.exists ? Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(child: AppNetworkImage(src: "${snapshot.data!.data()!["logo"]}",  width: 150,
                              height: 150),),
                        )
                      ],
                    ) : Center(child: Text("Upload Logo"),);
                  }
                ),
              )
            ],
          ),

          SizedBox(height: 30,),
          TitleText(text: "App Banner"),
          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                width: 250,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text("Upload Your Banner"),
                    SizedBox(height: 5,),
                    InkWell(
                      onTap: ()async{
                        await FirebaseImageController.startWebFilePicker(updateBannerCallback);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: bannerImage != null ? Image.memory(bannerImage, height: 70, width: 70,) : Icon(Icons.upload_outlined, color: Colors.grey, size: 70,),),
                      ),
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
                        ) :  Row(
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
                    ),
                    SizedBox(height: 30,),
                    AppButton(onClick: ()async{
                      if(bannerImage != null){
                        setState(() => _isBannerUploding = true);

                        var image = await FirebaseImageController.uploadImageToFirebaseStorage(bannerImage, "app_banner");
                        AppSettingController.addBanner(context, image, selectCategory!);
                        bannerImage = null;
                        setState(() => _isBannerUploding = false);
                      }else{
                        appSnackBar(context: context, text: "You forget to upload new banner");
                      }

                    }, isLoading: _isBannerUploding, text: "Upload")
                  ],
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: Container(
                  height: 280,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: StreamBuilder(
                      stream: AppSettingController.getBanners(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(child: CircularProgressIndicator(),);
                        }
                        return snapshot.data!.docs.isNotEmpty != null ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (_, index){
                            var data = snapshot.data!.docs[index];
                            return ListTile(
                              leading: AppNetworkImage(src: "${data["image"]}"),
                              title:  Text("Category Name: ${data["category"]["category_name"]}"),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red,),
                                onPressed: (){
                                  appAlertDialog(context: context, child: const Text("Are you sure? You want to delete banner?"), onClick: (){
                                    AppSettingController.deleteBanner(snapshot.data!.docs[index].id, context);
                                  });
                                },
                              ),
                            );
                          },
                        ) : Center(child: Text("Upload Your Banner"),);
                      }
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
