// ========================== KeySnail Init File =========================== //

// You can preserve your code in this area when generating the init file using GUI.
// Put all your code except special key, set*key, hook, blacklist.
// ========================================================================= //
//{{%PRESERVE%

plugins.options["twitter_client.keymap"] = {
    "C-z"   : "prompt-toggle-edit-mode",
    "SPC"   : "prompt-next-page",
    "b"     : "prompt-previous-page",
    "j"     : "prompt-next-completion",
    "k"     : "prompt-previous-completion",
    "g"     : "prompt-beginning-of-candidates",
    "G"     : "prompt-end-of-candidates",
    "q"     : "prompt-cancel",
    // local
    "t"     : "tweet",
    "r"     : "reply",
    "R"     : "retweet",
    "D"     : "delete-tweet",
    "f"     : "add-to-favorite",
    "v"     : "display-entire-message",
    "V"     : "view-in-twitter",
    "c"     : "copy-tweet",
    "i"     : "copy-user-id",
    "*"     : "show-target-status",
    "@"     : "show-mentions",
    "/"     : "search-word",
    "o"     : "open-url,n",
    "d"     : "send-direct-message",
    "+"     : "show-conversations",
    "h"     : "refresh-or-back-to-timeline",
    "s"     : "switch-to"
};

plugins.options["twitter_client.lists"] = 
    ["nishikawasasaki/kdl", "nishikawasasaki/list"];


// 外部エディタの設定
key.setEditKey(["C-c", "e"], function (ev, arg) {
        ext.exec("edit_text", arg);
}, "外部エディタで編集", true);
plugins.options["K2Emacs.editor"] = "/Applications/Emacs.app";
plugins.options["K2Emacs.ext"] = "html";
plugins.options["K2Emacs.encode"] = "UTF-8"
plugins.options["K2Emacs.sep"] = "/";


// ヒントの見た目設定
plugins.options["hok.hint_base_style"] = {
    "position"       : 'absolute',
    "z-index"        : '2147483647',
    "color"          : '#000',
    "font-family"    : 'VL_Gothic',
    "font-size"      : '8pt',
    "font-weight"    : 'bold',
    "line-height"    : '10pt',
    "padding"        : '2px',
    "margin"         : '1px',
    "text-transform" : 'uppercase'
};

plugins.options["hok.hint_color_link"]    = 'rgba(210, 210, 210, 0.6)';
plugins.options["hok.hint_color_form"]    = 'rgba(210, 210, 210, 0.6)';
plugins.options["hok.hint_color_focused"] = 'rgba(255, 82, 93, 0.6)';





// Tombloo連携でGoogleReader
// local["^http://www.google.(co.jp|com)/reader/view/"] = [
//     // Your local keybind settings here
//     ["r", function () {
//          let link = content.document.querySelector("#current-entry a.entry-title-link");
//          if (link && plugins.kungfloo)
//              plugins.kungfloo.reblog(link, false, false, ["FFFFOUND", "Flickr", "Tumblr"]);
//      }]
// ];



// Site local keymap {{ ===================================================== //

var local = {};
plugins.options["remap_pages.local_keymap"] = local;

function fake(k, i) function () { key.feed(k, i); };
function pass(k, i) [k, fake(k, i)];
function ignore(k, i) [k, null];

local["^https?://mail.google.com/mail/"] = [
    pass(['g', 'i'], 3),
    pass(['g', 's'], 3),
    pass(['g', 't'], 3),
    pass(['g', 'd'], 3),
    pass(['g', 'a'], 3),
    pass(['g', 'b'], 3),
    pass(['g', 'c'], 3),
    pass(['g', 'k'], 3),
    // thread list
    pass(['*', 'a'], 3),
    pass(['*', 'n'], 3),
    pass(['*', 'r'], 3),
    pass(['*', 'u'], 3),
    pass(['*', 's'], 3),
    pass(['*', 't'], 3),
    // navigation
    ['u', null],
    ['k', null],
    ['j', null],
    ['o', null],
    ['p', null],
    ['n', null],
    // application
    ['c', null],
    ['/', null],
    ['q', null],
    ['?', null],
    // manipulation
    ['x', null],
    ['s', null],
    ['y', null],
    ['e', null],
    ['m', null],
    ['!', null],
    ['#', null],
    ['r', null],
    ['R', null],
    ['a', null],
    ['A', null],
    ['f', null],
    ['F', null],
    ['N', null],
    pass(['<tab>', 'RET'], 3),
    ['ESC', null],
    [']', null],
    ['[', null],
    ['z', null],
    ['.', null],
    ['I', null],
    ['U', null],
    ['C-s', null],
    ['T', null]
];






