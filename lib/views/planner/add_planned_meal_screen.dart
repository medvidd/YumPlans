import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '/models/recipe_model.dart';
import '/viewmodels/recipes_vm.dart';
import '/views/recipes/recipe_list_item.dart';

class AddPlannedMealScreen extends StatefulWidget {
  final DateTime selectedDate;

  const AddPlannedMealScreen({super.key, required this.selectedDate});

  @override
  State<AddPlannedMealScreen> createState() => _AddPlannedMealScreenState();
}

class _AddPlannedMealScreenState extends State<AddPlannedMealScreen> {
  final TextEditingController _hourController = TextEditingController(text: "20");
  final TextEditingController _minuteController = TextEditingController(text: "00");
  String _amPm = 'PM';
  Recipe? _selectedRecipe;

  late DateTime _currentDate;
  late DateTime _focusedMonth;
  bool _showCalendar = false;

  final DateFormat _monthFormat = DateFormat('MMMM yyyy');

  @override
  void initState() {
    super.initState();
    _currentDate = widget.selectedDate;
    _focusedMonth = DateTime(_currentDate.year, _currentDate.month, 1);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;
    final double horizontalPadding = isTablet ? 80.0 : 24.0;

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
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

        ],
      ),
      body: ChangeNotifierProvider(
        create: (_) => RecipesViewModel(),
        child: Consumer<RecipesViewModel>(
          builder: (context, vm, child) {
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

                  Container(
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
                            Container(
                              width: 100,
                              height: 80,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFF5D4CA),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(width: 1, color: Color(0xFFDF6149)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: TextField(
                                controller: _hourController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  color: Color(0xFF9D3B29),
                                  fontSize: 45,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: const InputDecoration(border: InputBorder.none),
                              ),
                            ),

                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(':', style: TextStyle(fontSize: 45, color: Color(0xFF1D1B20))),
                            ),

                            Container(
                              width: 100,
                              height: 80,
                              decoration: ShapeDecoration(
                                color: const Color(0x2BDF6149),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(width: 1, color: Color(0x59DF6149)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: TextField(
                                controller: _minuteController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  color: Color(0xFF1D1B20),
                                  fontSize: 45,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: const InputDecoration(border: InputBorder.none),
                              ),
                            ),

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
                  ),

                  const SizedBox(height: 24),

                  Row(
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
                          child: const TextField(
                            decoration: InputDecoration(
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
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const ShapeDecoration(
                            color: Color(0x7FFFFBF0),
                            shape: CircleBorder(),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 7,
                                offset: Offset(0, 0),
                              )
                            ],
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/add_circle.svg',
                              width: 48, height: 48,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    height: 400,
                    child: vm.isLoading
                        ? const Center(child: CircularProgressIndicator(color: Color(0xFFABBA72)))
                        : ListView.builder(
                      itemCount: vm.recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = vm.recipes[index];
                        final isSelected = _selectedRecipe?.id == recipe.id;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: RecipeListItem(
                            recipe: recipe,
                            onTap: () {
                              setState(() {
                                _selectedRecipe = recipe;
                              });
                            },
                            isSelected: isSelected,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
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
                  onTap: () {
                    setState(() {
                      _currentDate = date;
                      _focusedMonth = DateTime(date.year, date.month, 1);
                      _showCalendar = false;
                    });
                  },
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

  String _formatDate(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final dayName = days[date.weekday - 1];
    return "$dayName, ${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}";
  }
}