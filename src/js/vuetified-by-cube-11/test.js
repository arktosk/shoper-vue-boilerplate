import Vue from 'vue';
import Slider from './boxes/slider';

document.addEventListener('frontAPIReady', console.log.bind(console, 'Front API loaded!'))
document.addEventListener('DOMContentLoaded', () => {
    new Vue({
        name: 'Hello World',
        render: (h) => h(Slider)
    }).$mount("#box_custom3")
    console.log('test file stream send second!')
})