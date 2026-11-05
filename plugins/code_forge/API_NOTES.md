# Editor API notes

Reference notes retained from upstream code_forge 10.14.0

## lib/code_forge/code_area.dart

FlClash's code editor, with syntax highlighting, code folding, a line
number gutter, auto-indentation, bracket pairing, undo/redo, word
completion and search.
The controller for managing the editor's text content and selection.
The finder controller for managing search functionality.

If not provided, an internal finder controller will be created.
The controller for managing undo/redo operations.
The syntax highlighting theme as a map of token types to [TextStyle].
The programming language mode for syntax highlighting.

Determines which language syntax rules to apply.
The base text style for the editor content.

Defines the font family, size, and other text properties.
Padding inside the editor content area.
Styling options for text selection and cursor.
Whether the editor is in read-only mode.

When true, the user cannot modify the text content.
Whether to wrap long lines.

When true, lines wrap at the editor boundary. When false,
horizontal scrolling is enabled.
The text style of the line numbers. Defaults to [textStyle]; a missing
color comes from [editorTheme].
Custom tabSize for the editor.
Defaults to 1 if using `\t`,
or 2 if using space, by setting the [useSpaceAsTab] to `true`
Use space instead of the `\t` character for tab key press.
Builder for a custom Finder widget.

This builder is called to create the finder/search widget. It provides
the [FindController] which can be used to control search functionality.
The returned widget should implement [PreferredSizeWidget].
The popup is laid over the whole editor and positions itself against
[CodeForgeSuggestionDetails.caretRect]; it is not built while the caret
is scrolled out of view. The editor keeps the arrow keys, Enter, Tab and
Escape.
Builds the loupe shown while a touch drags the caret, a selection handle
or a selection. The editor shows it in the root overlay, feeds it the
caret's [MagnifierInfo] in global coordinates and hides it through the
controller when the drag ends. No loupe is shown when null.
Creates a [CodeForge] code editor widget.
The on-screen rows of the selection, in global coordinates; null when
the selection is collapsed or scrolled out of view.
On mobile, also asks for the menu again, now for the whole document, the
way the platform toolbars stay up after select all.
1-based.
The entry Enter or Tab accepts, or null when none is highlighted.

## lib/code_forge/controller.dart

What changed since the last [CodeForgeController.takeChange].
Typing in the line buffer, which reaches [lines] once it flushes.
From `line` on, `removed` line breaks gave way to `inserted`.
Reopens the input connection so the platform drops its composition.
Controller for the [CodeForge] code editor widget.

This controller manages the text content, selection state, and various
editing operations for the code editor. It implements [DeltaTextInputClient]
to handle text input from the platform.

The controller uses a rope data structure internally for efficient text
manipulation, especially for large documents.

Example:
```dart
final controller = CodeForgeController();
controller.text = 'void main() {\n  print("Hello");\n}';

// Access selection
print(controller.selection);

// Get specific line
print(controller.getLineText(0)); // 'void main() {'
```
The completion popup's entries, or null while it is closed.
The entry of [suggestionsNotifier] Enter accepts. Starts at the first
entry on desktop; on mobile nothing is highlighted until the arrow keys
move it, so the soft keyboard's Enter still inserts a newline.
Whether the suggestions/completions are enabled or not.
Replaces the popup's document-word matching when set.
The text input connection to the platform.
The fold ranges the renderer has found, keyed by start line. The
renderer publishes them when a fold is toggled, so this is empty until
then.

Use the setter to update this map — it rebuilds internal sorted caches
used for O(log n) fold-region lookups.
Set fold ranges in the editor
In document order.
Whether the editor is in read-only mode.

When true, the user cannot modify the text content.
Use space instead of the `\t` character for tab key press.
Custom tabSize for the editor.
The tabspace inserted on tab key press.
Sets the undo controller for this editor.

The undo controller manages the undo/redo history for text operations.
Pass null to disable undo/redo functionality.
The complete text content of the editor.

Getting this property returns the full document text.
Setting this property replaces all content and moves the cursor to the end.
The total length of the document in characters.
The current text selection in the editor.

For a cursor with no selection, [TextSelection.isCollapsed] will be true.
Returns a window of lines without allocating the full buffer.
The total number of lines in the document.
Gets the text content of a specific line.

