import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/models/recipe_model.dart';
import 'package:provider/provider.dart';
import '/viewmodels/recipes_vm.dart';

class CreateRecipeScreen extends StatefulWidget {
  final Recipe? recipe;

  const CreateRecipeScreen({super.key, this.recipe});

  @override
  State<CreateRecipeScreen> createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  MealType _selectedMealType = MealType.breakfast;
  List<Ingredient> _ingredients = [];
  String _imageUrl = '';

  @override
  void initState() {
    super.initState();
    if (widget.recipe != null) {
      _titleController.text = widget.recipe!.title;
      _caloriesController.text = widget.recipe!.calories.toString();
      _descriptionController.text = widget.recipe!.description;
      _selectedMealType = widget.recipe!.mealType;
      _imageUrl = widget.recipe!.imageUrl;

      _ingredients = widget.recipe!.ingredients
          .map((e) => Ingredient(name: e.name, amount: e.amount))
          .toList();
    } else {
      if (_ingredients.isEmpty) {
        _ingredients.add(Ingredient(name: '', amount: ''));
      }
    }
  }

  Future<void> _saveRecipe(RecipesViewModel vm) async {
    if (_titleController.text.isEmpty || _caloriesController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill required fields')),
      );
      return;
    }

    final int calories = int.tryParse(_caloriesController.text) ?? 0;

    final validIngredients = _ingredients.where((i) => i.name.isNotEmpty).toList();

    if (widget.recipe == null) {
      await vm.addRecipe(
        title: _titleController.text,
        imageUrl: _imageUrl,
        calories: calories,
        mealType: _selectedMealType,
        description: _descriptionController.text,
        ingredients: validIngredients,
      );
    } else {
      final updatedRecipe = Recipe(
        id: widget.recipe!.id,
        userId: widget.recipe!.userId,
        title: _titleController.text,
        imageUrl: _imageUrl,
        calories: calories,
        mealType: _selectedMealType,
        description: _descriptionController.text,
        ingredients: validIngredients,
      );
      await vm.updateRecipe(updatedRecipe);
    }

