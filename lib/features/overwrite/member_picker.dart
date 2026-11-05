import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// Keeps selection order: fallback groups try their members in this order.
class ProxyMemberPicker extends StatefulWidget {
  final String title;
  final List<String> available;
  final List<String> selected;

  const ProxyMemberPicker({
    super.key,
    required this.title,
    required this.available,
    required this.selected,
  });

  @override
  State<ProxyMemberPicker> createState() => _ProxyMemberPickerState();
}

class _ProxyMemberPickerState extends State<ProxyMemberPicker> {
  late final List<String> _selected = widget.selected.toSet().toList();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final available = widget.available.toSet();
    final selectedOrder = {
      for (final (index, name) in _selected.indexed) name: index,
    };
    final query = _query.trim().toLowerCase();
    final names = <String>{
      ...available,
      ..._selected,
    }.where((name) => name.toLowerCase().contains(query)).toList();
    return CommonDialog(
      maxWidth: 480,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      title: widget.title,
      overrideScroll: true,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(appLocalizations.cancel),
        ),
        FilledButton(
          onPressed: () =>
              Navigator.of(context).pop(List<String>.from(_selected)),
          child: Text('${appLocalizations.confirm} (${_selected.length})'),
        ),
      ],
      child: SizedBox(
        height: 400,
        child: Column(
          children: [
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: appLocalizations.search,
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: names.isEmpty
                  ? Center(child: Text(appLocalizations.noSearchResult))
                  : ListView.builder(
                      itemCount: names.length,
                      itemBuilder: (context, index) {
                        final name = names[index];
                        final order = selectedOrder[name] ?? -1;
                        return CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(name),
                          subtitle: !available.contains(name)
                              ? Text(appLocalizations.outboundUnavailable)
                              : order >= 0
                              ? Text('#${order + 1}')
                              : null,
                          value: order >= 0,
                          onChanged: (checked) => setState(() {
                            if (checked == true) {
                              _selected.add(name);
                            } else {
                              _selected.remove(name);
                            }
                          }),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