[lineIndex] is zero-based (0 for the first line).
Returns the text of the line without the newline character.
Gets the line number (zero-based) for a character offset.

[charOffset] is the character position in the document.
Returns the line index containing that character.
Gets the character offset where a line starts.

[lineIndex] is zero-based (0 for the first line).
Returns the character offset of the first character in that line.
Lines break at LF alone, and a line's text leaves out the CR of a CRLF
pair that its offsets still count, so CRLF text comes in as LF.
Keeps the undo history; a caller loading another file clears it.
Clamped to the document; a composition in progress is committed first.
Adds a listener that will be called when the controller state changes.

Listeners are notified on text changes, selection changes, and other
state updates.
Removes a previously added listener.
Notifies all registered listeners of a state change.
Whether an IME composition (e.g. CJK pinyin/kana) is currently in
progress. While true, the platform input method owns the keyboard, so
hardware-key handlers must defer to it and external selection changes
must finalize the composition first.
Commits a composition in progress where it is shown, so positions read
from the layout afterwards line up with the document.
[later] puts the notification off for a caller inside a build or dispose.
The active IME composition overlay, or null when no composition is in
progress. Read by the renderer to paint the composing string.
Disposes of the controller and releases resources.

Call this method when the controller is no longer needed to prevent
memory leaks.

## lib/code_forge/controller/editing.dart

Moves the current line up by one line.

If the selection spans multiple lines, all selected lines are moved.
The selection is adjusted accordingly after the move.
Does nothing if the line is already at the top or if the controller is read-only.
Moves the current line down by one line.

If the selection spans multiple lines, all selected lines are moved.
The selection is adjusted accordingly after the move.
Does nothing if the line is already at the bottom or if the controller is read-only.
Duplicates the current line or selected text.

If text is selected, duplicates the selected text.
If no selection, duplicates the line at the cursor position.
The cursor is moved to the end of the duplicated content.
Does nothing if the controller is read-only.
Copies the selection, or the caret's whole line when nothing is selected.
Leaves the text when the clipboard refuses it, or when the document, the
selection or read-only changes before the clipboard has it.
Pastes over the selection; a whole line from [copy] goes above the caret's.
Remove the selection or last char if the selection is empty (backspace key)
Remove the selection or the char at cursor position (delete key)
Replace a range of text with new text.
Rewrites the document as [text] in one edit over only what differs.
Also deletes the spaces between the word and the caret.
At a line start, joins the line with the previous one.

## lib/code_forge/controller/folding.dart

Toggles the fold state at the specified line number.

[lineNumber] is zero-indexed (0 for the first line). A line that starts
no fold region is ignored.

Throws [StateError] if no editor is mounted on this controller.

Example:
```dart
controller.toggleFold(5); // Toggle fold at line 6
```
Scrolls the editor view to make the specified line visible.

[line] is zero-indexed (0 for the first line). The editor will scroll
vertically to bring the specified line into view, centering it if possible.

If the line is within a folded region, the fold will be expanded first
to make the line visible.

Throws [StateError] if the editor has not been initialized.
Throws [RangeError] if [line] is out of bounds.

Example:
```dart
// Scroll to line 50 (1-indexed line 51)
controller.scrollToLine(50);

// Scroll to the first line
controller.scrollToLine(0);
```
Check whether the corresponding [lineIndex] is inside a folded code block or not.
if the corresponding line is in a foldable region, this function returns the first line in that foldable block.
Lines [startIndex] + 1 to [endIndex] hide while [isFolded].
The nested folds that folding this one opened, to refold when it unfolds.

## lib/code_forge/controller/navigation.dart

Moves the cursor one character to the left.

If [isShiftPressed] is true, extends the selection.
Moves the caret to the start of the word before it, or over the line
break when it is at a line start.
Moves the cursor up one line, maintaining the column position.

If [isShiftPressed] is true, extends the selection.
Moves the cursor down one line, maintaining the column position.

If [isShiftPressed] is true, extends the selection.
Moves the cursor to the beginning of the current line.

If [isShiftPressed] is true, extends the selection to the line start.
Moves the cursor to the end of the current line.

If [isShiftPressed] is true, extends the selection to the line end.
Moves the cursor to the beginning of the document.

