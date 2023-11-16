import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StudySectionComponent } from './study-section.component';

describe('StudySectionComponent', () => {
	let component: StudySectionComponent;
	let fixture: ComponentFixture<StudySectionComponent>;

	beforeEach(async () => {
		await TestBed.configureTestingModule({
			imports: [StudySectionComponent]
		})
			.compileComponents();

		fixture = TestBed.createComponent(StudySectionComponent);
		component = fixture.componentInstance;
		fixture.detectChanges();
	});

	it('should create', () => {
		expect(component).toBeTruthy();
	});
});
