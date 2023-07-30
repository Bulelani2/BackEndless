/**
 * This code is a Stateful Widget that imports packages and classes necessary for a ReflectionPage.
 * It also contains functions that allow a user to refresh, save, add, and logout of the page.
 * It also contains a build function that allows the user to view and interact with the page.
 */
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:reflections_app/models/reflection_model.dart';
import 'package:reflections_app/routes/routes.dart';
import 'package:reflections_app/service/helper_reflection.dart';
import 'package:reflections_app/service/helper_user.dart';
import 'package:reflections_app/service/reflection_service.dart';
import 'package:reflections_app/service/user_service.dart';
import 'package:reflections_app/widgets/app_progress.dart';
import 'package:reflections_app/widgets/reflection_card.dart';
import 'package:reflections_app/widgets/units_card.dart';

import 'package:tuple/tuple.dart';

class ReflectionPage extends StatefulWidget {
  const ReflectionPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ReflectionPageState createState() => _ReflectionPageState();
}

class _ReflectionPageState extends State<ReflectionPage> {
  late TextEditingController reflectionController;
  late TextEditingController unitDescController;

  @override
  void initState() {
    super.initState();
    reflectionController = TextEditingController();
    unitDescController = TextEditingController();
  }

  @override
  void dispose() {
    reflectionController.dispose();
    unitDescController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // context.read<ReflectionViewModel>().fetchReflectionData();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 209, 209, 209),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.refresh,
                            color: Color.fromARGB(255, 29, 29, 29),
                            size: 30,
                          ),
                          onPressed: () {
                            refreshReflectionsInUI(context);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.save,
                            color: Color.fromARGB(255, 29, 29, 29),
                            size: 30,
                          ),
                          onPressed: () async {
                            saveAllReflectionsInUI(context);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 29, 29, 29),
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RouteManager.unitCreatePage);
                            //Change it to be a page
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  title: const Text('Create a new Reflection'),
                                  content: Column(
                                    children: [
                                      TextField(
                                        decoration: const InputDecoration(
                                            hintText:
                                                'Please enter Unit Description'),
                                        controller: unitDescController,
                                      ),
                                      TextField(
                                        decoration: const InputDecoration(
                                            hintText:
                                                'Please enter Reflection'),
                                        controller: reflectionController,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            RouteManager.reflectionPage);
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Save'),
                                      onPressed: () async {
                                        createNewReflectionInUI(context,
                                            reflectionController:
                                                reflectionController,
                                            titleController:
                                                unitDescController);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.exit_to_app,
                            color: Color.fromARGB(255, 29, 29, 29),
                            size: 30,
                          ),
                          onPressed: () {
                            logoutUserInUI(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: provider.Selector<UserService, BackendlessUser?>(
                      selector: (context, value) => value.currentUser,
                      builder: (context, value, child) {
                        return value == null
                            ? Container()
                            : Text(
                                '${value.getProperty('name')}\'s Reflection list',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 46,
                                  fontWeight: FontWeight.w200,
                                  color: Color.fromARGB(255, 29, 29, 29),
                                ),
                              );
                      },
                    ),
                  ),
                  Flexible(
                    child: provider.Consumer<ReflectionViewModel>(
                      builder: (context, value, child) {
                        return value.reflections.isEmpty && !value.error
                            ? const CircularProgressIndicator()
                            : value.error
                                ? Text(value.errorMessage)
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: value.reflections.length,
                                    itemBuilder: (context, index) {
                                      return UnitsCard(
                                          map: value.reflections[index],
                                          onTap: () {
                                            context
                                                    .read<ReflectionViewModel>()
                                                    .selectedReflection =
                                                value.reflections[index];
                                            Navigator.of(context).pushNamed(
                                                RouteManager.unitViewPage);
                                          });
                                    },
                                  );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 350),
              child: Expanded(
                child: provider.Consumer<ReflectionService>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      itemCount: value.units.length,
                      itemBuilder: (context, index) {
                        return ReflectionCard(
                          reflection: value.units[index],
                          onTap: () {
                            context
                                .read<ReflectionService>()
                                .selectedReflection = value.units[index];
                            Navigator.of(context)
                                .pushNamed(RouteManager.reflectionViewPage);
                          },
                          deleteAction: () async {
                            context
                                .read<ReflectionService>()
                                .deleteReflection(value.units[index]);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            provider.Selector<UserService, Tuple2>(
              builder: (context, value, child) {
                return value.item1
                    ? AppProgressIndicator(text: value.item2)
                    : Container();
              },
              selector: (context, value) =>
                  Tuple2(value.showUserProgress, value.userProgressText),
            ),
            provider.Selector<ReflectionService, Tuple2>(
              builder: (context, value, child) {
                return value.item1
                    ? const AppProgressIndicator(
                        text: 'Busy retrieving data...')
                    : value.item2
                        ? const AppProgressIndicator(
                            text: 'Busy saving data...')
                        : Container();
              },
              selector: (context, value) =>
                  Tuple2(value.busyRetrieving, value.busySaving),
            )
          ],
        ),
      ),
    );
  }
}
