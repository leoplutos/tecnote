import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet } from '@angular/router';
import { StudySectionComponent } from './components/study-section/study-section.component';

@Component({
	selector: 'app-root',
	standalone: true,
	imports: [CommonModule, RouterOutlet, StudySectionComponent],
	templateUrl: './app.component.html',
	styleUrls: ['./app.component.css']
})
export class AppComponent {
	notStudyTitle: string = '未学习';
	notStudyFlg: boolean = false;
	studiedTitle: string = '已学习';
	studiedFlg: boolean = true;
}