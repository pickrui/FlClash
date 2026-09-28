import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/services/cloud_api_service.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'cloud_layout.dart';
import 'node_filter_widgets.dart';

const _previewDelay = Duration(milliseconds: 400);
const _twoPaneWidth = 880.0;
const _patternMaxLength = 255;
// Panel node names are Chinese in every UI language, so the examples are too.
const _nameContainsExample = '香港|日本';
const _nameExcludesExample = '测试|维护';

enum _Submission { save, reset }

/// Edits the account's node filter. Pops with the catalog the panel returned
/// after a save or reset, or with nothing when the filter was left alone.
class CloudNodeFilterPage extends ConsumerStatefulWidget {
  const CloudNodeFilterPage({super.key});

  @override
  ConsumerState<CloudNodeFilterPage> createState() =>
      _CloudNodeFilterPageState();
}

class _CloudNodeFilterPageState extends ConsumerState<CloudNodeFilterPage> {
  late final CloudNodeFilterApi _api;
  late final CloudAccountNotifier _account;
  final _matchController = TextEditingController();
  final _nomatchController = TextEditingController();
  final _searchController = TextEditingController();
  Timer? _previewTimer;
  var _previewRequest = 0;

  var _loading = true;
  Object? _loadError;
  NodeFilterCatalog? _base;
  NodeFilter _draft = const NodeFilter();
  NodeFilterCatalog? _preview;
  NodeFilter _previewFilter = const NodeFilter();
  var _previewInFlight = false;
  String? _previewError;
  _Submission? _submitting;