// 辞書引き
(function () {
    function googleSuggest(word) {
        const domain = "com";
        const base = "http://www.google.%s/complete/search?output=toolbar&q=%s";

        let ep  = util.format(base, domain, encodeURIComponent(word));
        let res = util.httpGet(ep);

        let matched = res.responseText.match("(<toplevel>.*</toplevel>)");

        if (!matched)
            return null;

        let xml = new XML(matched[1]);

        return [cs.suggestion.@data for each (cs in xml.CompleteSuggestion)];
    }

    function googleCompleter(args, extra) {
        let suggestions = googleSuggest(extra.query || "");

        return { collection : suggestions, origin : extra.whole.indexOf(extra.left) };
    }

    shell.add("udic", "Urban dictionary", function (args, extra) {
        const base = "http://www.urbandictionary.com/define.php?term=%s";

        util.setBoolPref("accessibility.browsewithcaret", false);
        gBrowser.loadOneTab(util.format(base, encodeURIComponent(args[0])),
                            null, null, null, extra.bang);
    }, { bang: true, completer: googleCompleter });

    shell.add("goodic", M({ja: "Goo 辞書", en: "Goo dic"}), function (args, extra) {
        const base = "http://dictionary.goo.ne.jp/search.php?MT=%s&kind=all&mode=0&IE=UTF-8";

        util.setBoolPref("accessibility.browsewithcaret", false);
        gBrowser.loadOneTab(util.format(base, encodeURIComponent(args[0])),
                            null, null, null, extra.bang);
    }, { bang: true, completer: googleCompleter });

    shell.add("weblio", M({ja: "Weblio", en: "Weblio"}), function (args, extra) {
        const base = "http://ejje.weblio.jp/content/%s";

        util.setBoolPref("accessibility.browsewithcaret", false);
        gBrowser.loadOneTab(util.format(base, encodeURIComponent(args[0])),
                            null, null, null, extra.bang);
    }, { bang: true, completer: googleCompleter });







})();



// promptで自動日本語入力オフ
style.register(<><![CDATA[
    #keysnail-prompt-textbox *|input {
        ime-mode : inactive !important;
    }
]]></>);




//}}%PRESERVE%
// ========================================================================= //

// ========================= Special key settings ========================== //

key.quitKey              = "C-g";
key.helpKey              = "<f1>";
key.escapeKey            = "C-q";
key.macroStartKey        = "<f3>";
key.macroEndKey          = "<f4>";
key.universalArgumentKey = "C-u";
key.negativeArgument1Key = "C--";
key.negativeArgument2Key = "C-M--";
key.negativeArgument3Key = "M--";
key.suspendKey           = "<f2>";

// ================================= Hooks ================================= //

hook.setHook('KeyBoardQuit', function (aEvent) {
    if (key.currentKeySequence.length) {
        return;
    }
    command.closeFindBar();
    var marked = command.marked(aEvent);
    if (util.isCaretEnabled()) {
        if (marked) {
            command.resetMark(aEvent);
        } else {
            if ("blur" in aEvent.target) {
                aEvent.target.blur();
            }
            gBrowser.focus();
            _content.focus();
        }
    } else {
        goDoCommand("cmd_selectNone");
    }
    if (KeySnail.windowType === "navigator:browser" && !marked) {
        key.generateKey(aEvent.originalTarget, KeyEvent.DOM_VK_ESCAPE, true);
    }
});



// ============================= Key bindings ============================== //

key.setGlobalKey('C-M-r', function (ev) {
    userscript.reload();
}, '設定ファイルを再読み込み', true);

key.setGlobalKey('M-x', function (ev, arg) {
    ext.select(arg, ev);
}, 'エクステ一覧表示', true);

key.setGlobalKey('M-:', function (ev) {
    command.interpreter();
}, 'JavaScript のコードを評価', true);

key.setGlobalKey(['<f1>', 'b'], function (ev) {
    key.listKeyBindings();
}, 'キーバインド一覧を表示');

key.setGlobalKey(['<f1>', 'F'], function (ev) {
    openHelpLink("firefox-help");
}, 'Firefox のヘルプを表示');

