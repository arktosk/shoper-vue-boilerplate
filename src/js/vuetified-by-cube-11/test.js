import Vue from 'vue';

document.addEventListener('frontAPIReady', console.log.bind(console, 'Front API loaded!'))
document.addEventListener('DOMContentLoaded', () => {
    new Vue({
        name: 'Hello World',
        el: '#box_custom3',
        data: {
          content: 'This is new content rendered by vue.js'
        }, 
        render(h) { return h('div', this.content) }
      })
    console.log('test file stream send second!')
})