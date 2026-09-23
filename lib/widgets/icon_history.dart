import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/database/database.dart';
import 'package:material_ui/material_ui.dart';

import 'dialog.dart';
import 'icon.dart';

class IconHistoryDialog extends StatefulWidget {
  const IconHistoryDialog({super.key});

  @override
  State<IconHistoryDialog> createState() => _IconHistoryDialogState();
}

class _IconHistoryDialogState extends State<IconHistoryDialog> {
  late Future<List<IconRecord>> _records = database.iconRecordsDao.query('');

  @override
  Widget build(BuildContext context) => CommonDialog(
    title: context.appLocalizations.iconHistory,
    maxWidth: 480,
    overrideScroll: true,
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(context.appLocalizations.cancel),
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
              hintText: context.appLocalizations.search,
            ),
            onChanged: (value) =>
                setState(() => _records = database.iconRecordsDao.query(value)),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: FutureBuilder<List<IconRecord>>(
              future: _records,
              builder: (context, snapshot) {
                final records = snapshot.data ?? const [];
                if (records.isEmpty) {
                  return Center(
                    child: Text(context.appLocalizations.noSearchResult),
                  );
                }
                return ListView.builder(
                  itemCount: records.length,
                  itemBuilder: (context, index) {
                    final record = records[index];
                    return ListTile(
                      leading: CommonTargetIcon(
                        src: record.url,
                        size: 28,
                        recordHistory: false,
                      ),
                      title: Text(
                        record.url,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () => Navigator.of(context).pop(record.url),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
