import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageGridItem extends StatefulWidget {
  int? _index;
  int? _currentUnit;

  ImageGridItem(int index, int currentUnit) {
    this._index = index;
    this._currentUnit = currentUnit;
  }

  @override
  _ImageGridItemState createState() => _ImageGridItemState();
}

class _ImageGridItemState extends State<ImageGridItem> {
  Reference refImage = FirebaseStorage.instance.ref().child('cover');
  Reference refPdf = FirebaseStorage.instance.ref().child('pdfs');
  Uint8List? imageFile;
  String? pdfUrl;

  @override
  void initState() {
    super.initState();
    getImage();
  }

  getImage() {
    int MAX_SIZE = 1 * 1024 * 1024;
    print(widget._index);
    refImage.child('/capa${widget._index}.png').getData(MAX_SIZE).then((value) =>
    {
      this.setState(() {
        imageFile = value;
      })
    }).catchError((error) {

    });
    refPdf.child('/livro_${widget._index}.pdf').getDownloadURL().then((value) =>
    {
      this.setState(() {
        pdfUrl = value.toString();
      })
    }).catchError((error){

    });
  }

  Widget decideGridTileWidget() {
    if (imageFile == null) {
      return Center(child: CircularProgressIndicator(
        valueColor:
        AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 3.0,
      ));
    } else {
      return ColorFiltered(
          colorFilter: ColorFilter.mode(
              widget._index! <= widget._currentUnit! ? Colors.lightBlue : Colors
                  .black, BlendMode.saturation),
          child: IconButton(onPressed: () {
           if(widget._index! <= widget._currentUnit!){
             _launchInBrowser(pdfUrl!);
           }
          }, icon: Image.memory(imageFile!))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(child: decideGridTileWidget(),);
  }
}

Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } else {
    throw 'Could not launch $url';
  }
}