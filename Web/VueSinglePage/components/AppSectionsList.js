export default {
    template: /*html*/ `
        <section v-show="studyChild.length">
            <h2>{{ headline }}</h2>
            <ul>
                <li v-for="element in studyChild" :key="element.id">
                    <img :src="element.image">
                    <span>{{ element.name }}</span>
                    <input type="checkbox" v-model="element.studied">
                </li>
            </ul>
        </section>
    `,
    props: {
        headline: String,
        studyChild: Object
    }
}
