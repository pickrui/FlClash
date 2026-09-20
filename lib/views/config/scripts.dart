import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/javascript.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/pages/editor.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/providers/state.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/input.dart';
import 'package:fl_clash/widgets/list.dart';
import 'package:fl_clash/widgets/null_status.dart';
import 'package:fl_clash/widgets/pop_scope.dart';
import 'package:fl_clash/widgets/scaffold.dart';
import 'package:fl_clash/widgets/theme.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScriptsView extends ConsumerStatefulWidget {
  const ScriptsView({super.key});

  @override
  ConsumerState<ScriptsView> createState() => _ScriptsViewState();
}

class _ScriptsViewState extends ConsumerState<ScriptsView> {
  final _key = utils.id;

  Future<void> _handleDelScript(int id) async {
    final setupAction = context.setupAction;

    final res = await globalState.showMessage(
      message: TextSpan(
        text: appLocalizations.deleteTip(appLocalizations.script),
      ),
    );
    if (res != true) {
      return;
    }
    List<int> affectedProfileIds = const [];
    await storageLock.synchronized(() async {
      final path = await appPath.getScriptPath(id.toString());
      affectedProfileIds = await commitScriptDeletion(
        scriptPath: path,
        scriptId: id,
        commit: () => runExclusiveDatabaseOperation(
          () => database.deleteScriptAndClearReferences(id),
        ),
      );
      ref
          .read(profilesProvider.notifier)
          .replaceFromDatabase(await database.profilesDao.all().get());
      ref
          .read(scriptsProvider.notifier)
          .replaceFromDatabase(await database.scriptsDao.all().get());
    });
    ref.read(appSettingProvider.notifier).update((state) {
      final options = Map<String, Map<String, bool>>.from(state.scriptOptions)
        ..remove('$id');
      return state.copyWith(scriptOptions: options);
    });
    ref.read(selectedItemProvider(_key).notifier).value = null;
    if (affectedProfileIds.contains(ref.read(currentProfileIdProvider))) {
      await setupAction.applyProfile(force: true);
    }
  }

  void _handleSelected(int id) {
    ref.read(selectedItemProvider(_key).notifier).update((value) {
      if (value == id) {
        return null;
      }
      return id;
    });
  }

  Widget _buildContent(List<Script> scripts, int? selectedScriptId) {
    if (scripts.isEmpty) {
      return NullStatus(
        illustration: NullStatusIllustration.scripts,
        label: appLocalizations.nullTip(appLocalizations.script),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: scripts.length,
      itemBuilder: (_, index) {
        final script = scripts[index];
        return CommonSelectedListItem(
          isSelected: selectedScriptId == script.id,
          title: Text(
            script.label,
            style: context.textTheme.bodyLarge,
            maxLines: 3,
          ),
          onSelected: () {
            _handleSelected(script.id);
          },
          onPressed: () {
            _handleSelected(script.id);
          },
        );
      },
    );
  }

  Future<void> _handleEditorSave(
    BuildContext _,
    String title,
    String content, {
    Script? script,
  }) async {
    Script newScript =
        (script?.copyWith(label: title) ?? Script.create(label: title));
    if (newScript.label.isEmpty) {
      final res = await globalState.showCommonDialog<String>(
        child: InputDialog(
          title: appLocalizations.save,
          value: '',
          hintText: appLocalizations.pleaseEnterScriptName,
          inputFormatters: TextInputLimits.limit(TextInputLimits.name),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return appLocalizations.emptyTip(appLocalizations.name);
            }
            if (value != script?.label) {
              final isExits = ref.read(scriptsProvider.notifier).isExits(value);
              if (isExits) {
                return appLocalizations.existsTip(appLocalizations.name);
              }
            }
            return null;
          },
        ),
      );
      if (res == null || res.isEmpty) {
        return;
      }
      newScript = newScript.copyWith(label: res);
    }
    if (newScript.label != script?.label) {
      final isExits = ref
          .read(scriptsProvider.notifier)
          .isExits(newScript.label);
      if (isExits) {
        globalState.showMessage(
          message: TextSpan(
            text: appLocalizations.existsTip(appLocalizations.name),
          ),
        );
        return;
      }
    }
    await storageLock.synchronized(() async {
      await withFileRollback(
        await appPath.getScriptPath(newScript.id.toString()),
        () async {
          newScript = await newScript.save(content);
          await ref
              .read(scriptsProvider.notifier)
              .put(newScript, reportOnWait: false);
        },
      );
    });
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<bool> _handleEditorPop(
    BuildContext _,
    String title,
    String content,
    String raw, {
    Script? script,
  }) async {
    if (content == raw) {
      return true;
    }
    final res = await globalState.showMessage(
      message: TextSpan(text: appLocalizations.saveChanges),
    );
    if (res == true && mounted) {
      _handleEditorSave(context, title, content, script: script);
    } else {
      return true;
    }
    return false;
  }

