import { TestBed } from '@angular/core/testing';

import { StudyListService } from './study-list.service';

describe('StudyListService', () => {
	let service: StudyListService;

	beforeEach(() => {
		TestBed.configureTestingModule({});
		service = TestBed.inject(StudyListService);
	});

	it('should be created', () => {
		expect(service).toBeTruthy();
	});
});
