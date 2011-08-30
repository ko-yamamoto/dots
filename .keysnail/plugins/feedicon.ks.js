var PLUGIN_INFO =
<KeySnailPlugin>
<name>Feed icon</name>
<description lang="ja">FireFox 4 で廃止されたフィードアイコンっぽいもの</description>
<license>MIT</license>
<include>main</include>
<iconURL>https://sites.google.com/site/958site/Home/files/feedicon.ks.png</iconURL>
<updateURL>https://gist.github.com/raw/990419/feedicon.ks.js</updateURL>
<minVersion>1.8.0</minVersion>
<author>958</author>
<version>0.0.1</version>
<detail><![CDATA[
=== 使い方 ===
FireFox 4 で廃止されたフィードアイコンっぽいものを表示します
アイコンをクリックするか、エクステ 'feed-show' を実行すると、セレクタでフィード URL を表示します
セレクタ上でフィードリーダに追加したりできます
]]></detail>
</KeySnailPlugin>;

// Options
let pOptions = plugins.setupOptions("feed_icon", {
    'show_in_url_bar': {
        preset: true,
        description: M({
            ja: "アイコンを URL バーに表示する (false を指定した場合は、アドオンバーに表示)",
            en: "displayed an icon to a URL bar",
        })
    },
    'keymap': {
        preset: {
            "C-z"   : "prompt-toggle-edit-mode",
            "SPC"   : "prompt-next-page",
            "b"     : "prompt-previous-page",
            "j"     : "prompt-next-completion",
            "k"     : "prompt-previous-completion",
            "g"     : "prompt-beginning-of-candidates",
            "G"     : "prompt-end-of-candidates",
            "q"     : "prompt-cancel",
            // feed icon specific actions
            "o"     : "open",
            "c"     : "copy-url,c",
            "r"     : "add-feed-reader",
        },
        description: M({
            ja: "メイン画面の操作用キーマップ",
            en: "Local keymap for manipulation"
        })
    },
}, PLUGIN_INFO);

const ICON_E = 'data:image/png;base64,'+
'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAACoElEQVQ4y3VTW0iTYRj+veu2u266'+
'6DIrZ5vz3ylhhUFSV0UIoRAUptQiGEkasTzNkQekZgqtNrKLMsq8SDogGtlNRYFdlMl05zY3t38H'+
't6nz6Xu/5XJYgw/2fT/P+z7P+zyvoNi1Q7Ad393gbFE6XdeVcN9QwmNSwtvGTkclfF0ifGYV/BZ2'+
'brHTo8biTdFJmAbZzhIO9rVr4GsuQ6BFhqCpHKHOcixZ5Aj3VmB5oBJRKzvDImI2FWIP1IjZtQgP'+
'6THbuPeVQJ0JHLJUY+XTUySnByGNXkRkQPtfcMyhQ+yeGpGhaghEmzpHBk9h628jm0DmyyNIjqP/'+
'AKsQvSOyBhoIpJloh/v0SL2zIvNtHLm4/2+hdBSpN8Zi8G2Rywv3iBBoYNs1i0i+vIxcZO5PlRxW'+
'ZsxF4JBZjqUuJQSaNoGj9tPYyEhY839F+kM/o36YdaxC9sfzQpHEC0MBTKyDpgpWgFlFj9JIbfEM'+
'kkHG4gKnnf0+xt9yyTCTWsXBgWsyBFoVEMhnTvuuBvEntYxqN3KSJ19lPYPk+Hn2TYf1iJM/JaeG'+
'OdhrLIP3qpwVYCHZZtXIEay53+e7Sn5uqfTMmL8nwiwzcrgNB+C5chACJWwTnP5oxaprGomxM5Ds'+
'+oIbiYlOhNoUTMIyvwf767DYuB+uS+WsAIsngeOjJwv6V+dfc59TU338nv05w2mnZ9/ye+SxGc5z'+
'+7DQRAVYtjnth6yj5KLxITXZzQcbddTlRxH1c83xSTu/xyZsmD9bCmcTk0CLUQjJ/UOQbMcKVoXa'+
'WUZ6T+CXuSav2aiDp7UGCwYt5upL4evQgy8TLQZlm2hv9Xlz2gQmzUSbOhPY1azKLxOtJP2hxaBs'+
'UzwpYRQS8pmsomnTwEgz0abOhPlcv6fkN43A5Cx+Hq2/AAAAAElFTkSuQmCC';

