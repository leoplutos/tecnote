# VSCode自定义语法高亮

## 起因
起因是笔者要参与一个 Qlik 的开发，会写一些 Qlik Script  
在VSCode下找到了一个语法插件 [Qlik](https://marketplace.visualstudio.com/items?itemName=Gimly81.qlik)  
但是发现最后一次仓库的更新是4年前(2019年)，很多关键字并没有被渲染，于是乎开始了折腾之路

## VSCode的语法渲染
如 [官方帮助文档](https://code.visualstudio.com/api/language-extensions/syntax-highlight-guide) 所说明，VSCode 是使用 ``TextMate`` 来语法解析的  
官方给出的范围列表在 [这里](https://macromates.com/manual/en/language_grammars) 可以查到

## 修改插件的渲染

### 找到对应插件渲染高亮的文件
渲染高亮的文件名为 ``tmLanguage``  
一些新的插件都已经使用 ``json`` 格式了，而一些许久未更新的还是使用的 ``xml`` 格式  
比如  
 - Vue插件(Volar)的文件名：vue.tmLanguage.json
 - Qlik插件的文件名：qvs.tmLanguage

位置在
```
%USERPROFILE%\.vscode\extensions\{插件名字}\syntaxes
```
笔者修改的 Qlik 插件的位置就在
```
%USERPROFILE%\.vscode\extensions\gimly81.qlik-0.5.0\syntaxes
```

### 修改渲染高亮的文件
需要懂正则表达式，然后看一下官方文档之后即可很容易修改和添加  
这里给出一个笔者修改的高亮文件  
- [qvs.tmLanguage](./VSCode-conf/custom-highlight/qvs.tmLanguage)
