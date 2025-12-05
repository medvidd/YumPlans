import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '/models/recipe_model.dart';
import '/models/planner_model.dart';
import '/viewmodels/recipes_vm.dart';
import '/viewmodels/planner_vm.dart';
import '/views/recipes/recipe_list_item.dart';

class EditPlannedMealScreen extends StatefulWidget {
  final PlannedMeal plannedMeal;

  const EditPlannedMealScreen({
    super.key,
    required this.plannedMeal,
  });

  @override
  State<EditPlannedMealScreen> createState() => _EditPlannedMealScreenState();
}

class _EditPlannedMealScreenState extends State<EditPlannedMealScreen> {
  late final TextEditingController _hourController;
  late final TextEditingController _minuteController;
  final TextEditingController _searchController = TextEditingController();

  late DateTime _currentDate;
  late DateTime _focusedMonth;
  bool _showCalendar = false;

  Recipe? _selectedRecipe;
  String _amPm = '';

  final DateFormat _monthFormat = DateFormat('MMMM yyyy');

  @override
  void initState() {
    super.initState();

    final dateTime = widget.plannedMeal.dateTime;
    _currentDate = dateTime;
    _focusedMonth = DateTime(_currentDate.year, _currentDate.month, 1);

    _selectedRecipe = widget.plannedMeal.recipe;

    final int hour12 = (dateTime.hour % 12) == 0 ? 12 : (dateTime.hour % 12);
    _amPm = dateTime.hour >= 12 ? 'PM' : 'AM';

    _hourController = TextEditingController(text: hour12.toString().padLeft(2, '0'));
    _minuteController = TextEditingController(text: dateTime.minute.toString().padLeft(2, '0'));
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (_selectedRecipe == null) return;

    final int? hourInput = int.tryParse(_hourController.text);
    final int? minuteInput = int.tryParse(_minuteController.text);

    if (hourInput == null || minuteInput == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid time format')),
      );
      return;
    }

    int hour24 = hourInput;
    if (_amPm == 'PM' && hourInput != 12) hour24 += 12;
    if (_amPm == 'AM' && hourInput == 12) hour24 = 0;

    final DateTime newDateTime = DateTime(
      _currentDate.year,
      _currentDate.month,
      _currentDate.day,
      hour24,
      minuteInput,
    );

