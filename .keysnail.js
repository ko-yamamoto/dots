// ========================== KeySnail Init File =========================== //

// この領域は, GUI により設定ファイルを生成した際にも引き継がれます
// 特殊キー, キーバインド定義, フック, ブラックリスト以外のコードは, この中に書くようにして下さい
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
    // twitter client specific actions
    "N"     : "tweet",
    "R"     : "reply",
    "T"     : "retweet",
    "M"     : "send-direct-message",
    "D"     : "delete-tweet",
    "F"     : "add-to-favorite",
    "v"     : "show-target-status",
    "V"     : "view-in-twitter",
    "c"     : "copy-tweet",
    "*"     : "show-target-status",
    "@"     : "show-mentions",
    "d"     : "show-dms",
    "/"     : "search-word",
    "o"     : "open-url",
    "r"     : "show-conversations",
    "."     : "refresh-or-back-to-timeline",
    "A"     : "toggle-homeline-updating",
    "s"     : "switch-to"
};

// リスト設定
plugins.options["twitter_client.lists"] =
    ["nishikawasasaki/kdl", "nishikawasasaki/list"];

plugins.options["twitter_client.list_update_intervals"] = {
    "nishikawasasaki/kdl"     : 60 * 1000 * 10 // 10 分ごとに更新を確認
};

// 日本語のつぶやきを対象に
plugins.options["twitter_client.tracking_langage"] = "ja";

// popup するかどうか
plugins.options["twitter_client.popup_new_statuses"]           = false;
// 起動時にリストを更新するかどうか
plugins.options["twitter_client.automatically_begin_list"]     = false;
// タイムラインの更新間隔
plugins.options["twitter_client.update_interval"]          = 60 * 1000 * 5;
// リプライの更新間隔
plugins.options["twitter_client.mentions_update_interval"] = 60 * 1000 * 5;
// DM の更新間隔
plugins.options["twitter_client.dm_update_interval"]       = 60 * 1000 * 10;




// 外部エディタの設定
key.setEditKey(["C-c", "e"], function (ev, arg) {
    ext.exec("edit_text", arg);
}, "外部エディタで編集", true);
plugins.options["K2Emacs.editor"] = "C:\\my\\programs\\emacs\\emacs-23.3\\bin\\emacsclientw.exe -n";
plugins.options["K2Emacs.ext"] = "html";
plugins.options["K2Emacs.encode"] = "UTF-8";
plugins.options["K2Emacs.sep"] = "\\";


// ヒントの見た目設定
plugins.options["hok.hint_base_style"] = {
    "position"       : 'absolute',
    "z-index"        : '2147483647',
    "color"          : '#000',
    "font-family"    : 'VL_Gothic',
    "font-size"      : '10pt',
    "font-weight"    : 'bold',
    "line-height"    : '10pt',
    "padding"        : '2px',
    "margin"         : '1px',
    "text-transform" : 'uppercase'
};

plugins.options["hok.hint_color_link"]    = 'rgba(210, 210, 210, 0.6)';
plugins.options["hok.hint_color_form"]    = 'rgba(210, 210, 210, 0.6)';
plugins.options["hok.hint_color_focused"] = 'rgba(255, 82, 93, 0.6)';


// migemo
prompt.useMigemo = true;
prompt.migemoMinWordLength = 3;


plugins.options["hitsory.keymap"] = {
    "C-z"   : "prompt-toggle-edit-mode",
    //"SPC"   : "prompt-next-page",
    //"b"     : "prompt-previous-page",
    "j"     : "prompt-next-completion",
    "k"     : "prompt-previous-completion",
    "g"     : "prompt-beginning-of-candidates",
    "G"     : "prompt-end-of-candidates",
    "q"     : "prompt-cancel",
    // history specific actions
    "/"     : "search",
    "o"     : "open"
};

plugins.options['find.keymap'] = {
    "C-z"   : "prompt-toggle-edit-mode",
    "SPC"   : "prompt-next-page",
    "b"     : "prompt-previous-page",
    "j"     : "prompt-next-completion",
    "k"     : "prompt-previous-completion",
    "g"     : "prompt-beginning-of-candidates",
    "G"     : "prompt-end-of-candidates",
    "q"     : "prompt-cancel"
};

