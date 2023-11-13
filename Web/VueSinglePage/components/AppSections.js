import AppSectionsList from "./AppSectionsList.js";

export default {
    components: { AppSectionsList },
    template: /*html*/ `
        <app-sections-list 
            headline="未学习" 
            :studyChild="filters.beforeStudy">
        </app-sections-list>
        <app-sections-list 
            headline="已学习" 
            :studyChild="filters.afterStudy">
        </app-sections-list>
    `,
    data() {
        return {
            langlists: [
                { id: 1, name: 'Vue', image: './img/vue.png', studied: false },
                { id: 2, name: '数据库', image: './img/database.png', studied: false },
                { id: 3, name: 'Python', image: './img/python.png', studied: false },
                { id: 4, name: 'Golang', image: './img/go.png', studied: false }
            ]
        }
    },
    computed: {
        filters() {
            return {
                beforeStudy: this.langlists.filter(item => !item.studied),
                afterStudy: this.langlists.filter(item => item.studied)
            }
        }
    }
}
