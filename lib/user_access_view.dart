import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourbillon/email_address_input_form.dart';
import 'package:tourbillon/libloc.dart' as tourbilloc;

import 'libloc.dart' as loc;
import 'user_access_view_model.dart';
import 'user_selector.dart';

/// A widget that allows to manage user access for a specific resource of for
/// the whole app.
///
/// This widget requires a [UserAccessViewModel] to be passed in the constructor,
/// and will update whenever the view model notifies that new data is available.
class UserAccessView extends StatelessWidget {
  final String? resource;
  final List<String>? roles;
  final UserAccessViewModel viewModel;
  final bool allowEmailsForResource;

  const UserAccessView({
    required this.viewModel,
    this.roles,
    Key? key,
  })  : resource = null,
        allowEmailsForResource = false,
        super(key: key);

  const UserAccessView.forResource(
    String resource, {
    required this.viewModel,
    bool allowEmails = false,
    this.roles,
    Key? key,
    // ignore: prefer_initializing_formals
  })  : resource = resource,
        allowEmailsForResource = allowEmails,
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
        Text(
          loc.libloc(context).userResourceAccessViewTitle(resource!),
          style: Theme.of(context).textTheme.headline2,
        ),
        if (allowEmailsForResource)
          _EmailAddressRoleAdd(
            viewModel,
            resource: resource!,
            roles: roles,
          ),
        UserSelector(
          viewModel,
          onUserSelected: (user) => viewModel.addUser(
            user.uid,
            email: user.email,
            resource: resource,
          ),
        ),
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
        Text(
          loc.libloc(context).userAccessViewTitle,
          style: Theme.of(context).textTheme.headline2,
        ),
        _EmailAddressRoleAdd(
          viewModel,
          roles: roles,
        ),
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
        subtitle: user.roles.isNotEmpty
            ? Text(
                user.roles.join(', '),
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
          if (widget.roles != null)
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
            onPressed: valid ? _addInvite : null,
            child: Text(tourbilloc.libloc(context).addButtonLabel),
          ),
        ],
      );

  void _addInvite() => widget.viewModel.addInvite(
        _controller.text,
        resource: widget.resource,
        roles: role != null ? [role!] : [],
      );
}
