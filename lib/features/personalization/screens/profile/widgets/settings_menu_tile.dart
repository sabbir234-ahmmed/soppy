
import 'package:flutter/material.dart';


class SettingsMenuTile extends StatelessWidget {
  const SettingsMenuTile({
    super.key, required this.icon, required this.title, required this.subTitle, required this.onTap,
  });

  ///variables for  customizing
  final IconData icon;
  final String title;
  final String subTitle;
  final VoidCallback  onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon),
        title: Text( title, style: Theme.of(context).textTheme.titleMedium,),
        subtitle: Text(subTitle, style: Theme.of(context).textTheme.labelMedium,),

      ),
    );
  }
}