
  

# drag_and_drop_gridview
[![pub package](https://img.shields.io/pub/v/drag_and_drop_gridview?style=plastic)](https://pub.dartlang.org/packages/drag_and_drop_gridview)
[![Awesome Flutter](https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square)](https://github.com/Solido/awesome-flutter)
[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-yellow.svg)](https://www.buymeacoffee.com/devorbiter) 
Drag And Drop GridView extends the functionality of the GridView widget in Flutter and gives you the freedom of creating a reorder the GridViewItems simple by Drag And Drop. It is super easy to implement and beautiful to use.

If you appreciate the content 📖, support projects visibility, give 👍| ⭐| 👏


## Usage
To use this [package](https://pub.dev/packages/drag_and_drop_gridview), add `drag_and_drop_gridview` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).
```
dependencies:
  drag_and_drop_gridview: ^1.0.4
```
And import the package in your code.
``` dart
import 'package:drag_and_drop_gridview/devdrag.dart';
```
## Examples


<p>
<img src="https://github.com/DevOrbiter/drag_and_drop_gridview/blob/master/example/gifs/drag_and_drop_grid.gif?raw=true" width="180" title="DragAndDropGridView">
<img src="https://github.com/DevOrbiter/drag_and_drop_gridview/blob/master/example/gifs/drag_drop_reorderable.gif?raw=true" width="180" title="ReorderableDragAndDropGridView">
<img src="https://github.com/DevOrbiter/drag_and_drop_gridview/blob/master/example/gifs/reorderablehover.gif?raw=true" width="180" title="ReorderableDragAndDropGridView">
</p>

### Overview

DragAndDropGridView has the all same parameters that GridView.builder [constructor]([https://api.flutter.dev/flutter/widgets/GridView/GridView.builder.html](https://api.flutter.dev/flutter/widgets/GridView/GridView.builder.html)) has. 

But in DragAndDropGridView there are some required params `gridDelegate`, `itemBuilder`, `onWillAccept`, and `onReorder`.

#### gridDelegate 
This is the same as we find it in the official gridview of Flutter. [Learn More]([https://api.flutter.dev/flutter/widgets/GridView/gridDelegate.html](https://api.flutter.dev/flutter/widgets/GridView/gridDelegate.html))
```dart
gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4.5,
     ),
```
#### itemBuilder
This is the same as we find it in the official gridview of Flutter. [Learn More]([https://api.flutter.dev/flutter/widgets/GridView/GridView.builder.html](https://api.flutter.dev/flutter/widgets/GridView/GridView.builder.html))
```dart
itemBuilder: (context, index) => Card(
       elevation: 2,
       child: Text(_animals[index]),
),
```
#### onWillAccept
This funciton allows you to validate if you want to accept the change in the order of the gridViewItems. If you always want to accept the change simply `return true`
```dart
// _animals = ['cat','dog','kitten','puppy']

onWillAccept: (oldIndex, newIndex) {
// Implement you own logic

// Example reject the reorder if the moving item's value is "kitten" 
if (_animals[newIndex] == "cat"){
	return false;
}
return true, // If you want to accept the child return true or else return false
},
```
#### onReorder
This function deals with changing the index of the newly arranged gridItems.
```dart
onReorder: (oldIndex, newIndex) {
	    _temp = _animals[newIndex];
        _animals[newIndex] = _animals[oldIndex];
        _animals[oldIndex] = _temp;
        setState(() {});
},
```
#### Example
```dart
 _animals = ['cat','dog','kitten','puppy']
 
DragAndDropGridView(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4.5,
    ),
    padding: EdgeInsets.all(20),
    itemBuilder: (context, index) => Card(
        elevation: 2,
        child: Text(_animals[index]),
		),
    ),
    itemCount: _animals.length,
    onWillAccept: (oldIndex, newIndex) {
		// Implement you own logic

		// Example reject the reorder if the moving item's value is "kitten" 
		if (_animals[newIndex] == "cat"){
			return false;
		}
		return true, // If you want to accept the child return true or else return false
	},
    onReorder: (oldIndex, newIndex) {
	    _temp = _imageUris[newIndex];
        _imageUris[newIndex] = _imageUris[oldIndex];
        _imageUris[oldIndex] = _temp;
        setState(() {});
    },
)
```
---
### Examples #1 : DragAndDropGridView
Below example shows you how to implement `DragAndDropGridView` easily.

``` dart
import 'package:drag_and_drop_gridview/devdrag.dart';
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

  int variableSet = 0;
  ScrollController _scrollController;
  double width;
  double height;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Drag And drop Plugin'),
        ),
        body: Center(
          child: DragAndDropGridView(
            controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4.5,
            ),
            padding: EdgeInsets.all(20),
            itemBuilder: (context, index) => Card(
              elevation: 2,
              child: LayoutBuilder(
                builder: (context, costrains) {
                  if (variableSet == 0) {
                    height = costrains.maxHeight;
                    width = costrains.maxWidth;
                    variableSet++;
                  }
                  return GridTile(
                    child: Image.network(
                      _imageUris[index],
                      fit: BoxFit.cover,
                      height: height,
                      width: width,
                    ),
                  );
                },
              ),
            ),
            itemCount: _imageUris.length,
            onWillAccept: (oldIndex, newIndex) {
              // Implement you own logic

              // Example reject the reorder if the moving item's value is something specific
              if (_imageUris[newIndex] == "something") {
                return false;
              }
              return true; // If you want to accept the child return true or else return false
            },
            onReorder: (oldIndex, newIndex) {
              final temp = _imageUris[oldIndex];
              _imageUris[oldIndex] = _imageUris[newIndex];
              _imageUris[newIndex] = temp;

              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}


```
#### Result:
<img src="https://github.com/DevOrbiter/drag_and_drop_gridview/blob/master/example/gifs/drag_and_drop_grid.gif?raw=true" width="240" title="DragAndDropGridView">
---

### Example #2 : DragAndDropGridView (Reorderable)

This is the example of how you can achive the **Reorderable / Re-Indexing** feature in DragAndDropGridView.

``` dart
import 'package:drag_and_drop_gridview/devdrag.dart';
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

  int variableSet = 0;
  ScrollController _scrollController;
  double width;
  double height;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Drag And drop Plugging'),
        ),
        body: Center(
          child: DragAndDropGridView(
            controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4.5,
            ),
            padding: EdgeInsets.all(20),
            itemBuilder: (context, index) => Card(
              elevation: 2,
              child: LayoutBuilder(builder: (context, costrains) {
                if (variableSet == 0) {
                  height = costrains.maxHeight;
                  width = costrains.maxWidth;
                  variableSet++;
                }
                return GridTile(
                  child: Image.network(
                    _imageUris[index],
                    fit: BoxFit.cover,
                    height: height,
                    width: width,
                  ),
                );
              }),
            ),
            itemCount: _imageUris.length,
            onWillAccept: (oldIndex, newIndex) => true,
            onReorder: (oldIndex, newIndex) {
            
              // You can also implement on your own logic on reorderable
              
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

```

#### Result
<img src="https://github.com/DevOrbiter/drag_and_drop_gridview/blob/master/example/gifs/drag_drop_reorderable.gif?raw=true" width="240" title="ReorderableDragAndDropGridView">

---

### DragAndDropGridView with hover effect (Reorderable)

This is the example of how you can achive the **Reordering Effect While Hovering Over A Specific Index** feature in DragAndDropGridView.

```dart

import 'package:drag_and_drop_gridview/devdrag.dart';
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
 
 int pos;
 
 List<String> tmpList;
 int variableSet = 0;
 ScrollController _scrollController;
 double width;
 double height;
 
 @override
 void initState() {
   tmpList = [..._imageUris];
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
         child: DragAndDropGridView(
           controller: _scrollController,
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 2,
             childAspectRatio: 3 / 4.5,
           ),
           padding: EdgeInsets.all(20),
           itemBuilder: (context, index) => Opacity(
             opacity: pos != null ? pos == index ? 0.6 : 1 : 1,
             child: Card(
               elevation: 2,
               child: LayoutBuilder(builder: (context, costrains) {
                 if (variableSet == 0) {
                   height = costrains.maxHeight;
                   width = costrains.maxWidth;
                   variableSet++;
                 }
                 return GridTile(
                   child: Image.network(
                     _imageUris[index],
                     fit: BoxFit.cover,
                     height: height,
                     width: width,
                   ),
                 );
               }),
             ),
           ),
           itemCount: _imageUris.length,
           onWillAccept: (oldIndex, newIndex) {
             _imageUris = [...tmpList];
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
 
             setState(
               () {
                 pos = newIndex;
               },
             );
             return true;
           },
           onReorder: (oldIndex, newIndex) {
             _imageUris = [...tmpList];
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
             tmpList = [..._imageUris];
             setState(
               () {
                 pos = null;
               },
             );
           },
         ),
       ),
     ),
   );
 }
}


```

#### Result
<img src="https://github.com/DevOrbiter/drag_and_drop_gridview/blob/master/example/gifs/reorderablehover.gif?raw=true" width="240" title="ReorderableDragAndDropGridViewHover">

---


#### DragAndDropGridView change child

You can change the child by set the `isCustomChildWhenDragging` to true and return your child to this parameter `childWhenDragging`.

```dart

import 'package:drag_and_drop_gridview/devdrag.dart';
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
 
 int variableSet = 0;
 ScrollController _scrollController;
 double width;
 double height;
 
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
         child: DragAndDropGridView(
           controller: _scrollController,
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 2,
             childAspectRatio: 3 / 4.5,
           ),
           padding: EdgeInsets.all(20),
           itemBuilder: (context, index) => Card(
             elevation: 2,
             child: LayoutBuilder(builder: (context, costrains) {
               if (variableSet == 0) {
                 height = costrains.maxHeight;
                 width = costrains.maxWidth;
                 variableSet++;
               }
               return GridTile(
                 child: Image.network(
                   _imageUris[index],
                   height: height,
                   width: width,
                 ),
               );
             }),
           ),
           isCustomChildWhenDragging: true,
           childWhenDragging: (pos) => Image.asset(
             "gifs/draganddropbg.jpg",
             height: height,
             width: width,
           ),
           itemCount: _imageUris.length,
           onWillAccept: (oldIndex, newIndex) => true,
           onReorder: (oldIndex, newIndex) {
             final temp = _imageUris[oldIndex];
             _imageUris[oldIndex] = _imageUris[newIndex];
             _imageUris[newIndex] = temp;
 
             setState(() {});
           },
         ),
       ),
     ),
   );
 }
}


```


#### Result
<img src="https://github.com/DevOrbiter/drag_and_drop_gridview/blob/master/example/gifs/childwhendrag.gif?raw=true" width="240" title="ReorderableDragAndDropGridViewChildChange">

---
#### DragAndDropGridView change feedback

You can change the child by set the `isCustomFeedback` to true and return your child to this parameter `feedback`.

```dart

import 'package:drag_and_drop_gridview/devdrag.dart';
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
 
 int variableSet = 0;
 ScrollController _scrollController;
 double width;
 double height;
 
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
         child: DragAndDropGridView(
           controller: _scrollController,
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 2,
             childAspectRatio: 3 / 4.5,
           ),
           padding: EdgeInsets.all(20),
           itemBuilder: (context, index) => Card(
             elevation: 2,
             child: LayoutBuilder(builder: (context, costrains) {
               if (variableSet == 0) {
                 height = costrains.maxHeight;
                 width = costrains.maxWidth;
                 variableSet++;
               }
               return GridTile(
                 child: Image.network(
                   _imageUris[index],
                   height: height,
                   width: width,
                 ),
               );
             }),
           ),
           isCustomFeedback: true,
           feedback: (pos) => Image.asset(
             "gifs/draganddropbg.jpg",
             height: height,
             width: width,
           ),
           itemCount: _imageUris.length,
           onWillAccept: (oldIndex, newIndex) => true,
           onReorder: (oldIndex, newIndex) {
             final temp = _imageUris[oldIndex];
             _imageUris[oldIndex] = _imageUris[newIndex];
             _imageUris[newIndex] = temp;
 
             setState(() {});
           },
         ),
       ),
     ),
   );
 }
}


```

#### Result
<img src="https://github.com/DevOrbiter/drag_and_drop_gridview/blob/master/example/gifs/childfeedback.gif?raw=true" width="240" title="ReorderableDragAndDropGridViewFeedbackChange">


## Support

You can also support us by buying coffee.
Your support is very much appreciated. :)

[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-yellow.svg)](https://www.buymeacoffee.com/devorbiter)