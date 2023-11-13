<script>
export default {
    props: {
        headline: String,
        studyChild: Object,
    },
};
</script>

<template>
    <section v-show="studyChild.length">
        <h2>{{ headline }}</h2>
        <ul>
            <li v-for="element in studyChild" :key="element.id">
                <img :src="element.image" />
                <span>{{ element.name }}</span>
                <input type="checkbox" v-model="element.studied" />
            </li>
        </ul>
    </section>
</template>

<style scoped>
h2 {
    margin: 0;
}

section {
    margin-top: 10px;
}

ul {
    padding: 0;
    margin: 0;
}

li {
    list-style: none;
    background-color: #fffbf0;
    color: #2e2e2e;
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 5px;
}

ul li img {
    height: 20px;
    border: 1px solid rgb(255, 255, 255);
}

ul li span {
    padding-left: 5px;
    padding-right: 5px;
}
</style>