key.setGlobalKey('C-m', function (ev) {
    key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_RETURN, true);
}, 'リターンコードを生成');

key.setGlobalKey(['C-x', 'l'], function (ev) {
    command.focusToById("urlbar");
}, 'ロケーションばーへ移動', true);

key.setGlobalKey(['C-x', 'g'], function (ev) {
    command.focusToById("searchbar");
}, '検索バーへフォーカス', true);

key.setGlobalKey(['C-x', 's'], function (ev) {
    command.focusElement(command.elementsRetrieverButton, 0);
}, '最初のボタンへフォーカス', true);

key.setGlobalKey(['C-x', 'k'], function (ev) {
    BrowserCloseTabOrWindow();
}, 'タブ / ウィンドウを閉じる');

key.setGlobalKey(['C-x', 'K'], function (ev) {
    closeWindow(true);
}, 'ウィンドウを閉じる');

key.setGlobalKey(['C-x', 'n'], function (ev) {
    OpenBrowserWindow();
}, 'ウィンドウを開く');

key.setGlobalKey(['C-x', 'C-c'], function (ev) {
    goQuitApplication();
}, 'Firefox を終了', true);

key.setGlobalKey(['C-x', 'o'], function (ev, arg) {
    command.focusOtherFrame(arg);
}, '次のフレームを選択');

key.setGlobalKey(['C-x', '1'], function (ev) {
    window.loadURI(ev.target.ownerDocument.location.href);
}, '現在のフレームだけを表示', true);

key.setGlobalKey(['C-x', 'C-f'], function (ev) {
    BrowserOpenFileWindow();
}, 'ファイルを開く', true);

key.setGlobalKey(['C-x', 'C-s'], function (ev) {
    saveDocument(window.content.document);
}, 'ファイルを保存', true);

key.setGlobalKey([['C-x', 'u'], ['C-c', 'u']], function (ev) {
    undoCloseTab();
}, '閉じたタブを元に戻す');

key.setGlobalKey(['C-x', 'T'], function (ev, arg) {
    ext.exec("twitter-client-tweet-this-page", arg, ev);
}, 'このページのタイトルと URL を使ってつぶやく', true);

key.setGlobalKey(['C-c', 'C-c', 'C-v'], function (ev) {
    toJavaScriptConsole();
}, 'Javascript コンソールを表示', true);

key.setGlobalKey(['C-c', 'C-c', 'C-c'], function (ev) {
    command.clearConsole();
}, 'Javascript コンソールの表示をクリア', true);

key.setGlobalKey(['C-c', 'c'], function () {
    var templates = {
        titleAndGoogle: "{0} {2}",
        titleAndUrl: "{0} {1}",
        title: "{0}",
        URL: "{1}",
        hatena: "[{1}:title={0}]"
    };

    function getLineSeprator() {
        var sysInfo = Cc['@mozilla.org/system-info;1'].getService(Ci.nsIPropertyBag2);
        var platform = sysInfo.getProperty("name");
        if (platform.indexOf("Windows") >= 0) {
            return "\r\n";
        } else {
            return "\n";
        }
    }


    function getGoogl(long_url) {
        var req = new XMLHttpRequest;
        req.addEventListener("load", function () {
            var response = JSON.parse(req.responseText);
            liberator.echo(response.short_url);
            util.copyToClipboard("\"" + buffer.title + "\" " + response.short_url, true);
        },
        false);
        req.addEventListener("error", function () {
            liberator.echo("Responce errror status from goo.gl. Status Code:" + req.status);
        },
        false);
        req.open("POST", "http://goo.gl/api/shorten?url=" + encodeURIComponent(long_url));
        req.setRequestHeader("X-Auth-Google-Url-Shortener", "true");
        req.send();
    }

    var regexp = /\{(\d)\}/g;

    function format() {
        var args = Array.prototype.slice.apply(arguments);
        var format = args.shift();
        return format && format.replace(regexp, function () {
            return args[arguments[1]] || "";
        });
    }

    var promptList = [];
    for (var key in templates) {
        promptList.push([key, templates[key].replace(/\n/g, "\\n")]);
    }
    var title = window.content.document.title;
    var url = window.content.location.href;
    var shortUrl = getGoogl(url);
    prompt.selector({
        message: "copy from: ",
        flags: [0, 0],
        collection: promptList,
        header: ["key", "format"],
        callback: function (index) {
            if (index < 0) {
                return;
            }
            var key = promptList[index][0];
            var template = templates[key].replace(/\n/g, getLineSeprator());
            var text = format(template, title, url, shortUrl);
            Cc['@mozilla.org/widget/clipboardhelper;1'].getService(Ci.nsIClipboardHelper).copyString(text);
        }
    });
}, 'URLとタイトルをコピー');

