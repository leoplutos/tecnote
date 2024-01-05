# Actix Web相关

# 引言
基于 Rust 的 Web 框架有很多， ``Actix-Web`` 和 ``Axum`` 可以算这些中的佼佼者  
其他的框架可能太年轻、太底层、缺乏异步支持、不支持 tokio 或是目前已经不再维护  
- Actix-Web：拥有最好生态环境和社区（且它在 TechEmpower Web Framework Benchmarks 也拥有极高的排名）
- Axum：来自于 tokio 团队，所以说它的生态发展也会非常快

这里笔者基于 ``Actix-Web`` 来写一个示例工程

## 简介
Actix Web 是一个强大而实用的框架。从某种意义上说，它是一个微框架，但也有一些特殊的地方。如果你已经在使用 Rust，你可能会很快上手，但即使你是从其他编程语言转过来的，你也会发现 Actix Web 很容易上手

## 官网
 - [Actix Web - 官网](https://tech-cn.github.io/actix-website/docs/)
 - [Actix Web - Github](https://github.com/actix/actix-web)
 - [Actix Web - 官方示例代码](https://github.com/actix/examples)
 - [Axum - Github](https://github.com/tokio-rs/axum)
 - [Axum - 官方示例代码](https://github.com/tokio-rs/axum/tree/main/examples)

## 工程示例

### 创建工程
```
cd D:\WorkSpace\Rust
cargo new actix-test
cd actix-test
```

### 添加依赖
``Cargo.toml``中添加如下内容
```
[dependencies]
actix-web = "4"
actix-files = "0.6"
handlebars = { version = "4.5", features = ["dir_source"] }
serde = { version = "1.0", features = ["derive"] }
serde_json = "1"
```
关于 handlebars 可以看 [这里](https://www.handlebarsjs.cn/guide/)

### 新建一个简单的Controller
``src/main.rs``
```
use actix_files as fs;
use actix_web::{
    body::BoxBody,
    dev::ServiceResponse,
    get,
    http::{header::ContentType, StatusCode},
    middleware::{ErrorHandlerResponse, ErrorHandlers},
    web, App, HttpResponse, HttpServer, Result,
};
use handlebars::Handlebars;
use serde::Deserialize;
use serde_json::json;
use std::io;

#[derive(Deserialize)]
pub struct HelloRequest {
    message: Option<String>,
}

// GET：请求方式；/hello：请求的路径
// 传递的参数取得方法
// GET请求：使用 web::Query
// POST请求：使用 web::Form
#[get("/hello")]
async fn hello(
    hb: web::Data<Handlebars<'_>>,
    web::Query(param): web::Query<HelloRequest>,
) -> HttpResponse {
    let mut ret_message = String::from("你好，Actix-Web");
    //从参数中取得传递内容
    if let Some(message) = param.message {
        println!("the parameter [message] is : {}", message);
        ret_message = message.clone();
    }
    let data = json!({
        "title": "这是一个Actix-Web的示例",
        "message": ret_message
    });
    // 结果使用Handlebars模板渲染，渲染的文件为hello.html
    let body = hb.render("hello", &data).unwrap();

    HttpResponse::Ok().body(body)
}

#[actix_web::main]
async fn main() -> io::Result<()> {
    // Handlebars模板的实例
    let mut handlebars = Handlebars::new();
    handlebars
        //渲染扩展名为.html，映射路径为根目录下的templates
        .register_templates_directory(".html", "./templates")
        .unwrap();
    let handlebars_ref = web::Data::new(handlebars);

    println!("starting HTTP server at http://localhost:8080/");

    HttpServer::new(move || {
        App::new()
            //异常处理
            .wrap(error_handlers())
            //Handlebars模板
            .app_data(handlebars_ref.clone())
            //加载服务
            .service(hello)
            //加载静态资源文件，第一个参数为访问网站时的URL，第二个参数为本地文件路径
            //在配置路径时，根路径要放在最后配置，不然会导致在根路径之后配置的路径无法访问
            .service(fs::Files::new("/", "./static/").show_files_listing())
    })
    //绑定ip和端口
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}

// 定制错误处理
fn error_handlers() -> ErrorHandlers<BoxBody> {
    ErrorHandlers::new().handler(StatusCode::NOT_FOUND, not_found)
}

// 定制404错误页
fn not_found<B>(res: ServiceResponse<B>) -> Result<ErrorHandlerResponse<BoxBody>> {
    let response = get_error_response(&res, "Page not found");
    Ok(ErrorHandlerResponse::Response(ServiceResponse::new(
        res.into_parts().0,
        response.map_into_left_body(),
    )))
}

// 泛型错误处理
fn get_error_response<B>(res: &ServiceResponse<B>, error: &str) -> HttpResponse<BoxBody> {
    let request = res.request();

    // Provide a fallback to a simple plain text response in case an error occurs during the
    // rendering of the error page.
    let fallback = |err: &str| {
        HttpResponse::build(res.status())
            .content_type(ContentType::plaintext())
            .body(err.to_string())
    };

    let hb = request
        .app_data::<web::Data<Handlebars>>()
        .map(|t| t.get_ref());
    match hb {
        Some(hb) => {
            let data = json!({
                "error": error,
                "status_code": res.status().as_str()
            });
            let body = hb.render("error", &data);

            match body {
                Ok(body) => HttpResponse::build(res.status())
                    .content_type(ContentType::html())
                    .body(body),
                Err(_) => fallback(error),
            }
        }
        None => fallback(error),
    }
}
```

### 新建前端的html模板

#### 分别新建5个文件

``templates/header.html``  
```
<html>
<head>
  <title>{{title}}</title>
  <link rel="stylesheet" href="css/style.css" />
  <script src="js/main.js"></script>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body>
<h1>这是header.html</h1>
<hr />
```

``templates/footer.html``  
```
<hr />
<h1>这是footer.html</h1>
</body>
</html>
```

``templates/hello.html``  
```
{{> header}}

<h1>这是hello.html</h1>
<p>title：{{title}}</p>
<p>message：{{message}}</p>
<button onclick="aletMessage()">测试按钮</button>

{{> footer}}
```

``static/css/style.css``  
```
h1 {
	color: #005f5f
}
p {
	color: blue
}
```

``static/js/main.js``  
```
function aletMessage() {
  alert("测试按钮已按下");
}
```

### 编译+启动工程
```
cd D:\WorkSpace\Rust\actix-test
cargo run
```

使用浏览器访问  
http://localhost:8080/hello  
http://localhost:8080/hello?message=mytest  

