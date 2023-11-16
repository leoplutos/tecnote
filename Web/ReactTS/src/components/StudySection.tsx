import StudySectionList from './StudySectionList.tsx'
import './StudySection.css'

interface StudySectionProps {
	titleName: string;
	list: {
		id: number;
		name: string;
		image: string;
		studied: boolean;
	}[];
	updateEvent: Function;
}

function StudySection(props: StudySectionProps) {
	const studyList = props.list.map((element) => (
		<StudySectionList
			image={element.image}
			name={element.name}
			studied={element.studied}
			studyId={element.id}
			key={element.id}
			updateEvent={props.updateEvent}
		/>
	));
	return (
		<section>
			<h2>{props.titleName}</h2>
			<ul>
				{studyList}
			</ul>
		</section>
	);
}

export default StudySection
