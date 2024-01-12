import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class DemandButton extends StatelessWidget {
  const DemandButton(
      {Key? key,
      this.isBlack = true,
      this.icon,
      required this.label,
      this.onTap,
      this.isBackgroundBlack = false})
      : super(key: key);
  final bool isBlack;
  final bool isBackgroundBlack;
  final IconData? icon;
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isBackgroundBlack
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 2.5, color: Colors.white)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                      
                  child: (icon != null)? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: FaIcon(
                            icon,
                            color: Colors.white,
                          ),
                        ),
                      Text(
                        label,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ) : Text(
                        label,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                ),
              ),
            )
          : isBlack
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffAB5F1C),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child:
                           (icon != null)?
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                            FaIcon(
                              icon,
                              color: Colors.white,
                            ),
                          Text(
                            label,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ): Text(
                            label,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                    ),
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 2.5)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: (icon != null)? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Padding(
                             padding: const EdgeInsets.only(right: 10.0),
                             child: FaIcon(icon),
                           ),
                          Text(
                            label,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ) : Center(
                        child: Text(
                              label,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      ),
                    ),
                  ),
                ),
    );
  }
}