//Tanything 0.1.4用設定
plugins.options["tanything_opt.keymap"] = {
    "C-z"   : "prompt-toggle-edit-mode",        //ローカルキーバインドモードを抜けて編集モードに移行
    "C-v"   : "prompt-next-page",               //一画面スクロールダウン
    "M-v"   : "prompt-previous-page",           //一画面スクロールアップ
    "j"     : "prompt-next-completion",         //次のアイテムに移動
    "k"     : "prompt-previous-completion",     //前のアイテム移動
    "g"     : "prompt-beginning-of-candidates", //最初のアイテムに移動
    "G"     : "prompt-end-of-candidates",       //最後のアイテムに移動
    "q"     : "prompt-cancel",
    // Tanything specific actions
    "d"     : "localClose",                     //選択したタブを閉じる
    // "p"     : "localLeftclose",                 //選択したタブの左にあるタブをすべて閉じる
    // "n"     : "localRightclose",                //選択したタブの右にあるタブをすべて閉じる
    "M-a"   : "localAllclose",                  //選択したタブ以外をすべて閉じる(キーバインド”a”だと押し間違いがあるので"M-a"に変更。)
    "c"     : "localClipUT",                    //選択したタブのタイトルとURLをHTMLタグつきでコピー
    "p"     : "localTogglePin",
    "C"     : "localClipU",                     //選択したタブのURLをHTMLタグつきでコピー
    "e"     : "localMovetoend",                 //選択したタブを末尾に移動
    "a"     : "localMovetostart"               //選択したタブを先頭に移動//追加
};



// Tombloo連携でGoogleReader
// local["^http://www.google.(co.jp|com)/reader/view/"] = [
//     // Your local keybind settings here
//     ["r", function () {
//          let link = content.document.querySelector("#current-entry a.entry-title-link");
//          if (link && plugins.kungfloo)
//              plugins.kungfloo.reblog(link, false, false, ["FFFFOUND", "Flickr", "Tumblr"]);
//      }]
// ];


plugins.options["kkk.sites"] = ["^https://([0-9a-zA-Z]+\\.)?github\\.com/",
                                "^https://([0-9a-zA-Z]+\\.)?facebook\\.com/",
                                "^https://([0-9a-zA-Z]+\\.)?google\\.co\\.jp/",
                                "^https://([0-9a-zA-Z]+\\.)?duckduckgo\\.com/",
                                "^http://([0-9a-zA-Z]+\\.)?tumblr\\.com/"];



plugins.options["ril.keymap"] = {
    "C-z" : "prompt-toggle-edit-mode",
    "j" : "prompt-next-completion",
    "k" : "prompt-previous-completion",
    "g" : "prompt-beginning-of-candidates",
    "G" : "prompt-end-of-candidates",
    "q" : "prompt-cancel",
    // PocketSnail specific actions
    "o" : "open,c",
    "O" : "open-background,c",
    "t" : "open-text,c",
    "T" : "open-text-background,c",
    "d" : "delete",
    "r" : "sync"
};

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
    ['*', null],
    ['g', null],
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

// local["^https?://www.facebook.com/"] = [
//     // navigation
//     ['k', null],
//     ['j', null]
// ];







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

        let xml = util.xmlToDom(matched[1], util.XHTML);

        return Array.slice(xml.querySelectorAll("suggestion[data]")).map(function (suggestion) suggestion.getAttribute("data"));
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
// style.register(<><![CDATA[
//     #keysnail-prompt-textbox *|input {
//         ime-mode : inactive !important;
//     }
// ]]></>);


// ===== Add exts =====

//最近閉じたタブ
ext.add("list-closed-tabs", function () {
    const fav = "chrome://mozapps/skin/places/defaultFavicon.png";
    var ss = Cc["@mozilla.org/browser/sessionstore;1"].getService(Ci.nsISessionStore);
    var json = Cc["@mozilla.org/dom/json;1"].createInstance(Ci.nsIJSON);
    var closedTabs = [[tab.image || fav, tab.title] for each (tab in json.decode(ss.getClosedTabData(window)))];
    if (!closedTabs.length)
        return void display.echoStatusBar("最近閉じたタブが見つかりませんでした", 2000);
    prompt.selector({
        message : "select tab to undo:",
        collection : closedTabs,
        keymap : plugins.options['default.keymap'],
        flags : [ICON | IGNORE, 0],
        callback : function (i) { if (i >= 0) window.undoCloseTab(i); }
    });
}, "List closed tabs");

