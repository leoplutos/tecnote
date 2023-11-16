import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { StudySectionListComponent } from '../study-section-list/study-section-list.component';

//使用命令[ng generate component components/StudySection]创建
@Component({
	selector: 'app-study-section',
	standalone: true,
	imports: [CommonModule, StudySectionListComponent],
	templateUrl: './study-section.component.html',
	styleUrl: './study-section.component.css',
})
export class StudySectionComponent {
	//标题
	@Input() titleName: string = '';
	//未学习/已学习标识
	@Input() studyFlg: boolean = false;
}
