/**
 * This code imports packages and libraries to create a new reflection, refresh reflections, and save all reflections in the UI.
 * It also contains functions to check if the reflection already exists and show a snackbar if it does.
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reflections_app/models/reflection.dart';
//import 'package:reflections_app/models/reflection_model.dart';
import 'package:reflections_app/service/reflection_service.dart';
import 'package:reflections_app/service/user_service.dart';
import 'package:reflections_app/widgets/dialogs.dart';
import 'package:reflections_app/routes/routes.dart';

void refreshReflectionsInUI(BuildContext context) async {
  String result = await context
      .read<ReflectionService>()
      .getReflections(context.read<UserService>().currentUser!.email);
  if (result != "OK") {
    showSnackBar(context, result);
  } else {
    showSnackBar(context, "Data successfull Retrieved");
  }
}

void saveAllReflectionsInUI(BuildContext context) async {
  String result = await context.read<ReflectionService>().saveReflectionEntry(
      context.read<UserService>().currentUser!.email, true);
  if (result != "OK") {
    showSnackBar(context, result);
  } else {
    showSnackBar(context, "Data successfuly saved online");
  }
}

void createNewReflectionInUI(
  BuildContext context, {
  required TextEditingController titleController,
  required TextEditingController reflectionController,
}) async {
  if (titleController.text.isEmpty) {
    showSnackBar(context, "Enter Your Reflection");
  } else {
    Reflection reflection = Reflection(
      title: titleController.text.trim(),
      reflection: reflectionController.text.trim(),
    );
    if (context.read<ReflectionService>().units.contains(reflection)) {
      showSnackBar(context, "Reflection already Exist..");
    } else {
      titleController.text = "";
      context.read<ReflectionService>().createReflection(reflection);
      Navigator.of(context).pushNamed(RouteManager.reflectionPage);
    }
  }
}
