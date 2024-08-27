import Loki from 'lokijs';

//创建一个单例模式的服务,在需要时从任何地方注入或访问它
class LokiDbService {
	// 单例
	private static instance: LokiDbService;
	// 内存数据库
	private memoryDb: Loki;

	// 构造函数，初始化内存数据库
	private constructor() {
		console.log("内存数据库初始化开始");
		// 创建内存数据库
		this.memoryDb = new Loki("inmemory.db");


		// 创建login表和数据
		var login_tb: Collection<any> = this.memoryDb.addCollection("login", { unique: ['userId'], disableMeta: true });
		login_tb.insert({ userId: 'admin', password: '123' });

		// 创建todo表和数据
		var todo_tb: Collection<any> = this.memoryDb.addCollection("todo", { unique: ['todoId'], disableMeta: true });
		todo_tb.insert({ todoId: 1, todoName: 'Vue', image: './img/vue.png', studied: false });
		todo_tb.insert({ todoId: 2, todoName: '数据库', image: './img/database.png', studied: false });
		todo_tb.insert({ todoId: 3, todoName: 'Python', image: './img/python.png', studied: false });
		todo_tb.insert({ todoId: 4, todoName: 'Golang', image: './img/go.png', studied: false });

		// this.memoryDb.saveDatabase(error => {
		// 	console.log("保存数据");
		// 	error && console.log(error);
		// });
		console.log("内存数据库初始化结束");
	}

	// 取得单例
	public static getInstance(): LokiDbService {
		if (!LokiDbService.instance) {
			LokiDbService.instance = new LokiDbService();
		}
		return LokiDbService.instance;
	}

	// 取得用户信息
	public findUserByUserId(userId: string): Array<any> {
		//let results: Array<any> = this.memoryDb.getCollection("login").find({ 'userId': userId });
		let results: Array<any> = this.memoryDb.getCollection("login").find({ 'userId': userId }).map(this.removeLokiProps);
		return results;
	};

	// 取得用户信息
	public findUserByUserIdAndPassword(userId: string, password: string): Array<any> {
		let results: Array<any> = this.memoryDb.getCollection("login").find({ 'userId': userId, 'password': password }).map(this.removeLokiProps);
		return results;
	};

	// 取得Todo信息
	public findTodoByStudied(studied: boolean): Array<any> {
		let results: Array<any> = this.memoryDb.getCollection("todo").find({ 'studied': studied }).map(this.removeLokiProps);
		return results;
	};

	// 取得Todo信息
	public findTodoAll(): Array<any> {
		let results: any[] = this.memoryDb.getCollection("todo").find({}).map(this.removeLokiProps);
		return results;
	};

	// 删除结果集中的[$loki]属性
	private removeLokiProps(doc: any) {
		delete doc.$loki;
		return doc;
	}
}

export default LokiDbService;