//ブラウザの戻る履歴
ext.add("list-tab-history", function () {
    var tabHistory = [];
    var sessionHistory = gBrowser.webNavigation.sessionHistory;
    if (sessionHistory.count < 1)
        return void display.echoStatusBar("Tab history not exist", 2000);
    var curIdx = sessionHistory.index;
    for (var i = 0; i < sessionHistory.count; i++) {
        var entry = sessionHistory.getEntryAtIndex(i, false);
        if (!entry)
            continue;
        tabHistory.push([util.getFaviconPath(entry.URI.spec), entry.title, entry.URI.spec, i]);
    }
    for (var thIdx = 0; thIdx < tabHistory.length; thIdx++) {
        if (tabHistory[thIdx][3] == curIdx) break;
    }
    prompt.selector({
        message : "select history in tab",
        collection : tabHistory,
        flags : [ICON | IGNORE, 0, 0, IGNORE | HIDDEN],
        header : ["Title", "URL"],
        initialIndex: thIdx,
        callback : function(i) { if (i >= 0) gBrowser.webNavigation.gotoIndex(tabHistory[i][3]); },
        keymap : plugins.options['default.keymap'],
        stylist : function (args, n, current) {
            let style = '';
            if (args[3]== thIdx) style += 'font-weight:bold;';
            return style;
        }
    });
}, 'List tab history');



// ===== plugins.lib extends =====
plugins.lib = _.extend(plugins.lib, {
    shortenURL: function (longURL, callback) {
        let url = 'https://www.googleapis.com/urlshortener/v1/url';
        let xhr = new XMLHttpRequest();
        xhr.open("POST", url, true);
        xhr.setRequestHeader("Content-Type", "application/json");
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4) {
                let url = JSON.parse(xhr.responseText).id;
                callback(url);
            }
        };
        xhr.send(JSON.stringify({ longUrl: longURL }));
    }
});


// imenu 的なものを追加
ext.add("imenu-headers", function () {
    let anchorSelector = [
        "h1",
        "h2",
        "h3",
        "h4"
    ].join(",");

    let elements = Array.slice(content.document.querySelectorAll(anchorSelector));

    function elementToString(element) {
        let headerString = "",
            matched = null;
        if ((matched = element.localName.match(/h([0-9])/))) {
            let headerCount = parseInt(matched[1], 10);
            headerString = (new Array(headerCount)).join("  ");

            let headerMarks = {
                1: '',            /* none */
                2: "\u2023",      /* right arrow */
                3: "\u2022",      /* bullet */
                4: "\u25E6"       /* white bullet */
            };

            if (headerMarks[headerCount])
                headerString = headerString + headerMarks[headerCount] + " ";
        }

        return headerString + element.textContent;
    }

    function scrollToElement(element) {
        let anchor = element.getAttribute("id") || element.getAttribute("name");
        if (anchor)
            content.location.hash = anchor;
        else
            element.scrollIntoView();
    }

    prompt.selector({
        message: "jump to: ",
        collection: elements.map(function (element) elementToString(element)),
        callback: function (selectedIndex) {
            if (selectedIndex < 0)
                return;
            scrollToElement(elements[selectedIndex]);
        }
    });
}, "imenu-headers", true);


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

key.setGlobalKey([['M-x'], ['C-x', 'c']], function (ev, arg) {
    ext.select(arg, ev);
}, 'エクステ一覧表示', true);

key.setGlobalKey(['C-x', '1'], function (ev) {
    window.loadURI(ev.target.ownerDocument.location.href);
}, '現在のフレームだけを表示', true);

key.setGlobalKey(['C-x', 'l'], function (ev) {
    command.focusToById("urlbar");
}, 'ロケーションばーへ移動', true);

key.setGlobalKey(['C-x', 'g'], function (ev, arg) {
    ext.exec('tabgroup-list', arg, ev);
}, 'タブグループを一覧表示', true);

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

key.setGlobalKey(['C-x', 'C-f'], function (ev) {
    BrowserOpenFileWindow();
}, 'ファイルを開く', true);

