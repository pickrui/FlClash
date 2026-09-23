import 'dart:io';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/dav_client.dart';
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/dialog.dart';
import 'package:fl_clash/widgets/fade_box.dart';
import 'package:fl_clash/widgets/input.dart';
import 'package:fl_clash/widgets/list.dart';
import 'package:fl_clash/widgets/scaffold.dart';
import 'package:fl_clash/widgets/text.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BackupAndRestore extends ConsumerStatefulWidget {
  const BackupAndRestore({super.key});

  @override
  ConsumerState<BackupAndRestore> createState() => _BackupAndRestoreState();
}

class _BackupAndRestoreState extends ConsumerState<BackupAndRestore> {
  DAVProps? _clientDav;
  DAVClient? _client;

  String? _davSettingError(DAVProps dav) {
    if (!isValidDavUri(dav.uri)) return appLocalizations.addressTip;
    if (!isSafeDavFileName(dav.fileName)) {
      return appLocalizations.invalidBackupFile;
    }
    return null;
  }

  DAVClient _clientFor(DAVProps dav) {
    final cached = _client;
    if (cached != null && dav == _clientDav) return cached;
    final client = DAVClient(dav);
    _clientDav = dav;
    return _client = client;
  }

  void _showDavSettingError(String title, String error) {
    globalState.showMessage(
      title: title,
      message: TextSpan(text: error),
    );
  }

  Future<void> _showAddWebDAV(DAVProps? dav) async {
    await globalState.showCommonDialog<void>(child: WebDAVFormDialog(dav: dav));
  }

  Future<void> _backupOnWebDAV(DAVClient client) async {
    final commonAction = context.commonAction;
    final backupAction = context.backupAction;

    final res = await commonAction.loadingRun<bool>(
      () async {
        final path = await backupAction.backup();
        if (path.isEmpty) {
          return false;
        }
        try {
          return await client.backup(path);
        } finally {
          await File(path).safeDelete();
        }
      },
      tag: LoadingTag.backup_restore,
      title: appLocalizations.backup,
    );
    if (res != true) return;
    globalState.showMessage(
      title: appLocalizations.backup,
      message: TextSpan(text: appLocalizations.backupSuccess),
    );
  }

  Future<void> _restoreOnWebDAV(DAVClient client, RestoreOption option) async {
    final commonAction = context.commonAction;
    final backupAction = context.backupAction;

    final res = await commonAction.loadingRun<bool>(
      () async {
        final path = await client.restore();
        try {
          await backupAction.restore(option, backupPath: path);
          return true;
        } finally {
          await File(path).safeDelete();
        }
      },
      tag: LoadingTag.backup_restore,
      title: appLocalizations.restore,
    );
    if (res != true) return;
    globalState.showMessage(
      title: appLocalizations.restore,
      message: TextSpan(text: appLocalizations.restoreSuccess),
    );
  }

  Future<void> _handleRestoreOnWebDAV(DAVClient client) async {
    final restoreOption = await globalState.showCommonDialog<RestoreOption>(
      child: const RestoreOptionsDialog(),
    );
    if (restoreOption == null || !mounted) return;
    _restoreOnWebDAV(client, restoreOption);
  }

  Future<void> _backupOnLocal() async {
    final commonAction = context.commonAction;
    final backupAction = context.backupAction;

    final res = await commonAction.loadingRun<bool>(
      () async {
        final path = await backupAction.backup();
        if (path.isEmpty) {
          return false;
        }
        try {
          final value = await picker.saveFileWithPath(
            utils.getBackupFileName(),
            path,
          );
          if (value == null) return false;
          return true;
        } finally {
          await File(path).safeDelete();
        }
      },
      title: appLocalizations.backup,
      tag: LoadingTag.backup_restore,
    );
    if (res != true) return;
    globalState.showMessage(
      title: appLocalizations.backup,
      message: TextSpan(text: appLocalizations.backupSuccess),
    );
  }

  Future<void> _restoreOnLocal(RestoreOption option) async {
    final commonAction = context.commonAction;
    final backupAction = context.backupAction;

    final file = await picker.pickerFile(withData: false);
    final path = file?.path;
    if (path == null) return;
    final res = await commonAction.loadingRun<bool>(
      () async {
        await backupAction.restore(option, backupPath: path);
        return true;
      },
      tag: LoadingTag.backup_restore,
      title: appLocalizations.restore,
    );
    if (res != true) return;
    globalState.showMessage(
      title: appLocalizations.restore,
      message: TextSpan(text: appLocalizations.restoreSuccess),
    );
  }

