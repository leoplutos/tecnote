package javagrpc.service;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import com.google.protobuf.Empty;
import io.grpc.Status;
import io.grpc.stub.StreamObserver;
import javagrpc.grpc.stub.DisTransGrpc.DisTransImplBase;
import javagrpc.grpc.stub.DisTransPb.DisTransReq;

// 资金转出业务逻辑
public class TransferInServiceImpl extends DisTransImplBase {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	// 资金转出
	@Override
	public void transferOut(DisTransReq request, StreamObserver<Empty> responseObserver) {
		// 资金转出
		long minus = request.getAmount();
		// 为了模拟失败设定的字段（空:成功，FAILURE:失败）
		String transferOutFlg = request.getTransOutResult();
		if (transferOutFlg.isEmpty() || !transferOutFlg.equals("FAILURE")) {
			// 正常业务
			log.info("[Java][Server]Dtm测试 资金转出前金额:{}, 转出金额:{}", GlobalData.readAmount(), minus);
			// 使用读写锁写入全局金额
			GlobalData.writeAmountMinus(minus);
			log.info("[Java][Server]Dtm测试 资金转出后金额:{}", GlobalData.readAmount());
			Empty empty = Empty.getDefaultInstance();
			responseObserver.onNext(empty);
			responseObserver.onCompleted();
		} else {
			// 异常业务
			// 真实情况下还需要考虑未扣款时失败了，回滚操作该如何处理，可以考虑子事务屏障
			// https://dtm.pub/practice/barrier.html
			String errorMsg = "资金转出异常";
			log.error("[Java][Server]Dtm测试 {}", errorMsg);
			// 使用 Status 发送错误信息
			responseObserver.onError(
					// 设置状态为 INTERNAL (内部错误)
					// 返回的Code为13，意思为内部错误
					Status.INTERNAL
							// 添加描述
							.withDescription(errorMsg)
							// 转换为 RuntimeException
							.asRuntimeException());
		}
	}

	// 资金转出回滚
	@Override
	public void transferOutRollback(DisTransReq request, StreamObserver<Empty> responseObserver) {
		// 资金转出回滚
		long plus = request.getAmount();
		// 为了模拟失败设定的字段（空:成功，FAILURE:失败）
		String transferOutFlg = request.getTransOutResult();
		if (transferOutFlg.isEmpty() || !transferOutFlg.equals("FAILURE")) {
			// 正常业务
			log.info("[Java][Server]Dtm测试 回滚前金额:{}, 回滚金额:{}", GlobalData.readAmount(), plus);
			// 使用读写锁写入全局金额
			GlobalData.writeAmountPlus(plus);
			log.info("[Java][Server]Dtm测试 回滚后金额:{}", GlobalData.readAmount());
		} else {
			// 异常业务
			// 因为转出业务对应的逻辑部分没有金额变动，所有此处只打印日志
			log.info("[Java][Server]Dtm测试 回滚成功,回滚后金额:{}", GlobalData.readAmount());
		}
		Empty empty = Empty.getDefaultInstance();
		responseObserver.onNext(empty);
		responseObserver.onCompleted();
	}

	// 资金转入
	@Override
	public void transferIn(DisTransReq request, StreamObserver<Empty> responseObserver) {
		String errorMsg = "不提供(资金转入transferIn)服务";
		log.warn("[Java][Server]Dtm测试 {}", errorMsg);
		// 使用 Status 发送错误信息
		responseObserver.onError(
				// 设置状态为 UNIMPLEMENTED (未实现)
				// 返回的Code为12，意思为此服务未实施或不支持/启用操作
				Status.UNIMPLEMENTED
						// 添加描述
						.withDescription(errorMsg)
						// 转换为 RuntimeException
						.asRuntimeException());
	}

	// 资金转入回滚
	@Override
	public void transferInRollback(DisTransReq request, StreamObserver<Empty> responseObserver) {
		String errorMsg = "不提供(资金转入回滚transferInRollback)服务";
		log.warn("[Java][Server]Dtm测试 {}", errorMsg);
		// 使用 Status 发送错误信息
		responseObserver.onError(
				// 设置状态为 UNIMPLEMENTED (未实现)
				// 返回的Code为12，意思为此服务未实施或不支持/启用操作
				Status.UNIMPLEMENTED
						// 添加描述
						.withDescription(errorMsg)
						// 转换为 RuntimeException
						.asRuntimeException());
	}
}
