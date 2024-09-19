// 使用tonic_build自动生成存根
fn main() -> Result<(), Box<dyn std::error::Error>> {
    // 指定文件
    // tonic_build::compile_protos("../ProductInfo.proto")?;

    // 设定模式
    // tonic_build::configure().build_server(true).build_client(true).compile(
    //     &["proto/helloworld/helloworld.proto"],
    //     &["proto/helloworld"],
    // )?;

    let protos = vec!["proto/ProductInfo.proto"];
    for proto in protos {
        tonic_build::compile_protos(proto)?;
    }

    Ok(())
}
