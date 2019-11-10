import 'package:baltichack_app/screens/Catalog.dart';
import 'package:flutter/material.dart';
import 'package:baltichack_app/screens/Home.dart';

class ScreenFilterArgs {
  final MapEntry<Pref, List<Filter>> filters;

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
    StateSetter stateSetterParent,
  }) {
    Widget trailing;
    Function() onTap = () {};
    Widget subtitle;

    switch (mFilter.type) {
      case FilterType.Check:
        final DataCheck data = mFilter.data;

        trailing = Checkbox(
          value: data.checked,
          onChanged: (val) {
            data.checked = val;
            setState(() {});
            if (stateSetter != null) stateSetter(() {});
            if (stateSetterParent != null) stateSetterParent(() {});
          },
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

        final DataDialogNumber data = mFilter.data;

        if (data.number != null) subtitle = Text(data.number.toString());

        int num = 1;
        TextEditingController numController = TextEditingController();

        onTap = () => showModalBottomSheet(
            context: ctx,
            builder: (BuildContext ctx) => StatefulBuilder(
                  builder: (ctx, StateSetter stateSetter) => SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () => stateSetter(() =>
                                            numController.text =
                                                (num - 1).toString()),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          onChanged: (_num) => stateSetter(
                                              () => num = int.parse(_num)),
                                          controller: numController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () => stateSetter(() =>
                                            numController.text =
                                                (num + 1).toString()),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: MaterialButton(
                                minWidth: 335,
                                height: 47,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(
                                      color: Color.fromRGBO(82, 129, 185, 1.0),
                                    )),
                                color: Color.fromRGBO(82, 129, 185, 1.0),
                                child: Text(
                                  'Подтвердить',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                onPressed: () {
                                  data.number = num;
                                  Navigator.of(ctx).pop();
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ));
        break;
      case FilterType.DialogChecks:
        trailing = _buildArrowIcon();

        final List<Filter> data = mFilter.data;

        List<String> subheaderArr = [];

        for (Filter i in data) {
          final DataCheck data = i.data;
          if (data.checked) subheaderArr.add(i.name + '');
        }

        if (subheaderArr.isNotEmpty) subtitle = Text(subheaderArr.join(', '));

        onTap = () => showModalBottomSheet(
            context: ctx,
            builder: (BuildContext ctx) => StatefulBuilder(
                  builder: (BuildContext ctx, StateSetter stateSetter) {
                    return Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Wrap(
                        children: data
                            .map<Widget>((_mFilter) => _buildFilterWidget(
                                ctx, _mFilter,
                                mParentFilter: mFilter,
                                stateSetter: setState,
                                stateSetterParent: stateSetter))
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
                  padding: EdgeInsets.only(bottom: 10),
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
      bottomSheet: Center(
        heightFactor: 1,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: MaterialButton(
            minWidth: 335,
            height: 47,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0), side: BorderSide()),
            color: Colors.black,
            child: Text(
              'Подтвердить',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(ctx).push(ScreenCatalog.createRouteCatalog(
                  ScreenCatalogArgs(args.filters)));
            },
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Filters'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: args.filters.value
            .map<Widget>((mFilter) => _buildFilterWidget(ctx, mFilter))
            .toList(),
      ),
    );
  }
}
