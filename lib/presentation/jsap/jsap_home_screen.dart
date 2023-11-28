import 'package:cooking_recipe_app/presentation/jsap/widget/demand_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class JsapHomeScreen extends StatelessWidget {
  const JsapHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jardiners S.A.P."),
        actions: const [Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: FaIcon(FontAwesomeIcons.bell)),
        )],
      ),
      body: Column(
        children: [
          // Filter bar
          const Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FaIcon(FontAwesomeIcons.filter),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.5),
                  child: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        Material(
                          elevation: 10,
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            topLeft: Radius.circular(18),
                          ),
                          child: SizedBox(
                            width: 50,
                            child: Center(
                                child: FaIcon(
                              FontAwesomeIcons.map,
                            )),
                          ),
                        ),
                        Material(
                          elevation: 10,
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(18),
                            topRight: Radius.circular(18),
                          ),
                          child: SizedBox(
                            width: 50,
                            child: Center(
                              child: FaIcon(FontAwesomeIcons.bars,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FaIcon(FontAwesomeIcons.sort),
              ],
            ),
          ),
          Expanded(
            flex: 12,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(3.5),
                child: DemandWidget(
                  isNewDemand: !(index % 4 == 3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