  void _handleToEditor([int? id]) async {
    final script = await ref.read(scriptProvider(id).future);
    final title = script?.label ?? '';
    final raw = (await script?.content) ?? scriptTemplate;
    if (!mounted) {
      return;
    }
    BaseNavigator.push(
      context,
      EditorPage(
        titleEditable: true,
        title: title,
        supportRemoteDownload: true,
        onSave: (context, title, content) {
          _handleEditorSave(context, title, content, script: script);
        },
        onPop: (context, title, content) {
          return _handleEditorPop(context, title, content, raw, script: script);
        },
        languages: const [Language.javaScript],
        content: raw,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scripts = ref.watch(scriptsProvider).value ?? [];
    final selectedScriptId = ref.watch(selectedItemProvider(_key));
    return CommonPopScope(
      onPop: (_) {
        if (selectedScriptId != null) {
          ref.read(selectedItemProvider(_key).notifier).value = null;
          return false;
        }
        Navigator.of(context).pop();
        return false;
      },
      child: CommonScaffold(
        actions: [
          if (selectedScriptId != null) ...[
            IconButton(
              tooltip: appLocalizations.scriptOptions,
              icon: const Icon(Icons.tune),
              onPressed: () {
                final script = scripts.get(selectedScriptId);
                if (script != null) {
                  BaseNavigator.push(
                    context,
                    ScriptOptionsPage(script: script),
                  );
                }
              },
            ),
            CommonMinIconButtonTheme(
              child: IconButton.filledTonal(
                onPressed: () {
                  _handleDelScript(selectedScriptId);
                },
                icon: const Icon(Icons.delete),
              ),
            ),
            const SizedBox(width: 2),
          ],
          CommonMinFilledButtonTheme(
            child: selectedScriptId != null
                ? FilledButton(
                    onPressed: () {
                      _handleToEditor(selectedScriptId);
                    },
                    child: Text(appLocalizations.edit),
                  )
                : FilledButton.tonal(
                    onPressed: () {
                      _handleToEditor();
                    },
                    child: Text(appLocalizations.add),
                  ),
          ),
          const SizedBox(width: 8),
        ],
        body: _buildContent(scripts, selectedScriptId),
        title: appLocalizations.script,
      ),
    );
  }
}

class ScriptOptionsPage extends ConsumerStatefulWidget {
  final Script script;
  const ScriptOptionsPage({super.key, required this.script});

  @override
  ConsumerState<ScriptOptionsPage> createState() => _ScriptOptionsPageState();
}

class _ScriptOptionsPageState extends ConsumerState<ScriptOptionsPage> {
  Map<String, bool>? _defaults;
  Map<String, bool> _values = {};
  String? _error;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final content = await widget.script.content;
      if (content == null) throw StateError('Script file is unavailable');
      final defaults = await extractScriptOptions(content);
      if (!mounted) return;
      final saved =
          ref.read(appSettingProvider).scriptOptions['${widget.script.id}'] ??
          const {};
      setState(() {
        _defaults = defaults;
        _values = {
          for (final entry in defaults.entries)
            entry.key: saved[entry.key] ?? entry.value,
        };
      });
    } catch (error) {
      if (mounted) setState(() => _error = error.toString());
    }
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final setup = context.setupAction;
    try {
      ref.read(appSettingProvider.notifier).update((state) {
        final options = Map<String, Map<String, bool>>.from(
          state.scriptOptions,
        );
        final overrides = {
          for (final entry in _values.entries)
            if (entry.value != _defaults![entry.key]) entry.key: entry.value,
        };
        if (overrides.isEmpty) {
          options.remove('${widget.script.id}');
        } else {
          options['${widget.script.id}'] = overrides;
        }
        return state.copyWith(scriptOptions: options);
      });
      if (ref.read(currentProfileProvider)?.scriptId == widget.script.id) {
        await setup.applyProfile(force: true);
      }
      if (mounted) Navigator.of(context).pop();
    } catch (error) {
      if (mounted) context.showNotifier(error.toString());
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.appLocalizations;
    return CommonScaffold(
      title: l10n.scriptOptions,
      actions: [
        if (_defaults?.isNotEmpty == true) ...[
          TextButton(
            onPressed: _saving
                ? null
                : () => setState(() => _values = Map.from(_defaults!)),
            child: Text(l10n.reset),
          ),
          TextButton(onPressed: _saving ? null : _save, child: Text(l10n.save)),
        ],
      ],
      body: _error != null
          ? Center(child: Text(_error!))
          : _defaults == null
          ? const Center(child: CircularProgressIndicator())
          : _defaults!.isEmpty
          ? Center(child: Text(l10n.scriptOptionsEmpty))
          : ListView(
              children: [
                for (final entry in _values.entries)
                  ListItem.switchItem(
                    title: Text(entry.key),
                    delegate: SwitchDelegate(
                      value: entry.value,
                      onChanged: _saving
                          ? null
                          : (value) =>
                                setState(() => _values[entry.key] = value),
                    ),
                  ),
              ],
            ),
    );
  }
}
