import StudySectionList from './StudySectionList.jsx'

function StudySection(props) {
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
		<>
			<h2>{props.titleName}</h2>
			<ul>
				{studyList}
			</ul>
		</>
	);
}

export default StudySection
