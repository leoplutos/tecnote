using Grpc.Core;
using DtmDemo;
using Serilog;
using Google.Protobuf.WellKnownTypes;

namespace netcoreServer.Services;

// 资金转入业务逻辑
public class TransferOutService : DisTrans.DisTransBase
{
	// appsettings.json 配置文件
	private readonly IConfiguration _configuration;

	public TransferOutService(IConfiguration configuration)
	{
		_configuration = configuration;
	}

	/// 资金转出
	public override Task<Empty> transferOut(DisTransReq request, ServerCallContext context)
	{
		string errorMsg = "不提供(资金转出transferOut)服务";
		Log.Warning("[.NET Core(C#)][Server]Dtm测试 {errorMsg}", errorMsg);
		// 设置状态为 Unimplemented (未实现)
		// 返回的Code为12，意思为此服务未实施或不支持/启用操作
		context.Status = new Status(StatusCode.Unimplemented, $"Unimplemented error: {errorMsg}");
		return Task.FromException<Empty>(new RpcException(context.Status));
	}

	/// 资金转出回滚
	public override Task<Empty> transferOutRollback(DisTransReq request, ServerCallContext context)
	{
		string errorMsg = "不提供(资金转出回滚transferOutRollback)服务";
		Log.Warning("[.NET Core(C#)][Server]Dtm测试 {errorMsg}", errorMsg);
		// 设置状态为 Unimplemented (未实现)
		// 返回的Code为12，意思为此服务未实施或不支持/启用操作
		context.Status = new Status(StatusCode.Unimplemented, $"Unimplemented error: {errorMsg}");
		return Task.FromException<Empty>(new RpcException(context.Status));
	}

	/// 资金转入
	public override Task<Empty> transferIn(DisTransReq request, ServerCallContext context)
	{
		// 资金转入
		long plus = request.Amount;
		// 为了模拟失败设定的字段（空:成功，FAILURE:失败）
		string transInFlg = request.TransInResult;
		if (string.IsNullOrEmpty(transInFlg) || !transInFlg.Equals("FAILURE"))
		{
			// 正常业务
			Log.Information("[.NET Core(C#)][Server]Dtm测试 资金转入前金额:{amount}, 转入金额:{plus}", GlobalData.ReadAmount(), plus);
			// 使用读写锁写入全局金额
			GlobalData.WriteAmountPlus(plus);
			Log.Information("[.NET Core(C#)][Server]Dtm测试 资金转入后金额:{amount}", GlobalData.ReadAmount());
			return Task.FromResult(new Empty());
		}
		else
		{
			// 异常业务
			// 真实情况下还需要考虑未扣款时失败了，回滚操作该如何处理，可以考虑子事务屏障
			// https://dtm.pub/practice/barrier.html
			string errorMsg = "资金转入异常";
			Log.Error("[.NET Core(C#)][Server]Dtm测试 {errorMsg}", errorMsg);
			// 设置状态为 Internal 内部错误)
			// 返回的Code为13，意思为内部错误
			context.Status = new Status(StatusCode.Internal, $"Internal error: {errorMsg}");
			return Task.FromException<Empty>(new RpcException(context.Status));
		}
	}

	/// 资金转入回滚
	public override Task<Empty> transferInRollback(DisTransReq request, ServerCallContext context)
	{
		// 资金转入回滚
		long minus = request.Amount;
		// 为了模拟失败设定的字段（空:成功，FAILURE:失败）
		string transInFlg = request.TransInResult;
		if (string.IsNullOrEmpty(transInFlg) || !transInFlg.Equals("FAILURE"))
		{
			// 正常业务
			Log.Information("[.NET Core(C#)][Server]Dtm测试 回滚前金额:{amount}, 回滚金额:{minus}", GlobalData.ReadAmount(), minus);
			// 使用读写锁写入全局金额
			GlobalData.WriteAmountMinus(minus);
			Log.Information("[.NET Core(C#)][Server]Dtm测试 回滚后金额:{amount}", GlobalData.ReadAmount());
		}
		else
		{
			// 异常业务
			// 因为转出业务对应的逻辑部分没有金额变动，所有此处只打印日志
			Log.Information("[.NET Core(C#)][Server]Dtm测试 回滚成功,回滚后金额:{amount}", GlobalData.ReadAmount());
		}
		return Task.FromResult(new Empty());
	}
}