    if (mounted) Navigator.pop(context);
  }

  Future<void> _pickImage(RecipesViewModel vm) async {
    final url = await vm.uploadImage();
    if (url != null) {
      setState(() {
        _imageUrl = url;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _caloriesController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _addIngredient() {
    setState(() {
      _ingredients.add(Ingredient(name: '', amount: ''));
    });
  }

  void _updateIngredient(int index, String name, String amount) {
    setState(() {
      _ingredients[index] = Ingredient(name: name, amount: amount);
    });
  }

  InputDecoration _buildFigmaInputDecoration(String hint) {
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

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RecipesViewModel>(context, listen: false);


    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;
    final double horizontalPadding = isTablet ? 80.0 : 24.0;
    final double imageSize = isTablet ? 400 : 320;

    final String screenTitle = widget.recipe != null ? 'EDIT RECIPE' : 'NEW RECIPE';

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFABBA72),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4B572B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          screenTitle,
          style: const TextStyle(
            color: Color(0xFF4B572B),
            fontSize: 24,
            fontFamily: 'Kantumruy Pro',
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 34,
            height: 34,
            decoration: ShapeDecoration(
              color: const Color(0x7FFFFBF0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset(
                'assets/images/save.svg',
                width: 28,
                height: 28,
                colorFilter: const ColorFilter.mode(Color(0xFF4B572B), BlendMode.srcIn),
              ),
              onPressed: () => _saveRecipe(vm),
            ),
          ),
        ],
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: horizontalPadding,
                    right: horizontalPadding,
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      GestureDetector(
                        onTap: () => _pickImage(vm),
                        child: Center(
                          child: Container(
                            width: imageSize,
                            height: imageSize,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFE8E4DC),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            child: _imageUrl.isNotEmpty
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                _imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, stack) => _buildUploadPlaceholder(),
                              ),
                            )
                                : _buildUploadPlaceholder(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: _titleController,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF323C15),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: _buildFigmaInputDecoration('Meal name'),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            height: 45,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDFDFD),
                              border: Border.all(color: const Color(0x59DF6149)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<MealType>(
                                value: _selectedMealType,
                                icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF708240)),
                                style: const TextStyle(
                                  color: Color(0xFF708240),
                                  fontSize: 16,
                                  fontFamily: 'Kantumruy Pro',
                                ),
                                items: MealType.values.map((type) {
                                  return DropdownMenuItem(value: type, child: Text(type.label));
                                }).toList(),
                                onChanged: (val) => setState(() => _selectedMealType = val!),
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SvgPicture.asset(
                              'assets/images/fire.svg',
                              width: 18,
                              height: 18,
                              colorFilter: const ColorFilter.mode(
                                  Color(0xFFDF6149), BlendMode.srcIn),
                            ),
                          ),
                          const SizedBox(width: 8),

                          SizedBox(
                            width: 80,
                            child: TextField(
                              controller: _caloriesController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Color(0xFF708240), fontSize: 16),
                              decoration: _buildFigmaInputDecoration('150'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text('kcal', style: TextStyle(color: Color(0xFF708240), fontSize: 16)),
                        ],
                      ),

                      const SizedBox(height: 24),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Details :',
                          style: TextStyle(color: Color(0xFF323C15), fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 5,
                        style: const TextStyle(color: Color(0xFF708240), fontSize: 14),
                        decoration: _buildFigmaInputDecoration('Enter description...'),
                      ),

                      const SizedBox(height: 24),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(bottom: 16),
                        decoration: ShapeDecoration(
                          color: const Color(0x2BDF6149),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 1, color: Color(0xFFF49069)),
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: const ShapeDecoration(
                                color: Color(0xFFF49069),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    topRight: Radius.circular(18),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Ingredients:',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF981800),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            ..._ingredients.asMap().entries.map((entry) {
                              int index = entry.key;
                              Ingredient ingredient = entry.value;

                              return Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 6, height: 6,
                                      decoration: const BoxDecoration(color: Color(0xFFDF6149), shape: BoxShape.circle),
                                    ),
                                    const SizedBox(width: 12),

                                    Expanded(
                                      flex: 4,
                                      child: SizedBox(
                                        height: 40,
                                        child: TextFormField(
                                          key: ValueKey('name_$index'),
                                          initialValue: ingredient.name,
                                          style: const TextStyle(color: Color(0xFF981800), fontSize: 15),
                                          decoration: _buildFigmaInputDecoration('Name'),
                                          onChanged: (val) => _updateIngredient(index, val, ingredient.amount),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 8),
                                    const Text('|', style: TextStyle(color: Color(0xFFF49069))),
                                    const SizedBox(width: 8),

                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        height: 40,
                                        child: TextFormField(
                                          key: ValueKey('amount_$index'),
                                          initialValue: ingredient.amount,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(color: Color(0xFF981800), fontSize: 15),
                                          decoration: _buildFigmaInputDecoration('Qty'),
                                          onChanged: (val) => _updateIngredient(index, ingredient.name, val),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 8),

                                    InkWell(
                                      onTap: () => setState(() => _ingredients.removeAt(index)),
                                      child: const Icon(Icons.remove_circle, color: Color(0xFFDF6149), size: 24),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),

                            const SizedBox(height: 8),

                            GestureDetector(
                              onTap: _addIngredient,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDF6149),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'ADD INGREDIENT',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                height: 20,
                width: double.infinity,
                color: const Color(0xFFFFFBF0),
              ),
            ],
          ),
          if (context.watch<RecipesViewModel>().isLoading)
            Container(
              color: Colors.black45,
              child: const Center(child: CircularProgressIndicator(color: Color(0xFFABBA72))),
            ),
        ],
      ),
    );
  }

  Widget _buildUploadPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80, height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFB8B5AD), width: 4),
          ),
          child: const Icon(Icons.add, size: 40, color: Color(0xFFB8B5AD)),
        ),
        const SizedBox(height: 16),
        const Text(
          'UPLOAD IMAGE',
          style: TextStyle(
            color: Color(0xFF9B9889),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}