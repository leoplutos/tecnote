import { Injectable } from '@angular/core';

//使用命令[ng generate service services/StudyList]创建
//使用服务来让各个组件之间共享数据
@Injectable({
	// 在根注入器中提供该服务,从而实现根注入器将服务注入，它就在整个应用程序中可用了
	// 也可在对应的模块/组件中的providers导入该服务
	providedIn: 'root'
})
export class StudyListService {

	//在服务定义数据，共享给组件使用
	public studyList: Array<{ id: number, name: string, image: string, studied: boolean }> = [
		{
			id: 1,
			name: "Vue",
			image: "./assets/img/vue.png",
			studied: false,
		},
		{
			id: 2,
			name: "数据库",
			image: "./assets/img/database.png",
			studied: false,
		},
		{
			id: 3,
			name: "Python",
			image: "./assets/img/python.png",
			studied: false,
		},
		{
			id: 4,
			name: "Golang",
			image: "./assets/img/go.png",
			studied: false,
		},
	];

	//空的构造函数
	constructor() { }
}
