# WebAssembly

## 简介
WebAssembly 是一种新的编码方式，它是一种低级的类汇编语言，具有紧凑的二进制格式，可以接近原生的性能运行  
并为诸如 C/C++/Rust/AssemblyScript 等语言提供一个编译目标，以便它们可以在浏览器/Node.js上运行  
它也被设计为可以与JavaScript共存，允许两者一起工作  
WebAssembly 规范了两种文件格式，一种称为 WebAssembly 模块的二进制格式，扩展名为 ``.wasm``，相应的文本表示称为 WebAssembly 文本格式，扩展名为 ``.wat``

WebAssembly 于 2019 年 12 月 5 日成为万维网联盟（W3C）的推荐标准，与 HTML，CSS 和 JavaScript 一起成为 Web 的第四种语言  

一些目前已经成功落地的 WebAssembly 的应用。
 - eBay 的条形码扫描
 - AutoCAD
 - 谷歌地球（Google Earth）
 - Figma
 - Bilibili Web 投稿系统

## 官网
- [官网](https://webassembly.org/)
- [官网开发者向导](https://webassembly.org/getting-started/developers-guide/)
- [Rust示例 - 使用wasm-pack ](https://developer.mozilla.org/en-US/docs/WebAssembly/Rust_to_wasm)
- [AssemblyScript示例](https://www.assemblyscript.org/getting-started.html)
- [Node.js中运行WebAssembly](https://dev.nodejs.cn/learn/nodejs-with-webassembly/)


## 开发语言选型

### Rust

- 优势：  
  Rust -> WebAssembly 的成熟度是比 AssemblyScript 高得多  
  无 GC 中断、零开销抽象，这能够给内存占用、运行性能都带来质变级的提升。

- 劣势：  
  Rust 语言过于底层、学习成本高、编程范式对开发者的约束性极强等缺点  
  可维护性相对没那么高。部分公司对 Rust 的关注度不高

- 应用面：  
  更适合性能提升的场景。算法优化，图片处理，文件处理等纯优化场景。  

### AssemblyScript：

- 优势：  
  AS 运行时具有 GC，且支持绝大多数 OOP 写法，相比偏底层的 Native 语言在开发效率上有质的提升。最接近前端语种，在前端生态上最容易被接受。

- 劣势：  
  AS 在语言上并不够成熟，没有 Virtual Overload 支持、有限的闭包支持、异常处理比较简陋。性能和灵活度不如 Rust/C++  
  AssemblyScript 生态中的工具库还不完善

- 应用面：  
  适合更偏前端业务开发场景。如沙盒场景、插件场景、小程序执行线程场景。  

## 应用面
 - 游戏
 - 文件处理相关：大文件上传、切片。
 - 图片/视频处理：如封面生成，二维码生成。
 - AI 方向
 - 区块链方向
 - 沙箱方向
 - 跨端方向：如 WebAssembly 可以作为 JS 执行环节，作为小程序的逻辑线程
