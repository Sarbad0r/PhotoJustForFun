import 'package:flutter/material.dart';
import 'package:photo_just_for_fun/models/photo_models/photo_model.dart';
import 'package:photo_just_for_fun/widgets/cache_network_image_widget.dart';
import 'package:photo_just_for_fun/widgets/text_widget.dart';

class PhotoHomePageWidget extends StatefulWidget {
  final PhotoModel photoModel;

  const PhotoHomePageWidget({Key? key, required this.photoModel})
      : super(key: key);

  @override
  State<PhotoHomePageWidget> createState() => _PhotoHomePageWidgetState();
}

class _PhotoHomePageWidgetState extends State<PhotoHomePageWidget> {
  bool tap = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (details) => setState(() {
        tap = true;
      }),
      onPointerUp: (details) => setState(() {
        tap = false;
      }),
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          margin: tap ? EdgeInsets.all(5) : EdgeInsets.only(left: 3,right: 3),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border:  tap ? Border.all(color: Colors.grey[300]!) : null,
              boxShadow: tap
                  ? []
                  : [
                      BoxShadow(
                          spreadRadius: 2,
                          offset: const Offset(1, 2),
                          color: Colors.grey[300]!,
                          blurRadius: 3),
                      BoxShadow(
                          spreadRadius: 2,
                          offset: const Offset(-0.2, -0.3),
                          color: Colors.grey[300]!,
                          blurRadius: 1)
                    ]),
          child: GestureDetector(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // CachedNetworkImageWidget(
              //     height: 250,
              //     width: double.maxFinite,
              //     url: photoModel.photoSrc?.large ?? ''),
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  child: CachedNetworkImageWidget(
                      height: 250,
                      width: double.infinity,
                      url: widget.photoModel.photoSrc?.large ?? '')),
              const SizedBox(height: 20),
              Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                            text: widget.photoModel.photographer ?? '',
                            fontWeight: FontWeight.bold,
                            size: 16),
                        TextWidget(text: widget.photoModel.alt ?? ''),
                        const SizedBox(height: 10)
                      ]))
            ]),
          )),
    );
  }
}
