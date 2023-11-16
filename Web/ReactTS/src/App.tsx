import { useState } from 'react'
import StudySection from './components/StudySection.tsx'
import './App.css'

const initList = [
	{
		id: 1,
		name: "Vue",
		image: "./img/vue.png",
		studied: false,
	},
	{
		id: 2,
		name: "数据库",
		image: "./img/database.png",
		studied: false,
	},
	{
		id: 3,
		name: "Python",
		image: "./img/python.png",
		studied: false,
	},
	{
		id: 4,
		name: "Golang",
		image: "./img/go.png",
		studied: false,
	},
];

function App() {
	//定义初始数据，并且“状态”化，为了双向数据绑定
	const [studyList, setStudyList] = useState(initList);
	//过滤未学习列表
	const notStudyList = studyList.filter((element) => element.studied === false)
	//过滤已学习列表
	const studiedList = studyList.filter((element) => element.studied === true)
	// updateList 函数用于更新初始数据内容
	const updateList = (updateId: number) => {
		setStudyList(studyList.map(t => {
			if (t.id === updateId) {
				// 如果 id 等于 参数就让studied取反
				t.studied = !t.studied
			}
			return t
		}));
		//console.log(studyList)
	}
	return (
		<>
			<h1>学习清单</h1>
			<StudySection titleName="未学习" list={notStudyList} updateEvent={updateList} />
			<StudySection titleName="已学习" list={studiedList} updateEvent={updateList} />
		</>
	);
}

export default App