const ICON_D = 'data:image/png;base64,'+
'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAACDklEQVQ4y3VTS6upYRR+9+z8hPM/'+
'zsBP8RPOzJAUyf1OyJ2BwkARkToGImTGhJTyZWJGyLWUtfezdu/Xtk/7q1Xv5Xue9axnrVf8+f1L'+
'aLXavw6HQ3G5XOR2u8nj8ZDX6yWfz0d+v58CgQAFg0GOUCiEewUYjUbzxmD8ZLfbyel0MhhAgMLh'+
'MEUiEYrFYhSPxymZTFIqlaJ0Os1rg8HwTyAzwNFolKbTKQ0GA6pWqwz6CSwJsBeQjcz5fJ6+fvf7'+
'nSaTCZ9/BycSCSZGCFkzNsPhkGazGR2PR5Xoer1Su93+D4zyEOKnmpvNJm23WyZ5Pp/U6/VewNJc'+
'AbexKBQKdLvdaLPZsJJcLkeZTIbm87lKUq/XVbDslEB2HBaLxRcPTqcTAyBbkpzPZzYbYPiG8gXY'+
'IBtOl8tl6vf7dDgcGPB4PKhWq7H03W7HZ1AHsM1mo48OkoD8762C8+v1mgEwFPeNRkNVAaDFYiGr'+
'1UoC0yXB4/GYFEWhSqVC2WxW7Uan02GjL5cL7+GPyWRiEiYAuFQqqfUvl0vOinLwrVYrlr1YLHjf'+
'arXIaDSS2WwmgdmGbLDu93t2u9vtvhgLT1DzaDTiPYg/xviTAA9DDgkC9ctWIWTvIRdTC8Ug0+v1'+
'/LD4MaEExNchka3CzwCjZshGZoBxx48JTxILlCEJ0BkMCfoMx+E2SCAZgczA6HS6t3dmCuNc7lTt'+
'4wAAAABJRU5ErkJggg==';

(function (){
    const showInUrlBar = pOptions['show_in_url_bar'];

    let panel = document.getElementById('ks-feed-icon');
    if (panel)
      panel.parentNode.removeChild(panel);

    if (showInUrlBar) {
        panel = $E('image', { 'id':'ks-feed-icon', 'src':ICON_E, 'class':'urlbar-icon' });
        panel.addEventListener('click', function(e) ext.exec('feed-show'), false);
        document.getElementById('urlbar-icons').appendChild(panel);
    } else {
        panel = $E('statusbarpanel', {'id':'ks-feed-icon', 'class':'statusbarpanel-iconic' });
        panel.addEventListener('click', function(e) ext.exec('feed-show'), false);
        document.getElementById('status-bar').insertBefore(
            panel, document.getElementById('keysnail-status').nextSibling);
    }
    setIcon();

    let appcontent = document.getElementById('appcontent');
    let container = gBrowser.tabContainer;
    if (my.feedIconEventhandler) {
        appcontent.removeEventListener('pageshow', my.feedIconEventhandler, true);
        container.removeEventListener('TabSelect', my.feedIconEventhandler, false);
    }
    appcontent.addEventListener('pageshow', setIcon, true);
    container.addEventListener('TabSelect', setIcon, false);

//    hook.addToHook('LocationChange', setIcon);

    my.feedIconEventhandler = setIcon;

    function setIcon() {
        let feeds = gBrowser.selectedBrowser.feeds;
        if (showInUrlBar)
            panel.setAttribute('hidden', (!feeds || feeds.length == 0));
        else
            panel.setAttribute('image', (feeds && feeds.length > 0) ? ICON_E : ICON_D);
    };
})();

function $E(tag, param) {
    let elem = document.createElement(tag);
    for (let p in param) elem.setAttribute(p, param[p]);
    return elem;
}

function addFeedReader(feedURL) {
    let feedReaders = [[M({ja: 'ライブブックマーク', en:'Live bookmark'}), null]];
    for (let i = 0; ; i++) {
        let uri = util.getUnicharPref('browser.contentHandlers.types.' + i + '.uri');
        if (!uri) break;
        if (uri.indexOf('%s') == -1) continue;
        let title = util.getUnicharPref('browser.contentHandlers.types.' + i + '.title');
        feedReaders.push([title, uri]);
    }
    prompt.selector ({
        message     : 'Select feed reader:',
        collection  : feedReaders,
        keymap      : pOptions['keymap'],
        flags       : [0, HIDDEN | IGNORE],
        actions     : [
            [function(i) {
                 if (feedReaders[i][1])
                     openUILinkIn(feedReaders[i][1].replace('%s', encodeURIComponent(feedURL)), 'tab');
                 else
                     PlacesCommandHook.addLiveBookmark(feedURL, window.content.document.title);
            }, 'Add feed reader', 'add-feed-reader'],
        ]
    });
}

// Add ext

plugins.withProvides(function(provide){
    provide('feed-show', function(arg, ev) {
        let feeds = gBrowser.selectedBrowser.feeds;
        if (!feeds || feeds.length == 0)
            return;

        let collection = feeds.map(function(feed) [ICON_E, feed.title, feed.href]);
        prompt.selector ({
            message     : 'Select feed:',
            collection  : collection,
            keymap      : pOptions['keymap'],
            flags       : [ICON | IGNORE, 0, 0],
            style       : [null, style.prompt.url],
            header      : ['Title', 'URL'],
            width       : [40, 60],
            actions     : [
                [function(i) openUILinkIn(feeds[i].href, 'tab'),
                 'Open feed', 'open'],
                [function(i) command.setClipboardText(feeds[i].href),
                 'Copy feed url', 'copy-url'],
                [function(i) addFeedReader(feeds[i].href),
                 'Add feed reader', 'add-feed-reader'],
            ]
        });
    }, M({en:'Show feed urls', ja:'フィード URL を表示'}));
}, PLUGIN_INFO);