If [isShiftPressed] is true, extends the selection to the document start.
Moves the cursor to the end of the document.

If [isShiftPressed] is true, extends the selection to the document end.
[offset], or where the caret lands instead when a fold hides its line:
past the fold going [forward], else on the line that heads the fold.
Selects all text in the editor.

## lib/code_forge/find_controller.dart

Controller for managing text search functionality in [CodeForge].

This controller handles searching for text, navigating through matches,
and highlighting results in the editor.
Creates a [FindController] associated with the given [CodeForgeController].
Whether the search covered the whole text.
The number of matches found for the current query.
The current match index (0-based) or -1 if no match is selected.
The case sensitivity of the search.
Whether the search uses regular expressions.
Whether the search matches whole words only.
Whether the finder is currently active/visible.
Whether the replace mode is active.
Sets the case sensitivity of the search.
Sets whether the search uses regular expressions.
Sets whether the search matches whole words only.
Sets whether the finder is currently active/visible.
Sets whether the replace mode is active.
Opens the panel, or focuses its field again when it is already open.
Performs a text search.

[query] is the text to search for.
[scrollToMatch] determines if the editor should scroll to the selected match.
Moves to the next match.
Moves to the previous match.
Replaces the currently selected match with the text in [replaceInputController].
Replaces all matches with the text in [replaceInputController].

## lib/code_forge/scroll.dart

A custom two-dimensional viewport for the code editor.

This viewport is used internally by [CodeForge] to enable both vertical
and horizontal scrolling within the editor. It delegates to a
[Render2DCodeField] for layout.
Creates a [CustomViewport] with the required scroll offsets and axes.
The render object for the code editor's two-dimensional viewport.

This class handles the layout of the code editor content and manages
the content dimensions for both vertical and horizontal scrolling.
Creates a [Render2DCodeField] with the required scroll configuration.

## lib/code_forge/styling.dart

This class provides styling options for code selection in the code editor.
The color of the cursor line, defaults to the highlight theme text color.
The color used to highlight selected text in the code editor.
The color of the cursor bubble that appears when selecting text.
This class provides styling options for the Gutter.
The background color of the gutter bar.
The color of the fold indicator icons. Defaults to the line number color.
The text style of the line numbers. Defaults to the editor's text style;
a missing color comes from the theme.

## lib/code_forge/undo_redo.dart

Represents a single edit operation that can be undone/redone.
Designed to work efficiently with rope data structures.
The cursor position before this edit
The cursor position after this edit
Timestamp when this edit was made
Create the inverse operation for undo
Check if this operation can be merged with another (for grouping rapid edits)
Merge this operation with another
An insertion operation
Position where text was inserted
The text that was inserted
[text]'s length in Unicode scalars, the unit [offset] counts in.
A deletion operation
Position where deletion started
The text that was deleted
A replacement operation (delete + insert at same position)
Position where replacement started
The text that was deleted
The text that was inserted
Controller for managing undo/redo operations.

Usage:
```dart
final undoController = UndoRedoController();

CodeForge(
controller: controller,
undoController: undoController,
)

// Undo last operation
undoController.undo();

// Redo last undone operation
undoController.redo();
```
How many entries fell off the bottom of [undoStack], so a compound
operation begun before one did still finds where it started.
Callback to apply an edit operation to the text
Whether an undo/redo operation is currently in progress
When set, the next recorded edit will not be merged into the previous
one. Used so that the first edit inside a compound operation never merges
into an edit recorded before the compound began (which would let it
escape the group).
Whether undo is available
Whether redo is available
Check if an undo/redo operation is currently being applied
Set the callback to apply edit operations; without one, [undo] and
[redo] leave the history as it is.
Clears [callback] unless another owner has set its own since.
Record an edit operation. Called by the controller when text changes.
Undo the last operation
Redo the last undone operation
Clear all undo/redo history
Begin a compound operation that should be undone as a single unit.
Call [CompoundOperationHandle.end] when done.
A handle over the latest entry, so that what is recorded until it ends
is undone together with that entry.
Handle for grouping multiple edits into a single undo operation.
End the compound operation, combining all recorded edits into one.
A compound operation that groups multiple edits into one undo unit.