key.setGlobalKey(['C-x', 'C-s'], function (ev) {
    saveDocument(window.content.document);
}, 'ファイルを保存', true);

key.setGlobalKey(['C-x', 'u'], function (ev) {
    display.echoStatusBar("Undo!", 2000);
    goDoCommand("cmd_undo");
}, 'アンドゥ');

key.setGlobalKey(['C-x', 'h'], function (ev) {
    goDoCommand("cmd_selectAll");
}, 'すべて選択', true);

key.setGlobalKey(['C-x', 'r', 'd'], function (ev, arg) {
    command.replaceRectangle(ev.originalTarget, "", false, !arg);
}, '矩形削除', true);

key.setGlobalKey(['C-x', 'r', 't'], function (ev) {
    prompt.read("String rectangle: ", function (aStr, aInput) {command.replaceRectangle(aInput, aStr);}, ev.originalTarget);
}, '矩形置換', true);

key.setGlobalKey(['C-x', 'r', 'o'], function (ev) {
    command.openRectangle(ev.originalTarget);
}, '矩形行空け', true);

key.setGlobalKey(['C-x', 'r', 'k'], function (ev, arg) {
    command.kill.buffer = command.killRectangle(ev.originalTarget, !arg);
}, '矩形キル', true);

key.setGlobalKey(['C-x', 'r', 'y'], function (ev) {
    command.yankRectangle(ev.originalTarget, command.kill.buffer);
}, '矩形ヤンク', true);

key.setGlobalKey([['C-x', 'r', 'SPC'], ['C-1']], function (ev, arg) {
    ext.exec("scrollet-set-mark", arg, ev);
}, '現在の位置をマークに保存', true);

key.setGlobalKey([['C-x', 'r', 'j'], ['C-2']], function (ev, arg) {
    ext.exec("scrollet-jump-to-mark", arg, ev);
}, 'マークに保存された位置へジャンプ', true);

key.setGlobalKey(['C-x', 'b'], function (ev, arg) {
    ext.exec('tanything', arg, ev);
}, 'タブを一覧表示', true);

key.setGlobalKey(['C-x', 't'], function (ev, arg) {
    ext.exec("twitter-client-display-timeline", arg, ev);
}, 'TL を表示', true);

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

key.setGlobalKey(['C-c', 'u'], function (ev) {
    undoCloseTab();
}, '閉じたタブを元に戻す');

key.setGlobalKey(['C-c', 'C-c', 'C-v'], function (ev) {
    toJavaScriptConsole();
}, 'Javascript コンソールを表示', true);

key.setGlobalKey(['C-c', 'C-c', 'C-c'], function (ev) {
    command.clearConsole();
}, 'Javascript コンソールの表示をクリア', true);

key.setGlobalKey(['C-c', 'c'], function (ev) {
    const templates = {title_short_url: (function (title, url, callback) plugins.lib.shortenURL(url, callback)), title: "{0}", url: "{1}", title_url: "{0} - {1}"};

    function getLineSeprator() {
        var platform = Cc['@mozilla.org/system-info;1'].getService(Ci.nsIPropertyBag2).getProperty("name");
        if (platform.indexOf("Windows") >= 0) {
            return "\r\n";
        } else {
            return "\n";
        }
    }


    function format() {
        var args = Array.prototype.slice.apply(arguments);
        var format = args.shift();
        return format &&
            format.replace(/\{(\d)\}/g, (function () args[arguments[1]] || ""));
    }

    var promptList = [];
    for (let key in templates) {
        promptList.push(key);
    }
    prompt.selector({message: "copy from :", collection: promptList, keymap: plugins.options['default.keymap'], callback: function (aIndex) {if (aIndex < 0) {return;}var key = promptList[aIndex];if (typeof templates[key] == "string") {let template = templates[key].replace(/\n/g, getLineSeprator());let text = format(template, window.content.document.title, window.content.location.href);command.setClipboardText(text);display.echoStatusBar("Yanked: " + text);} else {templates[key](window.content.document.title, window.content.location.href, function (text) {command.setClipboardText(window.content.document.title + " - " + text);display.echoStatusBar("Yanked: " + window.content.document.title + " - " + text);});}}});
}, 'タイトルやURLをコピー');