  @override
  void initState() {
    super.initState();
    _api = ref.read(cloudNodeFilterApiProvider);
    _account = ref.read(cloudAccountProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _load();
    });
  }

  @override
  void dispose() {
    _previewTimer?.cancel();
    _matchController.dispose();
    _nomatchController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    _previewTimer?.cancel();
    _previewRequest++;
    setState(() {
      _loading = true;
      _loadError = null;
    });
    try {
      final catalog = await _api.fetchNodeFilter();
      if (!mounted) return;
      _matchController.text = catalog.filter.match;
      _nomatchController.text = catalog.filter.nomatch;
      setState(() {
        _base = catalog;
        _draft = catalog.filter;
        _preview = catalog;
        _previewFilter = catalog.filter;
        _previewInFlight = false;
        _previewError = null;
      });
    } catch (e) {
      await _handleUnauthorized(e);
      if (mounted) setState(() => _loadError = e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<bool> _handleUnauthorized(Object error) async {
    if (CloudApiException.isHandledUnauthorized(error)) return true;
    if (!CloudApiException.isUnauthorized(error)) return false;
    await _account.handleUnauthorized();
    return true;
  }

  void _edit(NodeFilter draft) {
    setState(() {
      _draft = draft;
      _previewError = null;
    });
    _previewTimer?.cancel();
    _previewTimer = Timer(_previewDelay, _runPreview);
  }

  Future<void> _runPreview() async {
    final filter = _draft;
    final request = ++_previewRequest;
    if (filter == _previewFilter) {
      setState(() {
        _previewInFlight = false;
        _previewError = null;
      });
      return;
    }
    setState(() => _previewInFlight = true);
    try {
      final catalog = await _api.previewNodeFilter(filter);
      if (!mounted || request != _previewRequest) return;
      setState(() {
        _preview = catalog;
        _previewFilter = filter;
        _previewInFlight = false;
      });
    } catch (e) {
      if (!mounted || request != _previewRequest) return;
      final handled = await _handleUnauthorized(e);
      if (!mounted || request != _previewRequest) return;
      setState(() {
        _previewInFlight = false;
        _previewError = handled ? null : CloudApiException.clean(e);
      });
    }
  }

  bool get _previewSettled =>
      !_previewInFlight &&
      _previewError == null &&
      (_previewTimer?.isActive != true) &&
      _draft == _previewFilter;

  bool get _canSave =>
      _submitting == null &&
      _previewSettled &&
      _draft != _base?.filter &&
      (_preview?.kept ?? 0) > 0;

  bool get _canReset => _submitting == null && _base?.customized == true;

  Future<void> _submit(
    _Submission kind,
    Future<NodeFilterCatalog?> Function() action,
  ) async {
    if (_submitting != null) return;
    setState(() => _submitting = kind);
    try {
      final catalog = await action();
      unawaited(_account.refreshManagedSubscription());
      if (!mounted) return;
      Navigator.of(context).pop(catalog ?? _savedFallback(kind));
    } catch (e) {
      if (await _handleUnauthorized(e)) return;
      globalState.showNotifier(CloudApiException.clean(e));
    } finally {
      if (mounted) setState(() => _submitting = null);
    }
  }

  NodeFilterCatalog? _savedFallback(_Submission kind) {
    final preview = _preview;
    if (kind == _Submission.reset || preview == null) return null;
    return NodeFilterCatalog(
      customized: !_draft.isEmpty,
      filter: _draft,
      lines: preview.lines,
      regions: preview.regions,
      nodes: preview.nodes,
      kept: preview.kept,
      total: preview.total,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: context.appLocalizations.nodeFilter,
      isLoading: _submitting != null,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_loading && _base == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final base = _base;
    if (base == null || _loadError != null) {
      return _buildMessage(
        context,
        icon: Icons.cloud_off,
        message: CloudApiException.clean(_loadError ?? ''),
        isError: true,
      );
    }
    if (!base.available || base.nodes.isEmpty) {
      return _buildMessage(
        context,
        icon: Icons.filter_alt_off_outlined,
        message: context.appLocalizations.noData,
      );
    }
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) =>
                constraints.maxWidth >= _twoPaneWidth
                ? _buildTwoPanes(context)
                : _buildOnePane(context),
          ),
        ),
        _buildActions(context),
      ],
    );
  }

  Widget _buildMessage(
    BuildContext context, {
    required IconData icon,
    required String message,
    bool isError = false,
  }) {
    final colorScheme = context.colorScheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 40,
                color: isError ? colorScheme.error : colorScheme.outline,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.tonalIcon(
                icon: const Icon(Icons.refresh),
                label: Text(context.appLocalizations.refresh),
                onPressed: _loading ? null : _load,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnePane(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: CloudContentWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildNote(context),
            const SizedBox(height: 16),
            NodeFilterPanel(child: _buildFilters(context)),
            const SizedBox(height: 16),
            NodeFilterPanel(child: _buildPreview(context, expand: false)),
          ],
        ),
      ),
    );
  }

  Widget _buildTwoPanes(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1120),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 11,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildNote(context),
                      const SizedBox(height: 16),
                      NodeFilterPanel(child: _buildFilters(context)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 9,
                child: NodeFilterPanel(
                  child: _buildPreview(context, expand: true),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNote(BuildContext context) {
    final colorScheme = context.colorScheme;
    final style = context.textTheme.bodySmall?.copyWith(
      color: colorScheme.onSurfaceVariant,
      height: 1.5,
    );
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: colorScheme.secondaryContainer.withValues(alpha: 0.45),
        shape: AppShape.all(AppCorner.md),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.info_outline,
              size: 18,
              color: colorScheme.onSecondaryContainer,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                context.appLocalizations.nodeFilterAccountNote,
                style: style,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    final l10n = context.appLocalizations;
    final catalog = _preview ?? _base!;
    final editable = _submitting == null;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLegend(context),
          if (catalog.lines.isNotEmpty) ...[
            const SizedBox(height: 20),
            NodeFilterSectionTitle(l10n.nodeFilterLines),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final line in catalog.lines)
                  NodeFilterChoiceChip(
                    label: line.name,
                    count: line.count,
                    choice: _draft.lineChoice(line.key),
                    onTap: editable
                        ? () => _edit(_draft.cycleLine(line.key))
                        : null,
                  ),
              ],
            ),
          ],
          if (catalog.regions.isNotEmpty) ...[
            const SizedBox(height: 20),
            NodeFilterSectionTitle(l10n.nodeFilterRegions),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final region in catalog.regions)
                  NodeFilterChoiceChip(
                    label: [
                      region.emoji,
                      region.name,
                    ].where((part) => part.isNotEmpty).join(' '),
                    count: region.count,
                    choice: _draft.regionChoice(region.code),
                    onTap: editable
                        ? () => _edit(_draft.cycleRegion(region.code))
                        : null,
                  ),
              ],
            ),
          ],
          const SizedBox(height: 24),
          _buildPatternField(
            controller: _matchController,
            label: l10n.nodeFilterNameContains,
            hint: _nameContainsExample,
            enabled: editable,
            onChanged: (value) => _edit(_draft.copyWith(match: value)),
          ),
          const SizedBox(height: 16),
          _buildPatternField(
            controller: _nomatchController,
            label: l10n.nodeFilterNameExcludes,
            hint: _nameExcludesExample,
            enabled: editable,
            onChanged: (value) => _edit(_draft.copyWith(nomatch: value)),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(BuildContext context) {
    final l10n = context.appLocalizations;
    final arrow = Icon(
      Icons.arrow_forward,
      size: 14,
      color: context.colorScheme.outline,
    );
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        NodeFilterChoiceChip(
          label: l10n.nodeFilterAny,
          choice: NodeFilterChoice.any,
          dense: true,
        ),
        arrow,
        NodeFilterChoiceChip(
          label: l10n.nodeFilterOnly,
          choice: NodeFilterChoice.only,
          dense: true,
        ),
        arrow,
        NodeFilterChoiceChip(
          label: l10n.nodeFilterExclude,
          choice: NodeFilterChoice.exclude,
          dense: true,
        ),
      ],
    );
  }

  Widget _buildPatternField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool enabled,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      onChanged: onChanged,
      autocorrect: false,
      enableSuggestions: false,
      inputFormatters: [LengthLimitingTextInputFormatter(_patternMaxLength)],
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(
          color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );
  }

  Widget _buildPreview(BuildContext context, {required bool expand}) {
    final l10n = context.appLocalizations;
    final colorScheme = context.colorScheme;
    final catalog = _preview ?? _base!;
    final settled = _previewSettled;
    final query = _searchController.text.trim().toLowerCase();
    final nodes = query.isEmpty
        ? catalog.nodes
        : catalog.nodes
              .where((node) => node.name.toLowerCase().contains(query))
              .toList();
    final keptNone = settled && catalog.kept == 0;
    final state = _draft.isEmpty
        ? l10n.nodeFilterSmartSelection
        : l10n.nodeFilterCustomized;
    final header = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            NodeFilterSectionTitle(l10n.nodeFilterPreview),
            const SizedBox(width: 12),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!settled && _previewError == null) ...[
                    const SizedBox.square(
                      dimension: 14,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(
                      '$state · ${l10n.nodeFilterKept(catalog.kept, catalog.total)}',
                      textAlign: TextAlign.end,
                      style: context.textTheme.labelLarge?.copyWith(
                        color: keptNone
                            ? colorScheme.error
                            : colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (_previewError case final error?)
          _buildPreviewError(context, error)
        else if (keptNone)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              l10n.nodeFilterKeepOne,
              style: context.textTheme.bodySmall?.copyWith(
                color: colorScheme.error,
              ),
            ),
          ),
        const SizedBox(height: 12),
        TextField(
          controller: _searchController,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: l10n.nodeFilterSearch,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: query.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: MaterialLocalizations.of(
                      context,
                    ).clearButtonTooltip,
                    onPressed: () => setState(_searchController.clear),
                  ),
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
    final empty = Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Text(
        l10n.noData,
        textAlign: TextAlign.center,
        style: context.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
    final fade = settled ? 1.0 : 0.55;
    if (!expand) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            header,
            AnimatedOpacity(
              opacity: fade,
              duration: const Duration(milliseconds: 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: nodes.isEmpty
                    ? [empty]
                    : [for (final node in nodes) NodeFilterNodeRow(node: node)],
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          Expanded(
            child: AnimatedOpacity(
              opacity: fade,
              duration: const Duration(milliseconds: 150),
              child: nodes.isEmpty
                  ? Align(alignment: Alignment.topCenter, child: empty)
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 12),
                      itemCount: nodes.length,
                      itemBuilder: (_, index) =>
                          NodeFilterNodeRow(node: nodes[index]),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewError(BuildContext context, String error) {
    final colorScheme = context.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Icon(Icons.error_outline, size: 18, color: colorScheme.error),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              error,
              style: context.textTheme.bodySmall?.copyWith(
                color: colorScheme.error,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: context.appLocalizations.refresh,
            onPressed: () {
              setState(() => _previewError = null);
              _runPreview();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    final l10n = context.appLocalizations;
    Widget label(_Submission kind, String text) => _submitting == kind
        ? const SizedBox.square(
            dimension: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(text);
    final reset = OutlinedButton(
      onPressed: _canReset
          ? () => _submit(_Submission.reset, _api.resetNodeFilter)
          : null,
      child: label(_Submission.reset, l10n.restoreDefault),
    );
    final save = FilledButton(
      onPressed: _canSave
          ? () => _submit(_Submission.save, () => _api.saveNodeFilter(_draft))
          : null,
      child: label(_Submission.save, l10n.save),
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(color: context.colorScheme.outlineVariant),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= _twoPaneWidth) {
              return Align(
                alignment: Alignment.centerRight,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: Row(
                    children: [
                      Expanded(child: reset),
                      const SizedBox(width: 12),
                      Expanded(child: save),
                    ],
                  ),
                ),
              );
            }
            return CloudContentWidth(
              child: Row(
                children: [
                  Expanded(child: reset),
                  const SizedBox(width: 12),
                  Expanded(child: save),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