    try {
      final plannerVM = Provider.of<PlannerViewModel>(context, listen: false);

      final updatedMeal = PlannedMeal(
        id: widget.plannedMeal.id,
        userId: widget.plannedMeal.userId,
        dateTime: newDateTime,
        recipe: _selectedRecipe!,
        mealType: _selectedRecipe!.mealType.label,
      );

      await plannerVM.updatePlannedMeal(updatedMeal);

      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating meal: $e')),
        );
      }
    }
  }

  Future<void> _deleteMeal() async {
    try {
      final plannerVM = Provider.of<PlannerViewModel>(context, listen: false);
      await plannerVM.deletePlannedMeal(widget.plannedMeal.id);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting meal: $e')),
        );
      }
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<DateTime?> _getDaysInMonth() {
    final firstDayOfMonth = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final lastDayOfMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0);
    final days = <DateTime?>[];
    for (int i = 0; i < firstDayOfMonth.weekday - 1; i++) {
      days.add(null);
    }
    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      days.add(DateTime(_focusedMonth.year, _focusedMonth.month, i));
    }
    return days;
  }

  void _navigateMonth(bool forward) {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + (forward ? 1 : -1), 1);
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
      _currentDate = date;
      _focusedMonth = DateTime(date.year, date.month, 1);
      _showCalendar = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding = screenWidth > 600 ? 80.0 : 24.0;
    final bool isTablet = screenWidth > 600;

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
        title: const Text(
          'PLANNER',
          style: TextStyle(
            color: Color(0xFF4B572B),
            fontSize: 24,
            fontFamily: 'Kantumruy Pro',
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          _buildAppBarAction(
            iconPath: 'assets/images/trash.svg',
            color: const Color(0xFF991800),
            onTap: _deleteMeal,
          ),
          _buildAppBarAction(
            iconPath: 'assets/images/save.svg',
            color: const Color(0xFF4B572B),
            onTap: _saveChanges,
            isSaveButton: true,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Consumer<RecipesViewModel>(
        builder: (context, recipesVM, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDate(_currentDate),
                      style: const TextStyle(
                        color: Color(0xFF4B572B),
                        fontSize: 20,
                        fontFamily: 'Kantumruy Pro',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showCalendar = !_showCalendar;
                        });
                      },
                      child: Text(
                        _showCalendar ? 'CLOSE CALENDAR' : 'VIEW CALENDAR',
                        style: const TextStyle(
                          color: Color(0xFFDF6149),
                          fontSize: 14,
                          fontFamily: 'Kantumruy Pro',
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFFDF6149),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                if (_showCalendar) _buildCalendarWidget(isTablet),

                const SizedBox(height: 24),

                _buildTimeInput(),

                const SizedBox(height: 24),

                _buildSearchRow(recipesVM),

                const SizedBox(height: 24),

                SizedBox(
                  height: 400,
                  child: recipesVM.isLoading
                      ? const Center(child: CircularProgressIndicator(color: Color(0xFFABBA72)))
                      : ListView.builder(
                    itemCount: recipesVM.recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipesVM.recipes[index];

                      final isSelected = _selectedRecipe?.id == recipe.id;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: RecipeListItem(
                          recipe: recipe,
                          selectedColor: const Color(0xFFFFC107),
                          isSelected: isSelected,
                          onTap: () {
                            setState(() {
                              _selectedRecipe = recipe;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBarAction({
    required String iconPath,
    required Color color,
    required VoidCallback onTap,
    bool isSaveButton = false,
  }) {
    return Container(
      margin: EdgeInsets.only(right: isSaveButton ? 0 : 8),
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
          iconPath,
          width: 28,
          height: 28,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
        onPressed: onTap,
      ),
    );
  }

  Widget _buildTimeInput() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: ShapeDecoration(
        color: const Color(0xFFFFFBF0),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF959595)),
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter time',
            style: TextStyle(
              color: Color(0xFF49454F),
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimeField(_hourController, isSelected: true),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(':', style: TextStyle(fontSize: 45, color: Color(0xFF1D1B20))),
              ),
              _buildTimeField(_minuteController, isSelected: false),
              const SizedBox(width: 16),
              Column(
                children: [
                  _buildAmPmItem("AM", _amPm == "AM"),
                  _buildAmPmItem("PM", _amPm == "PM"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeField(TextEditingController controller, {required bool isSelected}) {
    return Container(
      width: 100,
      height: 80,
      decoration: ShapeDecoration(
        color: isSelected ? const Color(0xFFF5D4CA) : const Color(0x2BDF6149),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: isSelected ? const Color(0xFFDF6149) : const Color(0x59DF6149),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: isSelected ? const Color(0xFF9D3B29) : const Color(0xFF1D1B20),
          fontSize: 45,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget _buildAmPmItem(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _amPm = text;
        });
      },
      child: Container(
        width: 45,
        height: 38,
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xFFF5D4CA) : const Color(0xFFE8E8E8),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFF79747E)),
            borderRadius: text == "AM"
                ? const BorderRadius.vertical(top: Radius.circular(8))
                : const BorderRadius.vertical(bottom: Radius.circular(8)),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF49454F),
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchRow(RecipesViewModel vm) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: ShapeDecoration(
              color: const Color(0x4CE7FCB1),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFABBA72)),
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: TextField(
              controller: vm.searchController,
              decoration: const InputDecoration(
                hintText: 'Search by name, tag ..',
                hintStyle: TextStyle(
                  color: Color(0xFF4B572B),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                ),
                prefixIcon: Icon(Icons.search, color: Color(0xFF4B572B)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarWidget(bool isTablet) {
    final double arrowSize = isTablet ? 50 : 40;
    final double titleFontSize = isTablet ? 20 : 18;
    final double dayFontSize = isTablet ? 16 : 14;
    final double padding = isTablet ? 16 : 8;

    Widget calendarContent = Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF959595)),
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _navigateMonth(false),
                  child: SizedBox(
                    width: arrowSize,
                    height: arrowSize,
                    child: SvgPicture.asset('assets/images/arrow_left.svg'),
                  ),
                ),
                Text(
                  _monthFormat.format(_focusedMonth),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF49454F),
                    fontSize: titleFontSize,
                    fontFamily: 'Kantumruy Pro',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () => _navigateMonth(true),
                  child: SizedBox(
                    width: arrowSize,
                    height: arrowSize,
                    child: SvgPicture.asset('assets/images/arrow_right.svg'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemCount: _getDaysInMonth().length,
              itemBuilder: (context, index) {
                final date = _getDaysInMonth()[index];
                if (date == null) return const SizedBox();
                final isSelected = _isSameDay(date, _currentDate);
                final isToday = _isSameDay(date, DateTime.now());

                return GestureDetector(
                  onTap: () => _selectDate(date),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: isSelected ? const Color(0xFFDF6149) : Colors.transparent,
                        shape: RoundedRectangleBorder(
                          side: isToday && !isSelected
                              ? const BorderSide(width: 2, color: Color(0xFF708240))
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(
                          fontFamily: 'Kantumruy Pro',
                          color: isSelected ? Colors.white : const Color(0xFF1D1B20),
                          fontWeight: FontWeight.w400,
                          fontSize: dayFontSize,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: isTablet ? 20 : 10),
        ],
      ),
    );

    if (isTablet) {
      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450.0),
          child: calendarContent,
        ),
      );
    }
    return calendarContent;
  }

  String _formatDate(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final dayName = days[date.weekday - 1];
    return "$dayName, ${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}";
  }
}