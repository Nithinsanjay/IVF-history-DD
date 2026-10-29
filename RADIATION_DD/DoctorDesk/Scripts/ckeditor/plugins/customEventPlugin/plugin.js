CKEDITOR.plugins.add('customEventPlugin', {
    init: function (editor) {
        if (editor._customEventsAttached) return;
        editor._customEventsAttached = true;
        function isSpace(ch) {
            return ch === '\u00A0' || ch === ' ';
        }
        function getTextNodeAndOffset(range) {
            var node = range.startContainer;
            var offset = range.startOffset;
            if (node.type !== CKEDITOR.NODE_TEXT) {
                node = node.getChild(offset);
                offset = 0;
                while (node && node.type !== CKEDITOR.NODE_TEXT) {
                    if (node.hasChildren && node.hasChildren()) {
                        node = node.getChild(0);
                    } else {
                        node = null;
                    }
                }
            }
            return { node, offset };
        }
        function getTextFromContainer(container) {
            if (!container) return '';
            if (container.type === CKEDITOR.NODE_TEXT) return container.getText();
            if (container.hasChildren && container.hasChildren() && container.getChildCount() > 0) {
                for (var k = 0; k < container.getChildCount(); k++) {
                    var child = container.getChild(k);
                    if (child.type === CKEDITOR.NODE_TEXT) return child.getText();
                }
            }
            return '';
        }
        editor.on('paste', function (evt) {
            var pastedText = evt.data.dataValue;
            if (pastedText && pastedText.indexOf('&lt;') !== -1) {
                var cleaned = pastedText.replace(/&lt;(?![\s\u00A0]|&nbsp;)/g, '<\u00A0');
                evt.data.dataValue = cleaned;
            }
        });
        editor.on('contentDom', function () {
            var editable = editor.editable();
            if (!editable) return;
            editable.attachListener(editable, 'keypress', function (evt) {
                const key = evt.data.getKey ? evt.data.getKey() : evt.data.$ && evt.data.$.which;
                const char = key ? String.fromCharCode(key) : null;
                if (!char) return;
                const sel = editor.getSelection();
                const ranges = sel.getRanges();
                if (!ranges.length) return;
                const range = ranges[0];
                var info = getTextNodeAndOffset(range);
                var container = info.node;
                var offset = info.offset;
                if (!container) return;
                var text = container.getText();
                const charBefore = text.charAt(offset - 1);
                const charAtCursor = text.charAt(offset);
                const charAfter = text.charAt(offset + 1);
                if (char === '<') {
                    evt.data.preventDefault && evt.data.preventDefault();
                    editor.insertText('<\u00A0');
                    return false;
                }
                if (charBefore === '<' && (!isSpace(charAtCursor) || !isSpace(charAfter))) {
                    evt.data.preventDefault && evt.data.preventDefault();
                    editor.insertText('\u00A0' + char);
                    return false;
                }
            });
            ['click', 'keyup', 'keypress', 'keydown'].forEach(function (eventType) {
                editable.attachListener(editable, eventType, function (evt) {
                    if (['keypress', 'keydown', 'keyup'].indexOf(eventType) === -1) return;
                    var keyCode = evt.data.getKey ? evt.data.getKey() : null;
                    var selection = editor.getSelection();
                    var ranges = selection.getRanges();
                    if (!ranges.length) return;
                    var range = ranges[0];
                    var info = getTextNodeAndOffset(range);
                    var container = info.node;
                    var offset = info.offset;
                    if (!container) return;
                    var text = container.getText();
                    var charBefore = text.charAt(offset - 1);
                    var charBefore2 = text.charAt(offset - 2);
                    var charAtCursor = text.charAt(offset);
                    var charAfter = text.charAt(offset + 1);
                    var textLength = text.length;
                    if (eventType === 'keydown' && keyCode === 8) {
                        if (offset >= 2 && isSpace(charBefore) && charBefore2 === '<') {
                            range.setStart(container, offset - 2);
                            range.setEnd(container, offset);
                            range.deleteContents();
                            selection.selectRanges([range]);
                            evt.data && evt.data.preventDefault && evt.data.preventDefault();
                            return false;
                        }
                        if (offset >= 1 && charBefore === '<') {
                            range.setStart(container, offset - 1);
                            range.setEnd(container, offset);
                            range.deleteContents();
                            selection.selectRanges([range]);
                            evt.data && evt.data.preventDefault && evt.data.preventDefault();
                            return false;
                        }
                    }
                    if (eventType === 'keydown' && keyCode === 37) {
                        if (offset >= 2 && isSpace(charBefore) && charBefore2 === '<') {
                            range.setStart(container, offset - 2);
                            range.collapse(true);
                            selection.selectRanges([range]);
                            evt.data && evt.data.preventDefault && evt.data.preventDefault();
                            return false;
                        }
                    }
                    if (eventType === 'keydown' && keyCode === 39) {
                        if (offset < text.length - 1 && charAtCursor === '<' && isSpace(charAfter)) {
                            range.setStart(container, offset + 2);
                            range.collapse(true);
                            selection.selectRanges([range]);
                            evt.data && evt.data.preventDefault && evt.data.preventDefault();
                            return false;
                        }
                    }
                    if (offset >= 1) {
                        var before = text.charAt(offset - 1);
                        var after = text.charAt(offset);

                        if (before === '<' && isSpace(after)) {
                            var typedChar = null;
                            if (eventType === 'keypress' && evt.data && evt.data.getKey) {
                                var key = evt.data.getKey();
                                if (key) typedChar = String.fromCharCode(key);
                            }
                            if (!typedChar && evt.data && evt.data.$ && evt.data.$.which) {
                                typedChar = String.fromCharCode(evt.data.$.which);
                            }
                            if (!typedChar && evt.data && evt.data.$ && evt.data.$.key) {
                                typedChar = evt.data.$.key;
                            }
                            if (typedChar && /^[a-zA-Z]$/.test(typedChar)) {
                                range.setStart(container, offset);
                                range.setEnd(container, offset + 1);
                                range.deleteContents();
                                selection.selectRanges([range]);
                                return false;
                            }
                        }
                        if (before === '<') {
                            if (/^[a-zA-Z]$/.test(after) || isSpace(after)) {
                                return false;
                            }
                            range.setStart(container, offset);
                            range.setEnd(container, Math.min(offset + 1, textLength));
                            range.deleteContents();
                            editor.insertText('\u00A0');
                            return false;
                        }
                        var before2 = text.charAt(offset - 2);
                        if (before2 === '<' && isSpace(before) && isSpace(after)) {
                            range.setStart(container, offset - 1);
                            range.setEnd(container, offset);
                            range.deleteContents();
                            selection.selectRanges([range]);
                            return false;
                        }
                    }
                    if (eventType === 'keyup' && keyCode === 8) {
                        if (charBefore === '<' && isSpace(charAtCursor)) {
                            range.setStart(container, offset - 1);
                            range.setEnd(container, offset + 1);
                            range.deleteContents();
                            selection.selectRanges([range]);
                            return false;
                        }
                    }
                });
            });
        });
    }
});