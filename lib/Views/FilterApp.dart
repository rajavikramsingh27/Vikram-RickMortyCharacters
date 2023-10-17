
import 'package:flutter/material.dart';

import '../Styles/TextStyles.dart';

final arrFilterTitle = ["name", "status", "species",];

var arrFilterSelected = arrFilterTitle.map((e) {
  return false;
}).toList();

var arrFilterTFController = [TextEditingController(), TextEditingController(), TextEditingController(), ];

class FilterApp {
  static filterCharacters(context, {required Function() onApply, required Function() onCancel}) {

    print(arrFilterSelected);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      // isScrollControlled: true,
      isDismissible: true,
      useRootNavigator: true,
      // enableDrag: true,

      builder: (BuildContext contextShowDialog) {
        return StatefulBuilder(builder: (contextStateFulBuilder, setState) {
          return Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 30,
                bottom: 30,
              ),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  Expanded(child: ListView.separated(
                    key: const Key("listView"),
                    separatorBuilder: (context, index) {
                      return Container(
                        color: Colors.grey,
                        height: 1,
                      );
                    },
                    itemCount: arrFilterTitle.length,
                    itemBuilder: (context, index) {
                      return Container(
                        // height: 60,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(arrFilterTitle[index], style: TextStylesInter.textStyles_16,),
                                  IconButton(
                                    icon: Icon(arrFilterSelected[index] ? Icons.check_box : Icons.check_box_outline_blank),
                                    onPressed: () {
                                      print(index);

                                      for (int i = 0; i<arrFilterSelected.length; i++) {
                                        if (i==index) {
                                          arrFilterSelected[i] = !arrFilterSelected[i];
                                        }
                                      }

                                      print(arrFilterSelected);

                                      setState(() {});
                                    },
                                  )
                                ],
                              ),
                              // const SizedBox(height: 30,),
                              TextField(
                                controller: arrFilterTFController[index],
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.grey, width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.grey, width: 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.grey, width: 1)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.grey, width: 1)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.grey, width: 1)),
                                ),
                              )
                            ],
                          )
                      );
                    },
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        child: Text("Clear", style: TextStylesInter.textStyles_16,),
                        onPressed: onCancel,
                        // onPressed: () {
                        //   Navigator.pop(context);
                        //
                        //   arrFilterSelected = arrFilterSelected.map((e) {
                        //     return false;
                        //   }).toList();
                        // },
                      ),
                      ElevatedButton(
                        onPressed: onApply,
                        child: Text("Apply", style: TextStylesInter.textStyles_16,),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }
}