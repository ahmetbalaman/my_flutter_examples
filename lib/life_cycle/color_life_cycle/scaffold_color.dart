import 'package:flutter/material.dart';

class ColorPage extends StatefulWidget {
  const ColorPage({super.key, this.renk});
  final Color? renk;
  @override
  State<ColorPage> createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  Color? initalColor;
  @override
  void initState() {
    initalColor = widget.renk;
    super.initState();
  }

//çağırdığımız widgeti ilk haliyle çağırıp sonradan değişiklik yaptığımızda bunu görmezden geliyor
//bunun önüne geçmek için bu widget değişti mi kontrolü yapmalıyız.
  @override
  void didUpdateWidget(covariant ColorPage oldWidget) {
    if (oldWidget.renk != widget.renk && widget.renk != null) {
      setState(() {
        initalColor = widget.renk!;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: initalColor,
      ),
    );
  }
}
