import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeId='/edit_product_screen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imgUrlFocusNode= FocusNode();
  final _imgUrlController= TextEditingController();

  //-----to clean off the unwanted widgets---
  @override
  void dispose() {
      _descFocusNode.dispose();
      _priceFocusNode.dispose();
      _imgUrlFocusNode.dispose();
      _imgUrlController.dispose();
      super.dispose();
  }

  //---- the first function called when the screen is created---
  @override
  void initState() {
    // TODO: implement initState
    _imgUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  //----to update image on container after user enter new image url---
  void _updateImageUrl(){
    if(!_imgUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText:'Title',),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText:'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_descFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText:'Description'),
                focusNode: _descFocusNode,
                maxLines: 3,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_imgUrlFocusNode);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 90,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),),
                    child: _imgUrlController.text.isEmpty
                        ? Text("Enter a url")
                        :FittedBox(
                             child: Image.network(_imgUrlController.text),
                             fit: BoxFit.cover,) ,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image Url',),
                      focusNode: _imgUrlFocusNode,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imgUrlController,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
