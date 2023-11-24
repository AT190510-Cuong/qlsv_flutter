import 'package:connection/models/place.dart';
import 'package:flutter/material.dart';

import '../models/lop.dart';
import '../models/profile.dart';
import 'AppConstant.dart';

class CustomPlaceDropDown extends StatefulWidget {
  CustomPlaceDropDown({
    super.key,
    required this.width,
    required this.title,
    required this.valueId,
    required this.valueName,
    required this.callback,
    required this.list,
  });

  // final Profile profile;
  final double width;
  final String title;
  final int valueId;
  final String valueName;

  final List<Place> list;

  final Function(int outputId, String outputName) callback;

  @override
  State<CustomPlaceDropDown> createState() => _CustomPlaceDropDownState();
}

class _CustomPlaceDropDownState extends State<CustomPlaceDropDown> {
  int status = 0;
  int outputId = 0;
  String outputName = "";

  @override
  void initState() {
    // TODO: implement initState
    outputId = widget.valueId;
    outputName = widget.valueName;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppConstant.textbody,
        ),
        status == 0
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    status = 1;
                  });
                },
                child: Text(
                  outputName == "" ? "không có" : outputName,
                  style: AppConstant.textbodyfocus,
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                width: widget.width,
                child: DropdownButton(
                  value: outputId,
                  items: widget.list
                      .map((e) => DropdownMenuItem(
                          value: e.id,
                          child: Container(
                              width: widget.width - 45,
                              child: Text(
                                e.name,
                                overflow: TextOverflow.ellipsis,
                              ))))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      outputId = value!;
                      for (var dropitem in widget.list) {
                        if (dropitem.id == outputId) {
                          outputName = dropitem.name;
                          widget.callback(outputId, outputName);
                          break;
                        }
                      }
                      status = 0;
                    });
                  },
                ),
              ),
        const Divider(
          thickness: 1,
        )
      ],
    );
  }
}

class CustomInputDropDown extends StatefulWidget {
  CustomInputDropDown({
    super.key,
    required this.width,
    required this.title,
    required this.valueId,
    required this.valueName,
    required this.callback,
    required this.list,
  });

  // final Profile profile;
  final double width;
  final String title;
  final int valueId;
  final String valueName;

  final List<Lop> list;

  final Function(int outputId, String outputName) callback;

  @override
  State<CustomInputDropDown> createState() => _CustomInputDropDownState();
}

class _CustomInputDropDownState extends State<CustomInputDropDown> {
  int status = 0;
  int outputId = 0;
  String outputName = "";

  @override
  void initState() {
    // TODO: implement initState
    outputId = widget.valueId;
    outputName = widget.valueName;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppConstant.textbody,
        ),
        status == 0
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    status = 1;
                  });
                },
                child: Text(
                  outputName == "" ? "không có" : outputName,
                  style: AppConstant.textbodyfocus,
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                width: widget.width - 25,
                child: DropdownButton(
                  value: outputId,
                  items: widget.list
                      .map((e) => DropdownMenuItem(
                          value: e.id,
                          child: Container(
                              width: widget.width * 0.8,
                              child: Text(
                                e.ten,
                                overflow: TextOverflow.ellipsis,
                              ))))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      outputId = value!;
                      for (var dropitem in widget.list) {
                        if (dropitem.id == outputId) {
                          outputName = dropitem.ten;
                          widget.callback(outputId, outputName);
                          break;
                        }
                      }
                      status = 0;
                    });
                  },
                ),
              ),
        const Divider(
          thickness: 1,
        )
      ],
    );
  }
}

class CustomInputTextFormField extends StatefulWidget {
  const CustomInputTextFormField({
    super.key,
    required this.width,
    required this.title,
    required this.value,
    required this.callback,
    // required this.callback,
    this.type = TextInputType.text,
  });

  // final Profile profile;
  final double width;
  final String title;
  final String value;
  final TextInputType type;
  final Function(String output) callback;

  @override
  State<CustomInputTextFormField> createState() =>
      _CustomInputTextFormFieldState();
}

class _CustomInputTextFormFieldState extends State<CustomInputTextFormField> {
  int status = 0;
  String output = "";

  @override
  void initState() {
    // TODO: implement initState
    output = widget.value;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppConstant.textbody,
          ),
          status == 0
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      status = 1;
                    });
                  },
                  child: Text(
                    widget.value == "" ? "không có" : widget.value,
                    style: AppConstant.textbodyfocus,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200],
                      ),
                      width: widget.width - 50,
                      child: TextFormField(
                        keyboardType: widget.type,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        initialValue: output,
                        onChanged: (value) {
                          setState(() {
                            output = value;
                            widget.callback(output);
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          status = 0;
                          widget.callback(output);
                        });
                      },
                      child: const Icon(
                        Icons.save,
                        size: 18,
                      ),
                    ),
                  ],
                ),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}

class CustomAvatar1 extends StatelessWidget {
  const CustomAvatar1({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.height * 0.25),
      child: Container(
          width: 100,
          height: 100,
          child: Image.network(
            // Profile().user.avatar,
            "https://scontent.fhan14-2.fna.fbcdn.net/v/t1.6435-9/83504878_471744380383639_823124271755689984_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=be3454&_nc_ohc=mPTHt8wlmm8AX9RhLPX&_nc_ht=scontent.fhan14-2.fna&oh=00_AfDISF5O0rgx_kY3nCq_bydiutD5bnVbDegY8Jc-GOs5dg&oe=65868924",
            fit: BoxFit.cover,
          )),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.textButton,
  });

  final String textButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(
          textButton,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController textController,
    required this.hintText,
    required this.obscureText,
  }) : _textController = textController;

  final TextEditingController _textController;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        obscureText: obscureText,
        controller: _textController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.account_tree,
      size: 100,
      color: Colors.deepPurple[300],
    );
  }
}

class CustomSpinner extends StatelessWidget {
  const CustomSpinner({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.deepPurple.withOpacity(0.3),
      child: const Center(
          child: CircularProgressIndicator(
        color: Colors.cyan,
      )),
    );
  }
}
