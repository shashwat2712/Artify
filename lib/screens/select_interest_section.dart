import 'package:artify/components/category_view.dart';
import 'package:artify/screens/categories_model.dart';
import 'package:artify/widgets/bottom_nav_bar_categories.dart';
import 'package:flutter/material.dart';

class SelectInterest extends StatelessWidget {
  const SelectInterest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> categories = ['Antic','Painting','Ethic','Origami'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: const Icon(Icons.arrow_back_ios),),
        title: Text('Select Interest',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: CategoryModel.items.length,
            itemBuilder: (context,index){
              return CategoryView(
                category: CategoryModel.items[index],
              );
            }
          ),

          const Align(
            alignment: Alignment.bottomCenter,
              child: ConfirmCategoryBar()
          )
          //
        ],
      ),
    );
  }
}