  Future<void> _handleRestoreOnLocal() async {
    final option = await globalState.showCommonDialog<RestoreOption>(
      child: const RestoreOptionsDialog(),
    );
    if (option == null || !mounted) return;
    _restoreOnLocal(option);
  }

  void _handleChange(String? value) {
    if (value == null || !isSafeDavFileName(value)) {
      if (value != null) {
        globalState.showNotifier(appLocalizations.invalidBackupFile);
      }
      return;
    }
    ref
        .read(davSettingProvider.notifier)
        .update((state) => state?.copyWith(fileName: value));
  }

  Future<void> _handleUpdateRestoreStrategy() async {
    final restoreStrategy = ref.read(
      appSettingProvider.select((state) => state.restoreStrategy),
    );
    final res = await globalState.showCommonDialog(
      child: OptionsDialog<RestoreStrategy>(
        title: appLocalizations.restoreStrategy,
        options: RestoreStrategy.values,
        textBuilder: (mode) => Intl.message('restoreStrategy_${mode.name}'),
        value: restoreStrategy,
      ),
    );
    if (res == null) {
      return;
    }
    ref
        .read(appSettingProvider.notifier)
        .update((state) => state.copyWith(restoreStrategy: res));
  }

  @override
  Widget build(BuildContext context) {
    final dav = ref.watch(davSettingProvider);
    final isLoading = ref.watch(loadingProvider(LoadingTag.backup_restore));
    final davError = dav == null ? null : _davSettingError(dav);
    final client = dav == null || davError != null ? null : _clientFor(dav);
    return CommonScaffold(
      isLoading: isLoading,
      title: appLocalizations.backupAndRestore,
      body: ListView(
        children: [
          ListHeader(title: appLocalizations.remote),
          if (dav == null)
            ListItem(
              leading: const Icon(Icons.account_box),
              title: Text(appLocalizations.noInfo),
              subtitle: Text(appLocalizations.pleaseBindWebDAV),
              trailing: FilledButton.tonal(
                onPressed: () {
                  _showAddWebDAV(dav);
                },
                child: Text(appLocalizations.bind),
              ),
            )
          else ...[
            ListItem(
              leading: const Icon(Icons.account_box),
              title: TooltipText(
                text: Text(
                  dav.user,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(appLocalizations.connectivity),
                    FutureBuilder<bool>(
                      future: client?.pingCompleter.future,
                      builder: (_, snapshot) {
                        return Center(
                          child: FadeThroughBox(
                            child:
                                client != null &&
                                    snapshot.connectionState !=
                                        ConnectionState.done
                                ? const SizedBox(
                                    width: 12,
                                    height: 12,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: snapshot.data == true
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    width: 12,
                                    height: 12,
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              trailing: FilledButton.tonal(
                onPressed: () {
                  _showAddWebDAV(dav);
                },
                child: Text(appLocalizations.edit),
              ),
            ),
            const SizedBox(height: 4),
            ListItem.input(
              title: Text(appLocalizations.file),
              subtitle: Text(dav.fileName),
              delegate: InputDelegate(
                title: appLocalizations.file,
                value: dav.fileName,
                resetValue: defaultDavFileName,
                maxLength: TextInputLimits.fileName,
                onChanged: _handleChange,
              ),
            ),
            ListItem(
              onTap: () {
                if (client == null) {
                  _showDavSettingError(appLocalizations.backup, davError!);
                  return;
                }
                _backupOnWebDAV(client);
              },
              title: Text(appLocalizations.backup),
              subtitle: Text(appLocalizations.remoteBackupDesc),
            ),
            ListItem(
              onTap: () {
                if (client == null) {
                  _showDavSettingError(appLocalizations.restore, davError!);
                  return;
                }
                _handleRestoreOnWebDAV(client);
              },
              title: Text(appLocalizations.restore),
              subtitle: Text(appLocalizations.restoreFromWebDAVDesc),
            ),
          ],
          ListHeader(title: appLocalizations.local),
          ListItem(
            onTap: _backupOnLocal,
            title: Text(appLocalizations.backup),
            subtitle: Text(appLocalizations.localBackupDesc),
          ),
          ListItem(
            onTap: _handleRestoreOnLocal,
            title: Text(appLocalizations.restore),
            subtitle: Text(appLocalizations.restoreFromFileDesc),
          ),
          ListHeader(title: appLocalizations.options),
          Consumer(
            builder: (_, ref, _) {
              final restoreStrategy = ref.watch(
                appSettingProvider.select((state) => state.restoreStrategy),
              );
              return ListItem(
                onTap: _handleUpdateRestoreStrategy,
                title: Text(appLocalizations.restoreStrategy),
                trailing: FilledButton(
                  onPressed: _handleUpdateRestoreStrategy,
                  child: Text(
                    Intl.message('restoreStrategy_${restoreStrategy.name}'),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class RestoreOptionsDialog extends StatefulWidget {
  const RestoreOptionsDialog({super.key});

  @override
  State<RestoreOptionsDialog> createState() => _RestoreOptionsDialogState();
}

class _RestoreOptionsDialogState extends State<RestoreOptionsDialog> {
  void _handleOnTab(RestoreOption? option) {
    if (option == null) return;
    Navigator.of(context).pop(option);
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: appLocalizations.restore,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Wrap(
        children: [
          ListItem(
            onTap: () {
              _handleOnTab(RestoreOption.onlyProfiles);
            },
            title: Text(appLocalizations.restoreOnlyConfig),
          ),
          ListItem(
            onTap: () {
              _handleOnTab(RestoreOption.all);
            },
            title: Text(appLocalizations.restoreAllData),
          ),
        ],
      ),
    );
  }
}

class WebDAVFormDialog extends ConsumerStatefulWidget {
  final DAVProps? dav;

  const WebDAVFormDialog({super.key, this.dav});

  @override
  ConsumerState<WebDAVFormDialog> createState() => _WebDAVFormDialogState();
}

class _WebDAVFormDialogState extends ConsumerState<WebDAVFormDialog> {
  late TextEditingController _uriController;
  late TextEditingController _userController;
  late TextEditingController _passwordController;
  bool _obscurePassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _uriController = TextEditingController(text: widget.dav?.uri);
    _userController = TextEditingController(text: widget.dav?.user);
    _passwordController = TextEditingController(text: widget.dav?.password);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final fileName = widget.dav?.fileName;
    ref.read(davSettingProvider.notifier).value = DAVProps(
      uri: _uriController.text,
      user: _userController.text,
      password: _passwordController.text,
      fileName: fileName != null && isSafeDavFileName(fileName)
          ? fileName
          : defaultDavFileName,
    );
    Navigator.pop(context);
  }

  void _delete() {
    ref.read(davSettingProvider.notifier).value = null;
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _uriController.dispose();
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: appLocalizations.webDAVConfiguration,
      actions: [
        if (widget.dav != null)
          TextButton(onPressed: _delete, child: Text(appLocalizations.delete)),
        TextButton(onPressed: _submit, child: Text(appLocalizations.save)),
      ],
      child: Form(
        key: _formKey,
        child: Wrap(
          runSpacing: 16,
          children: [
            TextFormField(
              controller: _uriController,
              inputFormatters: TextInputLimits.limit(TextInputLimits.uri),
              maxLines: 5,
              minLines: 1,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.link),
                border: const OutlineInputBorder(),
                labelText: appLocalizations.address,
                helperText: appLocalizations.addressHelp,
              ),
              validator: (String? value) {
                if (value == null || !isValidDavUri(value)) {
                  return appLocalizations.addressTip;
                }
                return null;
              },
            ),
            TextFormField(
              controller: _userController,
              inputFormatters: TextInputLimits.limit(TextInputLimits.userName),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.account_circle),
                border: const OutlineInputBorder(),
                labelText: appLocalizations.account,
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return appLocalizations.emptyTip(appLocalizations.account);
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              inputFormatters: TextInputLimits.limit(TextInputLimits.password),
              obscureText: _obscurePassword,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password),
                border: const OutlineInputBorder(),
                suffixIcon: VisibilityToggleButton(
                  obscureText: _obscurePassword,
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
                labelText: appLocalizations.password,
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return appLocalizations.emptyTip(appLocalizations.password);
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
