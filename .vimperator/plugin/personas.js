// Vimperator plugin for personas
/*
Command:
:personas {id}  
   change to {id}'s theme

:personas {id} -c[color] {color}
               -a[ccent] {color}
               -h[eader] {path}
               -f[ooter] {path}
  register and change to {id}

:personas! {id}
  delete {id}'s theme

liberator.globalVariables.lwt = [
  {
    id: 
    name:
    textcolor:
    accentcolor:
    description:
    author:
    headerURL:
    footerURL:
    previewURL:
    iconURL:
  },
  // ...
];
 */
Cu.import("resource://gre/modules/LightweightThemeManager.jsm");

let prefs = Cc["@mozilla.org/preferences-service;1"]
              .getService(Ci.nsIPrefService)
              .getBranch("lightweightThemes.");
let observerService = Cc["@mozilla.org/observer-service;1"].getService(Ci.nsIObserverService);

function createLWTheme(obj){
  let buf = {
    id: null,
    name: null,
    accentcolor: "-moz-diag",
    textcolor: "-moz-diagtext",
    description: "custom personas",
    author: "",
    headerURL: "",
    footerURL: "",
    previewURL: "",
    iconURL: "",
  };
  for (let key in obj){
    switch(key){
      case "headerURL":
      case "footerURL":
      case "previewURL":
      case "iconURL":
        let path = obj[key];
        if (path.charAt(0) == "~")
          path = io.File("~").path + path.substr(1);
        let uri = util.createURI(path);
        buf[key] = uri.spec;
        break;
      default:
        buf[key] = obj[key];
    }
  }
  if (!buf.name)
    buf.name = buf.id;

  return buf;
}

function appendThemes(aThemes){
  if (!aThemes)
    aThemes = liberator.globalVariables.lwt;
  if (!(aThemes instanceof Array))
    aThemes = [aThemes];
  let currentThemes = LightweightThemeManager.usedThemes;
  aThemes.forEach(function(theme){
    let t = createLWTheme(theme);
    if (t && t.id){
      for (let i=0, len = currentThemes.length; i<len; i++){
        if (currentThemes[i].id == t.id){
          currentThemes.splice(i, 1);
          break;
        }
      }
      currentThemes.push(t);
    }
  });
  prefs.setCharPref("usedThemes", JSON.stringify(currentThemes));
  observerService.notifyObservers(null, "lightweight-theme-list-changed", null);
}

if (liberator.globalVariables.lwt instanceof Array){
  appendThemes(liberator.globalVariables.lwt);
}

function fileCompleter(c){
  return completion.runCompleter("file", c.filter).map(function(f) [f.path, f.leafName]);
}
let options = [
  ["textcolor",   ["-c", "-color"], commands.OPTION_STRING],
  ["accentcolor", ["-a", "-accent"], commands.OPTION_STRING],
  ["headerURL",   ["-h", "-header"], commands.OPTION_STRING, null, fileCompleter],
  ["footerURL",   ["-f", "-footer"], commands.OPTION_STRING, null, fileCompleter],
];
commands.addUserCommand(['personas'], "Personas Theme",
  function(args){
    let id = args[0];
    if (args.bang){
      LightweightThemeManager.forgetUsedTheme(id);
      return;
    }
    let registeredThemer = LightweightThemeManager.getUsedTheme(id);
    if (registeredThemer) {
      LightweightThemeManager.currentTheme = registeredThemer;
    } else {
      let buf = {id: id};
      options.forEach(function(opt){
        if (args[opt[1][0]])
          buf[opt[0]] = args[opt[1][0]];
      });
      let t = createLWTheme(buf);
      if (t)
        LightweightThemeManager.currentTheme = t;
    }
  }, {
    argCount: "1",
    bang: true,
    options: options.map(function(opt) opt.slice(1)),
    completer: function(context, args){
      context.format = {
        title: ["Name","Description"],
        keys: { text: "id", description: "name", icon: "iconURL" },
        process: [
          function name(item, text) <span sltyle="vertial-align: center">
            <img src={item.icon}/><span>{item.item.id}</span>
          </span>,
          function desc(item, text) <>
            <img src={item.item.previewURL} align="left" style="height:3em;"/>
            <span>{item.item.name}<br/>{item.item.description}</span>
          </>,
        ]
      }
      context.completions = LightweightThemeManager.usedThemes;
    }
  }, true);

// vim: sw=2 ts=2 et:
