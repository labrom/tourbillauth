import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourbillon/email_address_input_form.dart';
import 'package:tourbillon/libloc.dart';

import 'user_access_view_model.dart';
import 'user_selector.dart';

class UserAccessView extends StatelessWidget {
  final String? resource;
  final List<String>? roles;
  final UserAccessViewModel viewModel;

  const UserAccessView({
    required this.viewModel,
    this.roles,
    Key? key,
  })  : resource = null,
        super(key: key);

  const UserAccessView.forResource(
    String resource, {
    required this.viewModel,
    this.roles,
    Key? key,
    // ignore: prefer_initializing_formals
  })  : resource = resource,
        super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
        value: viewModel,
        builder: (context, __) {
          context.watch<UserAccessViewModel>();
          return Column(
            children: resource != null
                ? _withResource(context)
                : _withoutResource(context),
          );
        },
      );

  List<Widget> _withResource(BuildContext context) => [
        UserSelector((user) =>
            viewModel.addUser(user.uid, email: user.email, resource: resource)),
        Expanded(
          child: ListView(
            children: viewModel
                .listUsersAndInvites(resource: resource)
                .map((user) => _userItemBuilder(context, viewModel, user))
                .toList(),
          ),
        ),
      ];

  List<Widget> _withoutResource(BuildContext context) => [
        _EmailAddressRoleAdd(viewModel),
        Expanded(
          child: ListView(
            children: viewModel
                .listUsersAndInvites()
                .map((user) => _userItemBuilder(context, viewModel, user))
                .toList(),
          ),
        ),
      ];

  Widget _userItemBuilder(
          BuildContext context, UserAccessViewModel viewModel, UserRole user) =>
      ListTile(
        title: Text(
          user.userEmail,
        ),
        subtitle: user.role != null
            ? Text(
                user.role!,
              )
            : null,
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => user.userId != null
              ? viewModel.removeUser(user.userId!)
              : viewModel.removeInvite(user.userEmail),
        ),
      );
}

class _EmailAddressRoleAdd extends StatefulWidget {
  final UserAccessViewModel viewModel;
  final String? resource;
  final List<String>? roles;

  const _EmailAddressRoleAdd(
    this.viewModel, {
    this.resource,
    this.roles,
  });

  @override
  State<StatefulWidget> createState() => _EmailAddressRoleAddState();
}

class _EmailAddressRoleAddState extends State<_EmailAddressRoleAdd> {
  var valid = false;
  String? role;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: EmailAddressInputForm.withoutAddButton(
              onEmailAddressValidityChanged: (email, valid) {
                setState(() {
                  this.valid = valid;
                });
              },
              controller: _controller,
            ),
          ),
          DropdownButton<String>(
            items: widget.roles
                ?.map((role) => DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    ))
                .toList(),
            onChanged: (value) => role = value,
          ),
          TextButton(
            onPressed: valid
                ? () => widget.viewModel.addInvite(
                      _controller.text,
                      resource: widget.resource,
                      role: role,
                    )
                : null,
            child: Text(libloc(context).addButtonLabel),
          ),
        ],
      );
}
