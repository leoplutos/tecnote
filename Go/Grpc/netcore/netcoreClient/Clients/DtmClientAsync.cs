using Serilog;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Dtmgrpc;
using DtmDemo;

namespace netcoreClient.Clients;

// Dtm示例
// 需要依赖 dotnet add package Dtmgrpc
class DtmClientAsync
{
	// appsettings.json 和 环境变量
	private readonly IConfiguration _config;

	public DtmClientAsync(IConfiguration config)
	{
		_config = config;
	}

	public async Task DtmClient()
	{
		// dtm服务URL
		string dtmGprcUrl = "http://localhost:36790";

		Log.Information("DtmClient 开始");
		// 创建服务提供者
		var serviceProvider = new ServiceCollection()
		 	.AddLogging(loggingBuilder =>
			{
				loggingBuilder.SetMinimumLevel(LogLevel.Debug);
			})
			// 注册dtm
			.AddDtmGrpc(x =>
			{
				x.DtmGrpcUrl = dtmGprcUrl;
			})
			// 注册汇款服务
			.AddSingleton<IDisTransLogic, DisTransLogic>()
			.BuildServiceProvider();

		// 获取汇款服务实例
		var disTransLogic = serviceProvider.GetService<IDisTransLogic>();
		if (disTransLogic == null)
		{
			Log.Error("无法取得汇款服务示例 IDisTransLogic");
			throw new Exception("无法取得汇款服务示例 IDisTransLogic");
		}
		else
		{
			// 汇款前银行A余额：10000 银行B余额：10000
			// 汇款第一次：100 成功
			await disTransLogic.RemittanceAsync(100, "", "");
			// 汇款第二次：200 transferOut会失败
			await disTransLogic.RemittanceAsync(200, "FAILURE", "");
			// 汇款第三次：300 transferIn会失败
			await disTransLogic.RemittanceAsync(300, "", "FAILURE");
			// 全部运行后，只有第一次汇款成功
			// 汇款后银行A余额：9900 银行B余额：10100
		}

		Log.Information("DtmClient 结束");
	}

}

// 汇款服务接口
public interface IDisTransLogic
{
	public Task RemittanceAsync(long amount, string transOutResult, string transInResult);
}

// 汇款服务实现类
class DisTransLogic : IDisTransLogic
{
	// dtm工厂
	private readonly IDtmTransFactory _transFactory;

	// 构造函数
	public DisTransLogic(IDtmTransFactory transFactory)
	{
		this._transFactory = transFactory;
	}

	// 汇款业务
	public async Task RemittanceAsync(long amount, string transOutResult, string transInResult)
	{
		try
		{
			// dtm 的 Global ID
			var gid = Guid.NewGuid().ToString();
			Log.Information("Dtm 汇款 开始, gid: {gid}", gid);
			Log.Information("amount: {amount}, transOutResult: {transOutResult}, transInResult: {transInResult}", amount, transOutResult, transInResult);
			// 汇款金额
			var request = new DisTransReq { Amount = amount, TransOutResult = transOutResult, TransInResult = transInResult };
			// 当 svc 以 http 或 https 开头时，DTM 服务器将向 svc 发送 HTTP 请求, 比如 [http://localhost:50051]
			// 当 svc 不以 http 或 https 开头时，DTM 服务器会向 svc 发送 gRPC 请求, 比如 [localhost:50051]
			// 因为 dtm 和 各个微服务都在容器内运行，这里设定宿主机地址
			var transferOutSvc = "host.docker.internal:50051";
			var transferInSvc = "host.docker.internal:50052";
			// sage 模式
			var saga = _transFactory.NewSagaGrpc(gid);
			// 添加 saga子事务
			saga.Add(
				// 正常操作URL
				transferOutSvc + "/dtm_demo.DisTrans/transferOut",
				// 回滚操作URL
				transferOutSvc + "/dtm_demo.DisTrans/transferOutRollback",
				// 操作参数
				request);
			saga.Add(
				transferInSvc + "/dtm_demo.DisTrans/transferIn",
				transferInSvc + "/dtm_demo.DisTrans/transferInRollback",
				request);
			// 开启等待结果
			saga.EnableWaitResult()
				// 让saga并发执行（默认是顺序执行）
				.EnableConcurrent()
				// 设定重试次数
				.SetRetryLimit(1)
				//.SetRetryInterval(10)
				//.SetTimeoutToFail(100)
				;

			// 提交saga事务，dtm会完成所有的子事务/回滚所有的子事务
			await saga.Submit();

			Log.Information("Dtm 汇款 结束, gid: {gid}", gid);
		}
		catch (Exception ex)
		{
			Log.Error(ex, "客户端意外终止");
		}
	}
}
