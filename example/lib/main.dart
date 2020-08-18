import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:drag_and_drop_gridview/drag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _imageUris = [
    "https://images.pexels.com/photos/4466054/pexels-photo-4466054.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    "https://images.pexels.com/photos/4561739/pexels-photo-4561739.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/4507967/pexels-photo-4507967.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/4321194/pexels-photo-4321194.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/1053924/pexels-photo-1053924.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/1624438/pexels-photo-1624438.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/1144687/pexels-photo-1144687.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/2589010/pexels-photo-2589010.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
  ];

  int variableSet = 0,variableSetHeader = 0;
  ScrollController _scrollController;
  double width;
  double height;
  double widthHeader;
  double heightHeader;
  List<String> listOfHeader = ["1","2"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('DragAndDropGridView'),
        ),
        body: Center(
          child: DragAndDropGridView.stickyHeader(
            itemBuilderHeader: (context, pos) => Card(
              elevation: 2,
              child: LayoutBuilder(builder: (context, costrains) {
                if (variableSet == 0) {
                  heightHeader = costrains.maxHeight;
                  widthHeader = costrains.maxWidth;
                  variableSetHeader++;
                }
                return Container(
                  height: heightHeader,
                  width: widthHeader,
                  alignment: Alignment.center,
                  child: Text(
                    "${listOfHeader[pos]}",
                    textAlign: TextAlign.center,
                  ),
                );
              }),
            ),
            headerItemCount: 2,
            headerPadding: EdgeInsets.all(20),
            headerGridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.8,
            ),
            onReorderHeader: (oldIndex, newIndex) {
              var temp = listOfHeader[oldIndex];
              listOfHeader[oldIndex] = listOfHeader[newIndex];
              listOfHeader[newIndex] = temp;
              setState(() {
                
              });
            },
            onWillAcceptHeader: (oldIndex, newIndex) {
              return true;
            },
            controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4.5,
            ),
            padding: EdgeInsets.all(20),
            itemBuilder: (context, index) => DragItem(
              child: Card(
                elevation: 2,
                child: LayoutBuilder(builder: (context, costrains) {
                  if (variableSet == 0) {
                    height = costrains.maxHeight;
                    width = costrains.maxWidth;
                    variableSet++;
                  }
                  return GridTile(
                    key: index == 4 ? Key("12") : null,
                    child: Image.network(
                      _imageUris[index],
                      height: height,
                      width: width,
                    ),
                  );
                }),
              ),
            ),
            itemCount: _imageUris.length,
            onWillAccept: (oldIndex, newIndex) => true,
            onReorder: (oldIndex, newIndex) {
              int indexOfFirstItem = _imageUris.indexOf(_imageUris[oldIndex]);
              int indexOfSecondItem = _imageUris.indexOf(_imageUris[newIndex]);

              if (indexOfFirstItem > indexOfSecondItem) {
                for (int i = _imageUris.indexOf(_imageUris[oldIndex]);
                    i > _imageUris.indexOf(_imageUris[newIndex]);
                    i--) {
                  var tmp = _imageUris[i - 1];
                  _imageUris[i - 1] = _imageUris[i];
                  _imageUris[i] = tmp;
                }
              } else {
                for (int i = _imageUris.indexOf(_imageUris[oldIndex]);
                    i < _imageUris.indexOf(_imageUris[newIndex]);
                    i++) {
                  var tmp = _imageUris[i + 1];
                  _imageUris[i + 1] = _imageUris[i];
                  _imageUris[i] = tmp;
                }
              }
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
