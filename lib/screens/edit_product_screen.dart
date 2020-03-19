import 'package:epasal/provider/product.dart';
import 'package:epasal/provider/products_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final _form =GlobalKey<FormState>();
  bool _isloading= false;
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imgUrl: '',
  );

  bool isInit = true;

  var initValue={
    'title':'',
    'price':'',
    'description':'',
    'imgUrl':'',
  };

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

  //--- The first time to for initializing values-----
  @override
  void didChangeDependencies() {
    if(isInit) {
      final String productId = ModalRoute
          .of(context)
          .settings
          .arguments;
      if(productId!=null){
        _editedProduct = Provider.of<Products>(context).findById(productId);
        initValue={
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'description':_editedProduct.description,
          'imgUrl':'',
        };
        _imgUrlController.text= _editedProduct.imgUrl;
      }
    }
    isInit=false;
    super.didChangeDependencies();

  }

  //----to update image on container after user enter new image url---
  void _updateImageUrl(){
    if(!_imgUrlFocusNode.hasFocus) {
      if ((!_imgUrlController.text.startsWith('http')
          &&!_imgUrlController.text.startsWith('https'))||
        (!_imgUrlController.text.endsWith('.jpg')
            &&!_imgUrlController.text.endsWith('.jpeg')
            &&!_imgUrlController.text.endsWith('.JPG')
          &&!_imgUrlController.text.endsWith('.JPEG')
            &&!_imgUrlController.text.endsWith('.png'))){
        return;
      }
      setState(() {});
    }
  }

  //------ To save product-----
  void _saveForm(){
    final isValid = _form.currentState.validate();
    if(!isValid){
      return;
    }
    _form.currentState.save();
    setState(() {
      _isloading=true;
    });
    if(_editedProduct.id!=null){
      Provider.of<Products>(context, listen: false).updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isloading=false;
      });
    }
    else{
      Provider.of<Products>(context,listen: false).addProduct(_editedProduct)
          .catchError((error){
           return showDialog(context: context, builder: (ctx)=> AlertDialog(
              title: Text('Error Occured'),
              content: Text('Unable to add product'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: (){
                    setState(() {
                      _isloading=false;
                    });
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            ));

      })
          .then((_){
        setState(() {
          _isloading=false;
        });
        Navigator.pop(context);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: (){
                _saveForm();
            },
          )
        ],

      ),
      body: _isloading
          ? Center(
            child: CircularProgressIndicator(),
          )
      :Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: initValue['title'],
                decoration: InputDecoration(labelText:'Title',),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value){
                  if (value.isEmpty){
                    return 'The title should not be empty!';
                  }
                  return null;
                },
                onSaved: (value){
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: value.trim(),
                    price: _editedProduct.price,
                    description: _editedProduct.description,
                    imgUrl: _editedProduct.imgUrl
                  );
                },
              ),
              TextFormField(
                initialValue: initValue['price'],
                decoration: InputDecoration(labelText:'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_descFocusNode);
                },
                validator: (value){
                  if(value.isEmpty){
                    return 'The title mmust not be empty!';
                  }
                  if (double.tryParse(value) ==null){
                    return 'The price should be in a number format';
                  }
                  if(double.parse(value)<=0){
                    return 'Price should be greater than zero ';
                  }
                  return null;
                },
                onSaved: (value){
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      price: double.parse(value),
                      description: _editedProduct.description,
                      imgUrl: _editedProduct.imgUrl
                  );
                },
              ),
              TextFormField(
                initialValue: initValue['description'],
                decoration: InputDecoration(labelText:'Description'),
                focusNode: _descFocusNode,
                maxLines: 3,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_imgUrlFocusNode);
                },
                validator: (value){
                  if (value.isEmpty){
                    return'The description must be filled';
                  }
                  if (value.length<10){
                    return 'The description must not be less than 10 characters. ';
                  }
                  return null;
                },
                onSaved: (value){
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      price: _editedProduct.price,
                      description: value.trim(),
                      imgUrl: _editedProduct.imgUrl
                  );
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

                      validator: (value){
                        if(value.isEmpty){
                          return 'The Image url must be filled';
                        }
                        if (!value.startsWith('http')&&!value.startsWith('https')){
                          return 'Please enter a valid URL';
                        }
                        if (!value.endsWith('.jpg') &&!value.endsWith('.jpeg') &&!value.endsWith('.JPG')
                            &&!value.endsWith('.JPEG') &&!value.endsWith('.png')){
                          return 'Please enter a valid URL';
                        }
                        return null;
                        },

                      onSaved: (value){
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            price: _editedProduct.price,
                            description: _editedProduct.description,
                            imgUrl: value.trim(),
                        );
                      },

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
