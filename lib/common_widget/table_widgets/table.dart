import 'package:flutter/material.dart';

import '../../utility/colors.dart';


class AppTable extends StatelessWidget {
   AppTable({super.key, required this.headersChildren, required this.row, required this.onSearch, required this.searchController, required this.title});
  final List<Widget> headersChildren;
  final Color headerBg = Colors.green.shade100;
  final Widget row;
  final VoidCallback onSearch;
  final TextEditingController searchController;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text("${title}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            Row(

              children: [
                SizedBox(
                  width: 300,
                  height: 40,
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15, right: 15),
                        hintText: "Company Name, Phone Number, Author...",
                        fillColor: Colors.white,
                        hintStyle: TextStyle(
                            fontSize: 12
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        )
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                InkWell(
                  onTap: onSearch,
                  child: Container(
                    width: 70, height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                    ),
                    child: const Center(child: Text("Search",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),),
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(height: 10,),
        // Container(
        //   width: double.infinity,
        //   //padding: EdgeInsets.all(1),
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     // borderRadius: BorderRadius.circular(10)
        //   ),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //
        //     ],
        //   ),
        // ),
        SizedBox(height: 15,),
        Container(
          width: double.infinity,
          height: 50,
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
              color: headerBg
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: headersChildren
          ),
        ),

        //row coming here
        row

      ],
    );
  }
}