key.setGlobalKey(['C-c', 'l'], function () {
    var promptList = [];
    var w = Application.activeWindow;
    var tabs = Array.apply(null, w.tabs);
    for each(var tab in tabs) {
        promptList.push([tab.document.title, tab.uri.spec]);
    }
    prompt.selector({
        message: "select tab: ",
        flags: [0, 0],
        collection: promptList,
        header: ["title", "url"],
        callback: function (index) {
            if (index < 0 || tabs.length < index) {
                return;
            }
            tabs[index].focus();
        }
    });
}, 'タブを検索する');

key.setGlobalKey('M-w', function (ev) {
    command.copyRegion(ev);
}, '選択中のテキストをコピー', true);

key.setGlobalKey('C-s', function (ev) {
    command.iSearchForwardKs(ev);
}, 'Emacs ライクなインクリメンタル検索', true);

key.setGlobalKey('M-r', function (ev) {
    var appStartup = Cc['@mozilla.org/toolkit/app-startup;1'].getService(Ci.nsIAppStartup);
    appStartup.quit(appStartup.eRestart | appStartup.eAttemptQuit);
}, 'Firefox を再起動');

key.setGlobalKey('C-M-l', function (ev) {
    getBrowser().mTabContainer.advanceSelectedTab(1, true);
}, 'ひとつ右のタブへ');

key.setGlobalKey('C-M-h', function (ev) {
    getBrowser().mTabContainer.advanceSelectedTab(-1, true);
}, 'ひとつ左のタブへ');

key.setGlobalKey('C-r', function (ev) {
    command.iSearchBackwardKs(ev);
}, 'Emacs ライクな逆方向インクリメンタル検索', true);

key.setGlobalKey('C-k', function (ev) {
    var title = window.content.document.title;
    var url = window.content.location.href;
    shortenURL(url);

    function shortenURL(url) {
        const id = "nishikawasasaki";
        const key = "R_f98fc7f3de321a2511d0b01fa37a3a38";
        var endPointUrl = "http://api.bit.ly/v3/shorten?longUrl=" + url + "&login=" + id + "&apiKey=" + key + "&format=json";
        var obj = JSON.parse(util.httpGet(endPointUrl).responseText);
        command.setClipboardText("\"" + title + "\" " + obj.data.url);
        return 0;
    }

}, '短縮URLをGET', true);

key.setViewKey([['C-/'], ['u']], function (ev) {
    undoCloseTab();
}, '閉じたタブを元に戻す');

key.setViewKey('f', function (ev, arg) {
    ext.exec("hok-start-foreground-mode", arg, ev);
}, 'HoK - リンクをフォアグラウンドで開く', true);

key.setViewKey('F', function (ev, arg) {
    ext.exec("hok-start-background-mode", arg, ev);
}, 'HoK - リンクをバックグラウンドで開く', true);

key.setViewKey(';', function (aEvent, aArg) {
    ext.exec("hok-start-extended-mode", aArg);
}, 'HoK - 拡張ヒントモード', true);

key.setViewKey([['C-x', 't'], ['q']], function (ev, arg) {
    ext.exec("twitter-client-display-timeline", arg, ev);
}, 'TL を表示', true);

key.setViewKey(['C-x', 'h'], function (ev) {
    goDoCommand("cmd_selectAll");
}, 'すべて選択', true);

key.setViewKey('d', function (ev) {
    BrowserCloseTabOrWindow();
}, 'タブ / ウィンドウを閉じる');

key.setViewKey('H', function (ev) {
    BrowserBack();
}, '戻る');

key.setViewKey('L', function (ev) {
    BrowserForward();
}, '進む');

key.setViewKey([['C-n'], ['j']], function (aEvent) {
    for (var i = 0; i < 8; i++) {
        key.generateKey(aEvent.originalTarget, KeyEvent.DOM_VK_DOWN, true);
    }
}, '一行スクロールダウン');

key.setViewKey([['C-p'], ['k']], function (aEvent) {
    for (var i = 0; i < 8; i++) {
        key.generateKey(aEvent.originalTarget, KeyEvent.DOM_VK_UP, true);
    }
}, '一行スクロールアップ');

