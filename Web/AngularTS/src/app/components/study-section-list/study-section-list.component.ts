import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { StudyListService } from '../../services/study-list.service';

//使用命令[ng generate component components/StudySectionList]创建
@Component({
	selector: 'app-study-section-list',
	standalone: true,
	imports: [CommonModule, FormsModule], //引入FormsModule进行双向数据绑定
	templateUrl: './study-section-list.component.html',
	styleUrl: './study-section-list.component.css',
})
export class StudySectionListComponent {

	//未学习/已学习标识
	@Input() studyFlg: boolean = false;

	//页面表示数据
	showList: Array<{ id: number, name: string, image: string, studied: boolean }>;

	constructor(private studyListService: StudyListService) {
		//从服务取得数据
		this.showList = studyListService.studyList;
	}
}
