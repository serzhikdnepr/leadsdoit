
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../generated/l10n.dart';
import '../../../utils/styles.dart';


class SearchWidget extends StatefulWidget {
  final Function(String text) onSearchChanged;

  const SearchWidget({super.key, required this.onSearchChanged});

  @override
  _AddCardWebViewState createState() => _AddCardWebViewState();
}

class _AddCardWebViewState extends State<SearchWidget> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  late FocusNode focusNode = FocusNode()
    ..addListener(() {
      setState(() {});
    });
  final TextEditingController _searchQueryController = TextEditingController();


  @override
  void initState() {
    focusNode = FocusNode()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }



  @override
  void dispose() {
    focusNode.removeListener(() { });
    focusNode.dispose();
    _searchQueryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _fbKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormBuilderTextField(
            name: "searchText",
            focusNode: focusNode,
            controller: _searchQueryController,
            maxLines: 1,
            autofocus: false,
            style: searchStyle,
            onChanged: (value) {
              if(value!=null){
                widget.onSearchChanged(value);
              }
            },
            decoration: inputDecoration(
                S.of(context).search,
                focusNode.hasFocus,
                _searchQueryController.text.isNotEmpty
                    ? () {
                  _searchQueryController.text = "";
                }
                    : null),
            textAlignVertical: TextAlignVertical.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(128),
            ],
          ),
        ],
      ),
    );
  }
}
