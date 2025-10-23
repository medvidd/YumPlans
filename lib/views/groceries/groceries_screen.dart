import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/groceries_vm.dart';


class GroceriesScreen extends StatelessWidget {
  const GroceriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroceriesViewModel>(
      create: (_) => GroceriesViewModel(),
      child: Consumer<GroceriesViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFBF0),
            body: Container(
              width: 412,
              height: 892,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Color(0xFFFFFBF0)),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 412,
                      height: 79,
                      decoration: const BoxDecoration(color: Color(0xFFABBA72)),
                      child: const Center(
                        child: Text(
                          'GROCERY LIST',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF4B572B),
                            fontSize: 36,
                            fontFamily: 'Kantumruy Pro',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 29,
                    top: 119,
                    child: Container(
                      width: 353,
                      height: 42,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: vm.selectShoppingList,
                              child: Container(
                                decoration: ShapeDecoration(
                                  color: vm.isShoppingListActive ? const Color(0xFF4B572B) : const Color(0x56ABBA72),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1, color: vm.isShoppingListActive ? Color(0xFF4B572B) : const Color(0xFF4B572B)),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Center(
                                  child: Text('Shopping List', style: TextStyle(color: vm.isShoppingListActive ? Colors.white : const Color(0xFF4B572B), fontSize: 16, fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: vm.selectGroceries,
                              child: Container(
                                decoration: ShapeDecoration(
                                  color: !vm.isShoppingListActive ? const Color(0xFF4B572B) : const Color(0x56ABBA72),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1, color: !vm.isShoppingListActive ? Colors.white : const Color(0xFF4B572B)),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Center(
                                  child: Text('Groceries', style: TextStyle(color: !vm.isShoppingListActive ? Colors.white : const Color(0xFF4B572B), fontSize: 16, fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (vm.isShoppingListActive)
                    Positioned(
                      top: 185,
                      left: 21,
                      right: 21,
                      bottom: 540,
                      child: Container(
                        width: 370,
                        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 22),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFFFBF0),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0x59DF6149),
                            ),
                            borderRadius: BorderRadius.circular(27),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/clock.svg',
                                      width: 20,
                                      height: 20,
                                      colorFilter: const ColorFilter.mode(
                                        Color(0xFFDF6149),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    const SizedBox(width: 11),
                                    const Text(
                                      'Items to buy : 0',
                                      style: TextStyle(
                                        color: Color(0xFFDF6149),
                                        fontSize: 16,
                                        fontFamily: 'Kantumruy Pro',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: SvgPicture.asset(
                                        'assets/images/edit_icon.svg',
                                        width: 27,
                                        height: 27,
                                        colorFilter: const ColorFilter.mode(
                                          Color(0xFF4B572B),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: SvgPicture.asset(
                                        'assets/images/add_circle.svg',
                                        width: 30,
                                        height: 30,
                                        colorFilter: const ColorFilter.mode(
                                          Color(0xFF4B572B),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(color: Color(0xFF708240), height: 1),
                            const SizedBox(height: 20),
                            const Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 4),
                                Text(
                                  'Shopping list is empty',
                                  style: TextStyle(
                                    color: Color(0xFF981800),
                                    fontSize: 16,
                                    fontFamily: 'Kantumruy Pro',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                  if (!vm.isShoppingListActive)
                    Positioned(
                      top: 185,
                      left: 21,
                      right: 21,
                      bottom: 630,
                      child: Container(
                        width: 370,
                        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 22),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFFFBF0),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0x59DF6149),
                            ),
                            borderRadius: BorderRadius.circular(27),
                          ),
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 4),
                            Text(
                              'No recipes found to get ingredients',
                              style: TextStyle(
                                color: Color(0xFF981800),
                                fontSize: 16,
                                fontFamily: 'Kantumruy Pro',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Positioned(
                    left: 0,
                    top: 825,
                    child: Container(
                      width: 412,
                      height: 67,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                      decoration: const BoxDecoration(color: Color(0xFFFFFBF0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => vm.onItemTapped(context, 0),
                            child: Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: ShapeDecoration(
                                color: vm.selectedIndex == 0 ? const Color(0xFFFEDC7B) : const Color(0xFFE9E9E9),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: vm.selectedIndex == 0 ? Colors.transparent : const Color(0x2B909090),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: SvgPicture.asset(
                                'assets/images/home.svg',
                                width: 30,
                                height: 30,
                                colorFilter: const ColorFilter.mode(Color(0xFF8A8A8A), BlendMode.srcIn),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => vm.onItemTapped(context, 1),
                            child: Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: ShapeDecoration(
                                color: vm.selectedIndex == 1 ? const Color(0xFFFEDC7B) : const Color(0xFFE9E9E9),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: vm.selectedIndex == 1 ? Colors.transparent : const Color(0x2B909090),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: SvgPicture.asset(
                                'assets/images/calendar.svg',
                                width: 30,
                                height: 30,
                                colorFilter: const ColorFilter.mode(Color(0xFF8A8A8A), BlendMode.srcIn),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => vm.onItemTapped(context, 2),
                            child: Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: ShapeDecoration(
                                color: vm.selectedIndex == 2 ? const Color(0xFFFEDC7B) : const Color(0xFFE9E9E9),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: vm.selectedIndex == 2 ? Colors.transparent : const Color(0x2B909090),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: SvgPicture.asset(
                                'assets/images/list.svg',
                                width: 25,
                                height: 25,
                                colorFilter: const ColorFilter.mode(Color(0xFFA4801A), BlendMode.srcIn),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => vm.onItemTapped(context, 3),
                            child: Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: ShapeDecoration(
                                color: vm.selectedIndex == 3 ? const Color(0xFFFEDC7B) : const Color(0xFFE9E9E9),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: vm.selectedIndex == 3 ? Colors.transparent : const Color(0x2B909090),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: SvgPicture.asset(
                                'assets/images/recipes.svg',
                                width: 35,
                                height: 35,
                                colorFilter: const ColorFilter.mode(Color(0xFF8A8A8A), BlendMode.srcIn),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => vm.onItemTapped(context, 4),
                            child: Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: ShapeDecoration(
                                color: vm.selectedIndex == 4 ? const Color(0xFFFEDC7B) : const Color(0xFFE9E9E9),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: vm.selectedIndex == 4 ? Colors.transparent : const Color(0x2B909090),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: SvgPicture.asset(
                                'assets/images/user.svg',
                                width: 30,
                                height: 30,
                                colorFilter: const ColorFilter.mode(Color(0xFF8A8A8A), BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
