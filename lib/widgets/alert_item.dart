import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:pole_paris_app/screens/alerts.dart';
import 'package:pole_paris_app/styles/color.dart';

class AlertItem extends StatefulWidget {
  final Alert alert;
  const AlertItem({super.key, required this.alert});

  @override
  State<AlertItem> createState() => _AlertItemState();
}

class _AlertItemState extends State<AlertItem> with TickerProviderStateMixin {
  double turns = 0.0;

  _showDetails() {
    setState(() {
      turns = turns > 0 ? 0.0 : 0.25;
    });

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (context) => Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 35, right: 35, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Container(
                    width: 62,
                    height: 4,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFC4C4C4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.50),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  widget.alert.title,
                  style: const TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontSize: 16,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SingleChildScrollView(
                    child: Html(
                      data: widget.alert.htmlContent,
                      extensions: [
                        TagExtension(tagsToExtend: {"br"}, child: Container())
                      ],
                      style: {
                        "body": Style(
                          margin: Margins.zero,
                          padding: HtmlPaddings.zero,
                        ),
                        "div": Style(
                          color: const Color(0xFF404040),
                          fontSize: FontSize(16),
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w500,
                        ),
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).then((value) {
      setState(() {
        turns = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(widget.alert),
      background: Container(
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
            color: CustomColors.error, borderRadius: BorderRadius.circular(10)),
        child: const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(
            Icons.delete_outline_rounded,
            size: 30,
          ),
        ),
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: _showDetails,
        child: Container(
          height: 110,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.alert.title,
                  style: const TextStyle(
                    color: Color(0xFF404040),
                    fontSize: 16,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        widget.alert.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF828282),
                          fontSize: 16,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: AnimatedRotation(
                        turns: turns,
                        duration: const Duration(milliseconds: 100),
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
