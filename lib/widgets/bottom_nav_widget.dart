import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petmo/widgets/speed_dial_nav_widget.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        floatingActionButton: SpeedDialNavWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // bottomNavigationBar: BottomAppBar(
        //     color: PrimaryAccentColor,
        //     shape: const CircularNotchedRectangle(),
        //     notchMargin: 5,
        //     child: Row(
        //       mainAxisSize: MainAxisSize.max,
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         IconButton(
        //           icon: const Icon(
        //             Icons.scatter_plot_outlined,
        //             color: LightAccentColor,
        //           ),
        //           onPressed: () => {
        //             Navigator.pushNamed(context, PetDetailScreenRoute,
        //                 arguments: {'pet': pet}),
        //           },
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.only(right: 90),
        //           child: IconButton(
        //             icon: const Icon(
        //               Icons.people,
        //               color: Colors.white,
        //             ),
        //             onPressed: () {},
        //           ),
        //         )
        //       ],
        //     )
        // ),
      );
}
