import 'package:artify/main.dart';
import 'package:artify/screens/categories_model.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  final Item category;

  const CategoryView({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selected = !_selected;
          });
        },
        child: Card(
          shadowColor: Colors.grey.shade300,
          elevation: 8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  height: _selected ? 200 : 140,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: AssetImage(
                          widget.category.imageLocation,
                        ),
                        fit: BoxFit.cover),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: const Alignment(-1, 0),
                          child: Text(
                            widget.category.categoryName,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8),
                              child: Icon(
                                _selected
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color: _selected ? Colors.green : Colors.blue,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
