import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'libloc.dart';
import 'sign_in_manager.dart';

/// A widget that displays the currently signed-in user's name and icon.
///
/// This widget uses a [SignInManager] obtained through a [Provider] in the context.
/// If no user is currently signed in, this widget displays a sign-in button instead.
/// Both the user name and sign-in button text use [AppBarTheme.toolbarTextStyle]
/// if specified, [TextTheme.bodyText2] otherwise.
///
/// When there is a signed-in user and the user name is clicked, this widget
/// displays an overlay menu that contains more information on the current user,
/// has a link to a settings screen if [settingsRouteName] is specified, and allows
/// to sign out. The menu is displayed below the widget, and is right-aligned with the widget.
/// The menu uses [ThemeData.backgroundColor] as its background color, [TextTheme.subtitle1]
/// for the user name, and [TextTheme.caption] for the email address.
class UserProfile extends StatefulWidget implements PreferredSizeWidget {
  final String? settingsRouteName;

  const UserProfile({
    this.settingsRouteName,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserProfileState();

  @override
  Size get preferredSize => Size(200, 24);
}

class _UserProfileState extends State<UserProfile> {
  OverlayEntry? _menuOverlay;

  @override
  Widget build(BuildContext context) {
    final signIn = Provider.of<SignInManager>(context);
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: TextButton(
          onPressed: _toggleMenu,
          child: signIn.signedIn
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      signIn.shortUserDescription,
                      style: _textStyle,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              signIn.photoUrl,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Text(
                  libloc(context).signInButtonLabel,
                  style: _textStyle,
                ),
        ),
      ),
    );
  }

  TextStyle get _textStyle =>
      AppBarTheme.of(context).toolbarTextStyle ??
      Theme.of(context).primaryTextTheme.bodyMedium!;

  void _toggleMenu() {
    if (_menuOverlay != null) {
      _menuOverlay!.remove();
      _menuOverlay = null;
    } else {
      final signIn = context.read<SignInManager>();
      if (signIn.signedIn) {
        _menuOverlay = OverlayEntry(builder: (_) => _menu);
        Overlay.of(context).insert(_menuOverlay!);
      } else {
        signIn.signIn();
      }
    }
  }

  void _signOut() {
    Provider.of<SignInManager>(context, listen: false).signOut();
    _toggleMenu();
  }

  Widget get _menu {
    final signIn = context.read<SignInManager>();
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    return Positioned(
      top: offset.dy + renderBox.size.height,
      right: 0,
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        tooltip: MaterialLocalizations.of(context)
                            .closeButtonTooltip,
                        onPressed: _toggleMenu,
                      ),
                      if (widget.settingsRouteName != null)
                        IconButton(
                          icon: Icon(Icons.settings),
                          tooltip: libloc(context).accountSettingsMenu,
                          onPressed: () {
                            _toggleMenu();
                            Navigator.of(context)
                                .pushNamed(widget.settingsRouteName!);
                          },
                        ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            signIn.photoUrl,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(signIn.shortUserDescription,
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Text(signIn.userEmail,
                      style: Theme.of(context).textTheme.bodySmall),
                  TextButton(
                    child: Text(libloc(context).signOutButtonLabel),
                    onPressed: _signOut,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
