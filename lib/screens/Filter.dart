import 'package:flutter/material.dart';
import 'package:baltichack_app/screens/Home.dart';

class ScreenFilterArgs {
  final List<Filter> filters;

  ScreenFilterArgs(this.filters);
}

class ScreenFilter extends StatefulWidget {
  static const route = '/screens/filter';

  final ScreenFilterArgs args;

  const ScreenFilter(this.args, {Key key}) : super(key: key);

  @override
  _ScreenFilterState createState() => _ScreenFilterState();
}

class _ScreenFilterState extends State<ScreenFilter> {
  ScreenFilterArgs get args => widget.args;

  Widget _buildArrowIcon() => Padding(
    child: Icon(Icons.keyboard_arrow_right),
    padding: EdgeInsets.only(right: 14),
  );

  Widget _buildFilterWidget(
    BuildContext ctx,
    Filter mFilter, {
    Filter mParentFilter,
    StateSetter stateSetter,
  }) {
    Widget trailing;
    Function() onTap = () {};
    Widget subtitle;

    switch (mFilter.type) {
      case FilterType.Check:
        final DataCheck data = mFilter.data;

        trailing = Checkbox(
          value: data.checked,
          onChanged: (val) => (stateSetter != null
              ? stateSetter
              : setState)(() => data.checked = val),
        );
        break;
      case FilterType.Radio:
        final DataDialogRadios parentData = mParentFilter.data;

        onTap = () => setState(() {
              subtitle = Text(mFilter.name);
              parentData.selected = mFilter;
              Navigator.of(ctx).pop();
            });
        break;
      case FilterType.DialogNumber:
        trailing = _buildArrowIcon();

        final List<Filter> data = mFilter.data;

        onTap = () => showModalBottomSheet(
            context: ctx,
            builder: (BuildContext ctx) => Container(
                  child: Wrap(
                    children: data
                        .map<Widget>((_mFilter) => _buildFilterWidget(
                            ctx, _mFilter,
                            mParentFilter: mFilter))
                        .toList(),
                  ),
                ));
        break;
      case FilterType.DialogChecks:
        trailing = _buildArrowIcon();

        final List<Filter> data = mFilter.data;

        onTap = () => showModalBottomSheet(
            context: ctx,
            builder: (BuildContext ctx) => StatefulBuilder(
                  builder: (BuildContext ctx, StateSetter stateSetter) {
                    return Container(
                      child: Wrap(
                        children: data
                            .map<Widget>((_mFilter) => _buildFilterWidget(
                                ctx, _mFilter,
                                mParentFilter: mFilter,
                                stateSetter: stateSetter))
                            .toList(),
                      ),
                    );
                  },
                ));
        break;
      case FilterType.DialogRadios:
        trailing = _buildArrowIcon();

        final DataDialogRadios data = mFilter.data;

        if (data.selected != null) subtitle = Text(data.selected.name);

        onTap = () => showModalBottomSheet(
            context: ctx,
            builder: (BuildContext ctx) => Container(
                  child: Wrap(
                    children: data.filters
                        .map<Widget>((_mFilter) => _buildFilterWidget(
                              ctx,
                              _mFilter,
                              mParentFilter: mFilter,
                            ))
                        .toList(),
                  ),
                ));
        break;
    }
    return ListTile(
      title: Text(mFilter.name),
      onTap: onTap,
      trailing: trailing,
      subtitle: subtitle,
    );
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: args.filters
            .map<Widget>((mFilter) => _buildFilterWidget(ctx, mFilter))
            .toList(),
      ),
    );
  }
}