key.setGlobalKey(['C-c', 't', 'p'], function (ev, arg) {
    ext.exec("twitter-client-tweet", arg);
}, 'twitter につぶやく', true);

key.setGlobalKey(['C-c', 't', 'l'], function (ev, arg) {
    ext.exec("twitter-client-tweet-this-page", arg, ev);
}, 'twitter にこのページのタイトルと URL を使ってつぶやく', true);

key.setGlobalKey(['C-c', 't', 't'], function (ev, arg) {
    ext.exec("twitter-client-display-timeline", arg, ev);
}, 'twitter TL を表示', true);

key.setGlobalKey(['C-c', 't', '@'], function (ev, arg) {
    ext.exec("twitter-client-show-mentions", arg, ev);
}, 'twitter メンションを表示', true);

key.setGlobalKey(['C-c', 'y'], function (ev, arg) {
    ext.exec("view-yammer", arg, ev);
}, 'yammer を表示', true);

key.setGlobalKey(['C-c', 'f', 'f'], function (ev, arg) {
    ext.exec("facebook-show-news-feed", arg);
}, ' facebook ニュースフィードを表示', true);

key.setGlobalKey(['C-c', 'f', 'p'], function (ev, arg) {
    ext.exec("facebook-post-text", arg);
}, ' facebook 自分のウォールにポスト', true);

key.setViewKey(['C-c', 'g', 'o'], function (ev, arg) {
    var gurl = "https://mail.google.com/mail/u/0/#inbox";
    var tBrowser = top.document.getElementById("content");
    var tab = tBrowser.addTab(gurl);
    tBrowser.selectedTab = tab;
}, 'gmail を開く');

key.setGlobalKey('M-w', function (ev) {
    command.copyRegion(ev);
}, '選択中のテキストをコピー', true);

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

key.setGlobalKey('M-o', function (ev) {
    ext.exec("find-current-tab");
}, 'このタブから検索');

key.setGlobalKey('C-M-o', function (ev) {
    ext.exec('find-all-tab');
}, '全タブから検索');

key.setGlobalKey('M-j', function () {
    plugins.twitterClient.switchTo();
}, 'Twitter Client Select Action');

key.setGlobalKey('C-s', function (ev) {
    command.iSearchForwardKs(ev);
}, 'Emacs ライクなインクリメンタル検索', true);

key.setGlobalKey('C-;', function (ev) {
    ext.exec("history-show");
}, '履歴 anything 風');

key.setGlobalKey('M-i', function (ev) {
    ext.exec("imenu-headers");
}, 'jump to headers');

key.setViewKey('U', function (ev) {
    ext.exec("list-closed-tabs");
}, '閉じたタブリスト表示');

key.setViewKey('B', function (ev) {
    ext.exec("list-tab-history");
}, 'このタブの履歴リスト表示');

key.setViewKey('x', function (ev, arg) {
    ext.exec("list-hateb-items", arg);
}, 'はてなブックマークのアイテムを一覧表示', true);

key.setViewKey(['C-c', 'c'], function (ev) {
    const templates = {title_short_url: (function (title, url, callback) plugins.lib.shortenURL(url, callback)), title: "{0}", url: "{1}", title_url: "{0} - {1}"};

    function getLineSeprator() {
        var platform = Cc['@mozilla.org/system-info;1'].getService(Ci.nsIPropertyBag2).getProperty("name");
        if (platform.indexOf("Windows") >= 0) {
            return "\r\n";
        } else {
            return "\n";
        }
    }


    function format() {
        var args = Array.prototype.slice.apply(arguments);
        var format = args.shift();
        return format &&
            format.replace(/\{(\d)\}/g, (function () args[arguments[1]] || ""));
    }

    var promptList = [];
    for (let key in templates) {
        promptList.push(key);
    }
    prompt.selector({message: "copy from :", collection: promptList, keymap: plugins.options['default.keymap'], callback: function (aIndex) {if (aIndex < 0) {return;}var key = promptList[aIndex];if (typeof templates[key] == "string") {let template = templates[key].replace(/\n/g, getLineSeprator());let text = format(template, window.content.document.title, window.content.location.href);command.setClipboardText(text);display.echoStatusBar("Yanked: " + text);} else {templates[key](window.content.document.title, window.content.location.href, function (text) {command.setClipboardText(window.content.document.title + " - " + text);display.echoStatusBar("Yanked: " + window.content.document.title + " - " + text);});}}});
}, 'タイトルやURLをコピー');

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

