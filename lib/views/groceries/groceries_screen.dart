import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '/viewmodels/groceries_vm.dart';
import '/widgets/bottom_nav_w.dart';
import '/widgets/common_app_bar_w.dart';
import '/models/grocery_model.dart';

// --- Елемент групи інгредієнтів (Groceries Tab) ---
class _GroceriesGroupItem extends StatelessWidget {
  final RecipeGroceryGroup group;
  final GroceriesViewModel vm;

  const _GroceriesGroupItem({required this.group, required this.vm});

  static const TextStyle _titleStyle = TextStyle(
    color: Color(0xFF9D3B29),
    fontSize: 16,
    fontFamily: 'Kantumruy Pro',
    fontWeight: FontWeight.w500,
  );
  static const TextStyle _itemStyle = TextStyle(
    color: Color(0xFF323C15),
    fontSize: 16,
    fontFamily: 'Kantumruy Pro',
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(group.recipeTitle, style: _titleStyle),
        const SizedBox(height: 8),

        const Divider(color: Color(0xFF8A8A8A), height: 1),
        const SizedBox(height: 12),

        Column(
          children: group.ingredients.map((ingredient) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            ingredient.name,
                            style: _itemStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        Text(' | ', style: _itemStyle.copyWith(fontWeight: FontWeight.w500)),

                        Expanded(
                          flex: 2,
                          child: Text(
                            ingredient.amount,
                            style: _itemStyle,
                            textAlign: TextAlign.right,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),

                  // ЗМІНЕНО: Додано InkWell для візуального ефекту натискання
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4B572B),
                      shape: BoxShape.circle,
                    ),
                    // Material потрібен для InkWell ефекту на кольоровому фоні
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        customBorder: const CircleBorder(), // Кругла форма хвилі
                        splashColor: Colors.white.withOpacity(0.3), // Колір ефекту
                        highlightColor: Colors.white.withOpacity(0.1),
                        onTap: () => vm.addIngredientToShoppingList(context, ingredient),
                        child: const Icon(Icons.add, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// --- Елемент списку покупок (Shopping List Tab) ---
class _ShoppingListItemWidget extends StatelessWidget {
  final ShoppingListItem item;
  final GroceriesViewModel vm;
  final bool isEditMode;

  const _ShoppingListItemWidget({
    required this.item,
    required this.vm,
    required this.isEditMode,
  });

  static const TextStyle _itemStyle = TextStyle(
    color: Color(0xFF323C15),
    fontSize: 16,
    fontFamily: 'Kantumruy Pro',
    fontWeight: FontWeight.w400,
  );
  static const TextStyle _checkedStyle = TextStyle(
    color: Color(0xFF8A8A8A),
    fontSize: 16,
    decoration: TextDecoration.lineThrough,
    fontFamily: 'Kantumruy Pro',
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    final style = item.isChecked ? _checkedStyle : _itemStyle;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: item.isChecked,
                    onChanged: isEditMode
                        ? null
                        : (_) => vm.toggleCheckedState(item.id),
                    activeColor: const Color(0xFF708240),
                    checkColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF4B572B), width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(item.name, style: style, maxLines: 2, overflow: TextOverflow.ellipsis),
                      ),
                      if (item.amount.isNotEmpty) ...[
                        Text(' | ', style: style.copyWith(fontWeight: FontWeight.w500)),
                        Expanded(
                          flex: 2,
                          child: Text(item.amount, style: style, textAlign: TextAlign.right, maxLines: 1),
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (isEditMode)
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: GestureDetector(
                onTap: () => vm.removeShoppingItem(item.id),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Color(0xFF981800),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}


// --- Головний екран Groceries ---
class GroceriesScreen extends StatelessWidget {
  const GroceriesScreen({super.key});

  static const double kTabletBreakpoint = 600.0;
  static const double kMaxContentWidth = 800.0;
  static const double kHorizontalPadding = 24.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isTablet = screenWidth > kTabletBreakpoint;

    return ChangeNotifierProvider<GroceriesViewModel>(
      create: (_) => GroceriesViewModel(),
      child: Consumer<GroceriesViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFBF0),

            appBar: CommonAppBar(
              title: 'GROCERY LIST',
              screenHeight: screenHeight,
              isTablet: isTablet,
            ),

            bottomNavigationBar: BottomNavWidget(
              selectedIndex: vm.selectedIndex,
              onItemSelected: (index) {
                vm.onItemTapped(context, index);
              },
            ),

            body: SafeArea(
              child: vm.isLoading
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFFABBA72)))
                  : Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kHorizontalPadding,
                          vertical: 20.0,
                        ),
                        child: _buildSegmentedControl(context, vm, isTablet),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                          child: vm.isShoppingListActive
                              ? _buildShoppingListContent(context, vm, isTablet)
                              : _buildGroceriesContent(context, vm, isTablet),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSegmentedControl(BuildContext context, GroceriesViewModel vm, bool isTablet) {
    final double buttonHeight = isTablet ? 55 : 45;
    final double fontSize = isTablet ? 18 : 16;

    return SizedBox(
      height: buttonHeight,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: vm.selectShoppingList,
              child: Container(
                decoration: ShapeDecoration(
                  color: vm.isShoppingListActive ? const Color(0xFF4B572B) : const Color(0x4CE7FCB1),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: vm.isShoppingListActive ? const Color(0xFF4B572B) : const Color(0xFFABBA72),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Shopping List',
                    style: TextStyle(
                      color: vm.isShoppingListActive ? Colors.white : const Color(0xFF4B572B),
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Kantumruy Pro',
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: vm.selectGroceries,
              child: Container(
                decoration: ShapeDecoration(
                  color: !vm.isShoppingListActive ? const Color(0xFF4B572B) : const Color(0x4CE7FCB1),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: !vm.isShoppingListActive ? Colors.white : const Color(0xFFABBA72),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Groceries',
                    style: TextStyle(
                      color: !vm.isShoppingListActive ? Colors.white : const Color(0xFF4B572B),
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Kantumruy Pro',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShoppingListContent(BuildContext context, GroceriesViewModel vm, bool isTablet) {
    final double iconSize = isTablet ? 28 : 22;
    final double titleFontSize = isTablet ? 18 : 16;
    final double buttonIconSize = isTablet ? 32 : 28;
    final double emptyTextFontSize = isTablet ? 18 : 16;
    final double hPadding = isTablet ? 24 : 16;
    final double vPadding = isTablet ? 24 : 16;

    final items = vm.shoppingList;

    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: const Color(0xFFFFFBF0),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x59DF6149)),
          borderRadius: BorderRadius.circular(27),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/clock.svg',
                      width: iconSize,
                      height: iconSize,
                      colorFilter: const ColorFilter.mode(Color(0xFF981800), BlendMode.srcIn),
                    ),
                    SizedBox(width: isTablet ? 16 : 10),
                    Text(
                      'Items to buy : ${vm.itemsToBuyCount}',
                      style: TextStyle(
                        color: const Color(0xFF981800),
                        fontSize: titleFontSize,
                        fontFamily: 'Kantumruy Pro',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: vm.toggleEditMode,
                      icon: vm.isEditMode
                          ? const Icon(Icons.close, color: Color(0xFFDF6149))
                          : SvgPicture.asset(
                        'assets/images/edit_icon.svg',
                        width: buttonIconSize,
                        height: buttonIconSize,
                        colorFilter: const ColorFilter.mode(Color(0xFF4B572B), BlendMode.srcIn),
                      ),
                    ),
                    IconButton(
                      onPressed: vm.startAddingNewItem,
                      icon: SvgPicture.asset(
                        'assets/images/add_circle.svg',
                        width: buttonIconSize,
                        height: buttonIconSize,
                        colorFilter: const ColorFilter.mode(Color(0xFF4B572B), BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPadding),
            child: const Divider(color: Color(0xFF708240), height: 1),
          ),

          SizedBox(height: isTablet ? 24 : 16),

          if (vm.isAddingNewItem)
            _buildAddIngredientInput(context, vm),

          Expanded(
            child: items.isEmpty && !vm.isAddingNewItem
                ? Padding(
              padding: EdgeInsets.only(top: isTablet ? 16 : 8),
              child: Text(
                'Shopping list is empty',
                style: TextStyle(
                  color: const Color(0xFF981800),
                  fontSize: emptyTextFontSize,
                  fontFamily: 'Kantumruy Pro',
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: hPadding).copyWith(top: 0),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _ShoppingListItemWidget(
                  item: items[index],
                  vm: vm,
                  isEditMode: vm.isEditMode,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddIngredientInput(BuildContext context, GroceriesViewModel vm) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: const Color(0x00FFE3DA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: SizedBox(
                height: 40,
                child: TextFormField(
                  initialValue: vm.newShoppingItem.name,
                  style: const TextStyle(color: Color(0xFF981800), fontSize: 15),
                  decoration: _buildInputDecoration('Name'),
                  onChanged: vm.updateNewItemName,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text('|', style: TextStyle(color: Color(0xFFDF6149))),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 40,
                child: TextFormField(
                  initialValue: vm.newShoppingItem.amount,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xFF981800), fontSize: 15),
                  decoration: _buildInputDecoration('Qty'),
                  onChanged: vm.updateNewItemAmount,
                ),
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: vm.saveNewItem,
              child: const Icon(Icons.check_circle, color: Color(0xFF4B572B), size: 28),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: vm.cancelAddingNewItem,
              child: const Icon(Icons.cancel, color: Color(0xFF991800), size: 28),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF959595), fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFFDFDFD),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0x59DF6149), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFF49069), width: 1.5),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0x59DF6149)),
      ),
    );
  }

  Widget _buildGroceriesContent(BuildContext context, GroceriesViewModel vm, bool isTablet) {
    final double emptyTextFontSize = isTablet ? 18 : 16;
    final double hPadding = isTablet ? 24 : 16;
    final double vPadding = isTablet ? 24 : 16;

    final groups = vm.groceriesByRecipe;

    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: const Color(0xFFFFFBF0),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x59DF6149)),
          borderRadius: BorderRadius.circular(27),
        ),
      ),
      child: groups.isEmpty
          ? Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: 40),
            child: Text(
              'No recipes found to get ingredients',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF981800),
                fontSize: emptyTextFontSize,
                fontFamily: 'Kantumruy Pro',
                fontWeight: FontWeight.w500,
              ),
            ),
          )
      )
          : ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return _GroceriesGroupItem(group: groups[index], vm: vm);
        },
      ),
    );
  }
}