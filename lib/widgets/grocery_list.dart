import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/new_item.dart';
import 'package:shopping_app/models/grocery_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];
  Widget content = const Center(child: Text("No items here"));
  
  void _removeItem(GroceryItem item){
    setState(() {
      _groceryItems.remove(item);
    });
  }

  void _addItem() async {
    var newItem = await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(
      builder: (ctx) => const NewItem(),
    ));

    if(newItem == null){
      return;
    }
    
    setState(() {
      _groceryItems.add(newItem);
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(_groceryItems[index].id),
          direction: DismissDirection.horizontal,
          onDismissed:(direction) {
            _removeItem(_groceryItems[index]);
          },
          child: ListTile(
            title: Text(
              _groceryItems[index].name,
            ),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(_groceryItems[index].quantity.toString()),
          ),
        ),
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
