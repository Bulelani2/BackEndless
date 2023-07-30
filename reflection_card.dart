/**
 * This code creates a widget called ReflectionCard which is a card with a title and a delete button.
 * It takes in a reflection object, a deleteAction function, and an onTap function.
 * When the card is tapped, the onTap function is called.
 * When the delete button is tapped, the deleteAction function is
 */
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:reflections_app/models/reflection.dart';

class ReflectionCard extends StatelessWidget {
  const ReflectionCard({
    Key? key,
    required this.reflection,
    required this.deleteAction,
    required this.onTap,
  }) : super(key: key);

  final Reflection reflection;
  final Function() deleteAction;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Slidable(
            actionPane: const SlidableDrawerActionPane(),
            secondaryActions: [
              IconSlideAction(
                caption: 'Delete',
                icon: Icons.delete,
                onTap: deleteAction,
              ),
            ],
            child: ListTile(
              title: Text(
                reflection.title,
              ),
              onTap: onTap,
            )),
      ),
    );
  }
}
