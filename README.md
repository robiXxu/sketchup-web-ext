# SketchUp Web Ext
#### A simple extension that allows you to load any webpage in a Sketchup HtmlDialog

## Configuration

### On a mac

```
mkdir /tmp/webExt
touch /tmp/webExt/config.json
```

### On a Windows

```
1. winkey + r to open up run box
2. type %temp% and press enter
3. inside the temporary folder create new folder called webExt
4. navigate inside webExt folder and create a new file called config.json
```

## [config.json](config.json) contents

```js
{
  "url": "https://www.google.com",
  "width": 1920,
  "height": 1000,
  "center": true,
  "style": "dialog"
}
```

## Dev

To update this extension and for easier testing create a symlink to both files

```bash
ln -s $(pwd)/sketchup_web_ext $HOME/Library/Application\ Support/SketchUp\ 2019/SketchUp/Plugins/sketchup_web_ext
ln -s $(pwd)/sketchup_web_ext.rb $HOME/Library/Application\ Support/SketchUp\ 2019/SketchUp/Plugins/sketchup_web_ext.rb
```

### Release

Creating an .rbz is simple.

1. Select extension files and create a zip.
2. Rename zip archive to sketchup_web_ext
3. Change extension from .zip to .rbz

### Installing

1. Open Extension Manager in SketchUp
2. Click on Manage tab
3. Click on Install Extension button at the bottom and select your rbz file.