key.setViewKey('C-f', function (ev) {
    command.focusElement(command.elementsRetrieverTextarea, 0);
}, '最初のインプットエリアへフォーカス', true);

key.setViewKey('.', function (ev) {
    key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_RIGHT, true);
}, '右へスクロール');

key.setViewKey([['C-b'], [',']], function (ev) {
    key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_LEFT, true);
}, '左へスクロール');

key.setViewKey('M-v', function (ev) {
    goDoCommand("cmd_scrollPageUp");
}, '一画面分スクロールアップ');

key.setViewKey('C-v', function (ev) {
    goDoCommand("cmd_scrollPageDown");
}, '一画面スクロールダウン');

key.setViewKey([['M-<'], ['g']], function (ev) {
    goDoCommand("cmd_scrollTop");
}, 'ページ先頭へ移動', true);

key.setViewKey([['M->'], ['G']], function (ev) {
    goDoCommand("cmd_scrollBottom");
}, 'ページ末尾へ移動', true);

key.setViewKey('l', function (ev) {
    getBrowser().mTabContainer.advanceSelectedTab(1, true);
}, 'ひとつ右のタブへ');

key.setViewKey('h', function (ev) {
    getBrowser().mTabContainer.advanceSelectedTab(-1, true);
}, 'ひとつ左のタブへ');

key.setViewKey(':', function (ev, arg) {
    shell.input(null, arg);
}, 'コマンドの実行', true);

key.setViewKey('r', function (ev) {
    BrowserReload();
}, '更新', true);

key.setViewKey('M-p', function (ev) {
    command.walkInputElement(command.elementsRetrieverButton, true, true);
}, '次のボタンへフォーカスを当てる');

key.setViewKey('M-n', function (ev) {
    command.walkInputElement(command.elementsRetrieverButton, false, true);
}, '前のボタンへフォーカスを当てる');

key.setViewKey('t', function (ev, arg) {
    shell.input("tabopen ");
}, 'tabopen');

key.setViewKey('c', function (ev, arg) {
    ext.exec("list-hateb-comments", arg);
}, 'はてなブックマークのコメントを一覧表示', true);

key.setViewKey('a', function (ev, arg) {
    ext.exec("hateb-bookmark-this-page");
}, 'このページをはてなブックマークに追加', true);

key.setViewKey('b', function (ev, arg) {
    ext.exec("tanything", arg);
}, 'view all tabs', true);

key.setViewKey('R', function (ev, arg) {
    ext.exec("kungfloo-reblog", arg, ev);
}, 'kungfloo - Reblog', true);

key.setViewKey('m', function (ev, arg) {
    shell.input("goodic " + (content.getSelection() || ""));
}, 'Lookup the meaning of the word');

key.setViewKey('M', function (ev, arg) {
    shell.input("weblio " + (content.getSelection() || ""));
}, 'Lookup the meaning of the word');

key.setViewKey('T', function (ev, arg) {
    shell.input("tabopen go ");
}, 'google検索');

key.setEditKey(['C-c', 'e'], function (ev, arg) {
    ext.exec("edit_text", arg);
}, '外部エディタで編集', true);

key.setEditKey(['C-x', 'h'], function (ev) {
    command.selectAll(ev);
}, '全て選択', true);

key.setEditKey(['C-x', 'u'], function (ev) {
    display.echoStatusBar("Undo!", 2000);
    goDoCommand("cmd_undo");
}, 'アンドゥ');

key.setEditKey(['C-x', 'r', 'd'], function (ev, arg) {
    command.replaceRectangle(ev.originalTarget, "", false, !arg);
}, '矩形削除', true);

key.setEditKey(['C-x', 'r', 't'], function (ev) {
    prompt.read("String rectangle: ", function (aStr, aInput) {
        command.replaceRectangle(aInput, aStr);
    },
    ev.originalTarget);
}, '矩形置換', true);

key.setEditKey(['C-x', 'r', 'o'], function (ev) {
    command.openRectangle(ev.originalTarget);
}, '矩形行空け', true);

key.setEditKey(['C-x', 'r', 'k'], function (ev, arg) {
    command.kill.buffer = command.killRectangle(ev.originalTarget, !arg);
}, '矩形キル', true);

key.setEditKey(['C-x', 'r', 'y'], function (ev) {
    command.yankRectangle(ev.originalTarget, command.kill.buffer);
}, '矩形ヤンク', true);

key.setEditKey('C-/', function (ev) {
    display.echoStatusBar("Undo!", 2000);
    goDoCommand("cmd_undo");
}, 'Undo');

key.setEditKey([['C-SPC'], ['C-@']], function (ev) {
    command.setMark(ev);
}, 'マークをセット', true);

key.setEditKey('C-o', function (ev) {
    command.openLine(ev);
}, '行を開く (Open line)');

key.setEditKey('C-a', function (ev) {
    command.beginLine(ev);
}, '行頭へ移動');

key.setEditKey('C-e', function (ev) {
    command.endLine(ev);
}, '行末へ');

key.setEditKey('C-f', function (ev) {
    command.nextChar(ev);
}, '一文字右へ移動');

key.setEditKey('C-b', function (ev) {
    command.previousChar(ev);
}, '一文字左へ移動');

key.setEditKey('M-f', function (ev) {
    command.forwardWord(ev);
}, '一単語右へ移動');

key.setEditKey('M-b', function (ev) {
    command.backwardWord(ev);
}, '一単語左へ移動');

key.setEditKey('C-n', function (ev) {
    command.nextLine(ev);
}, '一行下へ');

key.setEditKey('C-p', function (ev) {
    command.previousLine(ev);
}, '一行上へ');

key.setEditKey('C-v', function (ev) {
    command.pageDown(ev);
}, '一画面分下へ');

key.setEditKey('M-v', function (ev) {
    command.pageUp(ev);
}, '一画面分上へ');

key.setEditKey('M-<', function (ev) {
    command.moveTop(ev);
}, 'テキストエリア先頭へ');

key.setEditKey('M->', function (ev) {
    command.moveBottom(ev);
}, 'テキストエリア末尾へ');

key.setEditKey('C-d', function (ev) {
    goDoCommand("cmd_deleteCharForward");
}, '次の一文字削除');

key.setEditKey('C-h', function (ev) {
    goDoCommand("cmd_deleteCharBackward");
}, '前の一文字を削除');

key.setEditKey('M-d', function (ev) {
    command.deleteForwardWord(ev);
}, '次の一単語を削除');

key.setEditKey([['C-<backspace>'], ['M-<delete>']], function (ev) {
    command.deleteBackwardWord(ev);
}, '前の一単語を削除');

key.setEditKey('M-u', function (ev, arg) {
    command.wordCommand(ev, arg, command.upcaseForwardWord, command.upcaseBackwardWord);
}, '次の一単語を全て大文字に (Upper case)');

key.setEditKey('M-l', function (ev, arg) {
    command.wordCommand(ev, arg, command.downcaseForwardWord, command.downcaseBackwardWord);
}, '次の一単語を全て小文字に (Lower case)');

key.setEditKey('M-c', function (ev, arg) {
    command.wordCommand(ev, arg, command.capitalizeForwardWord, command.capitalizeBackwardWord);
}, '次の一単語をキャピタライズ');

key.setEditKey('C-k', function (ev) {
    command.killLine(ev);
}, 'カーソルから先を一行カット (Kill line)');

key.setEditKey('C-y', command.yank, '貼り付け (Yank)');

key.setEditKey('M-y', command.yankPop, '古いクリップボードの中身を順に貼り付け (Yank pop)', true);

key.setEditKey('C-M-y', function (ev) {
    if (!command.kill.ring.length) {
        return;
    }
    let(ct = command.getClipboardText())(!command.kill.ring.length || ct != command.kill.ring[0]) && command.pushKillRing(ct);
    prompt.selector({
        message: "Paste:",
        collection: command.kill.ring,
        callback: function (i) {
            if (i >= 0) {
                key.insertText(command.kill.ring[i]);
            }
        }
    });
}, '以前にコピーしたテキスト一覧から選択して貼り付け', true);

key.setEditKey('C-w', function (ev) {
    goDoCommand("cmd_copy");
    goDoCommand("cmd_delete");
    command.resetMark(ev);
}, '選択中のテキストを切り取り (Kill region)', true);

key.setEditKey('M-n', function (ev) {
    command.walkInputElement(command.elementsRetrieverTextarea, true, true);
}, '次のテキストエリアへフォーカス');

key.setEditKey('M-p', function (ev) {
    command.walkInputElement(command.elementsRetrieverTextarea, false, true);
}, '前のテキストエリアへフォーカス');

