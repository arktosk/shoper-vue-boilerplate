import Vue from 'vue';

document.addEventListener('DOMContentLoaded', () => {
    new Vue({
        name: 'Hello World',
        el: '#box_custom3',
        data: {
          seen: true
        },
        render(h) { return h('div', this.seen) }
      })
    console.log('test file stream send!')
})