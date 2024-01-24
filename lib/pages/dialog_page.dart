import 'package:flutter/material.dart';
import 'package:friendly_spaces/data/emotions.dart';

class DialogPage extends StatefulWidget {
  const DialogPage(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.onSave,
      required this.onCancel});

  final TextEditingController controller;
  final String hintText;
  final Function(String, [int?]) onSave;
  final VoidCallback onCancel;

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  final scrollController = ScrollController();

  String emotion = "";
  List selectedIconButton = List<bool>.filled(emotionsMap.length, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 150, 20, 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 200),
                child: SingleChildScrollView(
                  child: TextField(
                    controller: widget.controller,
                    maxLines: null,
                    decoration: InputDecoration(
                      fillColor:
                          Theme.of(context).colorScheme.primary.withAlpha(100),
                      focusColor: Theme.of(context).colorScheme.surfaceVariant,
                      enabledBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15.0,
                      ),
                      hintText: widget.hintText,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 70,
                            childAspectRatio: 3 / 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemCount: emotionsMap.length,
                    itemBuilder: (context, index) {
                      return IconButton(
                          color: Theme.of(context).colorScheme.surfaceTint,
                          highlightColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(200),
                          isSelected: selectedIconButton[index],
                          onPressed: () {
                            setState(() {
                              for (int i = 0;
                                  i < selectedIconButton.length;
                                  i++) {
                                if (i == index) {
                                  selectedIconButton[i] =
                                      !selectedIconButton[i];
                                } else {
                                  selectedIconButton[i] = false;
                                }
                              }
                              emotion = (selectedIconButton[index])
                                  ? emotionsList[index]
                                  : "";
                            });
                          },
                          selectedIcon: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withAlpha(100)),
                            child: emotionsMap[emotionsList[index]],
                          ),
                          icon: emotionsMap[emotionsList[index]] ??
                              const SizedBox());
                    }),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => widget.onSave(emotion),
                    child: const Text("Save"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: widget.onCancel,
                    child: const Text("Close"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