key.setEditKey('M-/', function (ev) {
    display.echoStatusBar("Redo!", 2000);
    goDoCommand("cmd_redo");
}, 'Redo');

key.setCaretKey([['C-a'], ['^']], function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectBeginLine") : goDoCommand("cmd_beginLine");
}, 'キャレットを行頭へ移動');

key.setCaretKey([['C-e'], ['$'], ['M->'], ['G']], function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectEndLine") : goDoCommand("cmd_endLine");
}, 'キャレットを行末へ移動');

key.setCaretKey([['C-n'], ['j']], function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectLineNext") : goDoCommand("cmd_scrollLineDown");
}, 'キャレットを一行下へ');

key.setCaretKey([['C-p'], ['k']], function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectLinePrevious") : goDoCommand("cmd_scrollLineUp");
}, 'キャレットを一行上へ');

key.setCaretKey([['C-f'], ['l']], function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectCharNext") : goDoCommand("cmd_scrollRight");
}, 'キャレットを一文字右へ移動');

key.setCaretKey([['C-b'], ['h'], ['C-h']], function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectCharPrevious") : goDoCommand("cmd_scrollLeft");
}, 'キャレットを一文字左へ移動');

key.setCaretKey([['M-f'], ['w']], function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectWordNext") : goDoCommand("cmd_wordNext");
}, 'キャレットを一単語右へ移動');

key.setCaretKey([['M-b'], ['W']], function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectWordPrevious") : goDoCommand("cmd_wordPrevious");
}, 'キャレットを一単語左へ移動');

key.setCaretKey([['C-v'], ['SPC']], function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectPageNext") : goDoCommand("cmd_movePageDown");
}, 'キャレットを一画面分下へ');

key.setCaretKey([['M-v'], ['b']], function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectPagePrevious") : goDoCommand("cmd_movePageUp");
}, 'キャレットを一画面分上へ');

key.setCaretKey('M-<', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectTop") : goDoCommand("cmd_scrollTop");
}, 'キャレットをページ先頭へ移動');

key.setCaretKey('J', function (ev) {
    util.getSelectionController().scrollLine(true);
}, '画面を一行分下へスクロール');

key.setCaretKey('K', function (ev) {
    util.getSelectionController().scrollLine(false);
}, '画面を一行分上へスクロール');

key.setCaretKey(',', function (ev) {
    util.getSelectionController().scrollHorizontal(true);
    goDoCommand("cmd_scrollLeft");
}, '左へスクロール');

key.setCaretKey('.', function (ev) {
    goDoCommand("cmd_scrollRight");
    util.getSelectionController().scrollHorizontal(false);
}, '右へスクロール');

key.setCaretKey('z', function (ev) {
    command.recenter(ev);
}, 'キャレットの位置までスクロール');

key.setCaretKey([['C-SPC'], ['C-@']], function (ev) {
    command.setMark(ev);
}, 'マークをセット', true);

key.setCaretKey(':', function (ev, arg) {
    shell.input(null, arg);
}, 'コマンドの実行', true);

key.setCaretKey('R', function (ev, arg) {
    ext.exec("kungfloo-reblog", arg, ev);
}, 'kungfloo - Reblog', true);

key.setCaretKey('B', function (ev) {
    BrowserBack();
}, '戻る');

key.setCaretKey('F', function (ev) {
    BrowserForward();
}, '進む');

key.setCaretKey(['C-x', 'h'], function (ev) {
    goDoCommand("cmd_selectAll");
}, 'すべて選択', true);

key.setCaretKey('M-p', function (ev) {
    command.walkInputElement(command.elementsRetrieverButton, true, true);
}, '次のボタンへフォーカスを当てる');

key.setCaretKey('M-n', function (ev) {
    command.walkInputElement(command.elementsRetrieverButton, false, true);
}, '前のボタンへフォーカスを当てる');

key.setCaretKey('m', function (ev, arg) {
    shell.input("goodic " + (content.getSelection() || ""));
}, 'Lookup the meaning of the word');

key.setCaretKey('M', function (ev, arg) {
    shell.input("weblio " + (content.getSelection() || ""));
}, 'Lookup the meaning of the word');

key.setViewKey('o', function (ev, arg) {
    shell.input("open ");
}, 'このタブで開く');

key.setViewKey('O', function (ev, arg) {
    shell.input("tabopen go ");
}, 'このタブでgoogle検索');

