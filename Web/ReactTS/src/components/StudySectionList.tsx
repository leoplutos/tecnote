import { useEffect } from 'react'
import './StudySectionList.css'

interface StudySectionListProps {
	studyId: number;
	name: string;
	image: string;
	studied: boolean;
	updateEvent: Function;
}

function StudySectionList(props: StudySectionListProps) {
	const changeHandler = () => {
		//按下checkbox时的监听函数，会调用根组件[App]的updateList函数，这样写是为了传参
		props.updateEvent(props.studyId)
	}
	useEffect(() => {
		//使用系统函数useEffect hook来模拟componentDidMount生命周期方法
		//console.log('StudySectionList Component has mounted');
	}, []);
	return (
		<li>
			<img src={props.image} /><span>{props.name}</span><input type="checkbox" defaultChecked={props.studied} onChange={changeHandler} />
		</li>
	);
}

export default StudySectionList
