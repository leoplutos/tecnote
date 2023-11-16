import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StudySectionListComponent } from './study-section-list.component';

describe('StudySectionListComponent', () => {
	let component: StudySectionListComponent;
	let fixture: ComponentFixture<StudySectionListComponent>;

	beforeEach(async () => {
		await TestBed.configureTestingModule({
			imports: [StudySectionListComponent]
		})
			.compileComponents();

		fixture = TestBed.createComponent(StudySectionListComponent);
		component = fixture.componentInstance;
		fixture.detectChanges();
	});

	it('should create', () => {
		expect(component).toBeTruthy();
	});
});
