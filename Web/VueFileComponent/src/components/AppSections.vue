<script>
import AppSectionsList from "./AppSectionsList.vue";

export default {
    components: { AppSectionsList },
    data() {
        return {
            langlists: [
                { id: 1, name: "Vue", image: "./img/vue.png", studied: false },
                { id: 2, name: "数据库", image: "./img/database.png", studied: false },
                { id: 3, name: "Python", image: "./img/python.png", studied: false },
                { id: 4, name: "Golang", image: "./img/go.png", studied: false },
            ],
        };
    },
    computed: {
        filters() {
            return {
                beforeStudy: this.langlists.filter((item) => !item.studied),
                afterStudy: this.langlists.filter((item) => item.studied),
            };
        },
    },
};
</script>

<template>
    <AppSectionsList headline="未学习" :studyChild="filters.beforeStudy"> </AppSectionsList>
    <AppSectionsList headline="已学习" :studyChild="filters.afterStudy"> </AppSectionsList>
</template>