key.setViewKey([['d'], ['m', 'k']], function (ev) {
    BrowserCloseTabOrWindow();
}, 'タブ / ウィンドウを閉じる');

key.setViewKey('H', function (ev) {
    BrowserBack();
}, '戻る');

key.setViewKey('L', function (ev) {
    BrowserForward();
}, '進む');

key.setViewKey([['C-n'], ['j']], function (ev) {
    plugins.scrollet.scrollLines(8);
}, '4行スクロールダウン');

key.setViewKey([['C-p'], ['k']], function (ev) {
    plugins.scrollet.scrollLines(-8);
}, '4行スクロールアップ');

key.setViewKey([['M-m'], ['i']], function (ev) {
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

key.setViewKey('c', function (ev, arg) {
    ext.exec("list-hateb-comments", arg);
}, 'はてなブックマークのコメントを一覧表示', true);

key.setViewKey('a', function (ev, arg) {
    ext.exec("hateb-bookmark-this-page");
}, 'このページをはてなブックマークに追加', true);

key.setViewKey('b', function (ev, arg) {
    ext.exec("tanything", arg);
}, 'view all tabs', true);

key.setViewKey('R', function (ev) {
    BrowserReloadSkipCache();
}, '更新(キャッシュを無視)');

key.setViewKey('M', function (ev, arg) {
    shell.input("weblio " + (content.getSelection() || ""));
}, 'Lookup the meaning of the word');

key.setViewKey('t', function (ev, arg) {
    BrowserOpenTab();
}, 'タブを開く');

key.setViewKey('T', function (ev, arg) {
    shell.input("tabopen google ");
}, 'google検索');

key.setViewKey('o', function (ev, arg) {
    command.focusToById("urlbar");
}, 'ロケーションバーへ移動');

key.setViewKey('O', function (ev, arg) {
    shell.input("open google ");
}, 'このタブでgoogle検索');

key.setViewKey('A', function (ev, arg) {
    ext.exec("kungfloo-reblog", arg, ev);
}, 'kungfloo - Reblog', true);

key.setViewKey('C-s', function (ev) {
    command.iSearchForward();
}, 'インクリメンタル検索', true);

key.setViewKey(['ESC', 'ESC'], function (ev) {
    userscript.loadPlugins();
}, 'プラグインのリロード');

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
    prompt.read("String rectangle: ", function (aStr, aInput) {command.replaceRectangle(aInput, aStr);}, ev.originalTarget);
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

key.setEditKey('M-y', function (ev) {
    if (!command.kill.ring.length) {
        return;
    }
    let (ct = command.getClipboardText()) (!command.kill.ring.length || ct != command.kill.ring[0]) &&
            command.pushKillRing(ct);
    prompt.selector({message: "Paste:", collection: command.kill.ring, callback: function (i) {if (i >= 0) {key.insertText(command.kill.ring[i]);}}});
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

key.setEditKey('C-l', function (ev) {
    command.recenter(ev);
}, 'カーソル位置が画面の中央へ来るようスクロール', true);

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

key.setCaretKey('A', function (ev, arg) {
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

key.setCaretKey('M', function (ev, arg) {
    shell.input("weblio " + (content.getSelection() || ""));
}, 'Lookup the meaning of the word');

key.setViewKey(['C-c', 'g', 'g'], function (ev, arg) {
    ext.exec('gmail-checker-mail-list', arg, ev);
}, '新着メールを表示', true);

key.setViewKey(['C-c', 'p', 'p'], function (ev, arg) {
    ext.exec('ril-show-reading-list', arg, ev);
}, 'Pocket - Show reading list', true);

key.setViewKey(['C-c', 'p', 't'], function (ev, arg) {
    ext.exec('ril-toggle', arg, ev);
}, 'Pocket - Append or remove current tab', true);

key.setViewKey(['C-c', 'p', 'a'], function (ev, arg) {
    ext.exec('ril-append', arg, ev);
}, 'Pocket - Append current tab', true);
