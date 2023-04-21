import 'package:flutter/material.dart';
import 'package:photo_just_for_fun/utils/permanent_functions.dart';

class AnimatedAppBar extends StatefulWidget {
  final ScrollController scrollController;

  const AnimatedAppBar({Key? key, required this.scrollController})
      : super(key: key);

  @override
  State<AnimatedAppBar> createState() => _AnimatedAppBarState();
}

class _AnimatedAppBarState extends State<AnimatedAppBar> {
  Color appBarColor = Colors.transparent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.scrollController.addListener(() {
      setColorToAppBar();
    });
  }

  void setColorToAppBar() {
    appBarColor =
        PermanentFunctions.appBarTransitionColor(widget.scrollController);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        color: appBarColor,
        width: double.maxFinite,
        padding: const EdgeInsets.only(top: 25, right: 10, left: 10, bottom: 5),
        child: Row(
          children: [
            Expanded(
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) =>
                                    Colors.grey[100]!),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)))),
                    onPressed: () {},
                    child: Row(children: [
                      const SizedBox(width: 8),
                      Icon(Icons.search, color: Colors.grey[500], size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Search Product',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.normal),
                      )
                    ]))),
            SizedBox(width: 15),
            IconButton(
                padding: const EdgeInsets.all(0),
                constraints: const BoxConstraints(),
                icon: Icon(Icons.person),
                onPressed: () {}),
          ],
        ));
  }
}
