<template>
  <div class="content-renderer">
    <div v-for="(block, index) in content" :key="index" class="content-block">
      <component :is="getBlockComponent(block.type)" :block="block" />
    </div>
  </div>
</template>

<script setup>
import { h } from 'vue'

const props = defineProps({
  content: {
    type: Array,
    default: () => []
  }
})

const getBlockComponent = (type) => {
  const components = {
    paragraph: (props) => h('p', { class: 'paragraph' }, props.block.content),
    heading: (props) => h('h2', { class: 'heading' }, props.block.content),
    list: (props) => h('ul', { class: 'list' }, 
      (props.block.items || []).map(item => h('li', item))
    ),
    image: (props) => props.block.url 
      ? h('img', { src: props.block.url, alt: 'Blog image', class: 'media-image' })
      : null,
    video: (props) => props.block.url
      ? h('video', { src: props.block.url, controls: true, class: 'media-video' })
      : null,
    audio: (props) => props.block.url
      ? h('audio', { src: props.block.url, controls: true, class: 'media-audio' })
      : null,
    horizontal: (props) => h('div', { class: 'horizontal-layout' },
      (props.block.children || []).map(child => 
        h('div', { class: 'horizontal-item' },
          h(getBlockComponent(child.type), { block: child })
        )
      )
    )
  }
  
  return components[type] || ((props) => h('div', 'Unknown block type'))
}
</script>

<style scoped>
.content-renderer {
  width: 100%;
}

.content-block {
  margin-bottom: 1.5rem;
}

.paragraph {
  font-size: 1.125rem;
  line-height: 1.8;
  color: var(--text-dark);
  margin: 1rem 0;
}

.heading {
  font-size: 1.875rem;
  font-weight: 700;
  color: var(--text-dark);
  margin: 2rem 0 1rem 0;
  line-height: 1.3;
}

.list {
  padding-left: 2rem;
  margin: 1rem 0;
}

.list li {
  font-size: 1.125rem;
  line-height: 1.8;
  color: var(--text-dark);
  margin-bottom: 0.5rem;
}

.media-image {
  width: 100%;
  max-width: 100%;
  height: auto;
  border-radius: 0.5rem;
  margin: 1.5rem 0;
}

.media-video {
  width: 100%;
  max-width: 100%;
  border-radius: 0.5rem;
  margin: 1.5rem 0;
}

.media-audio {
  width: 100%;
  margin: 1.5rem 0;
}

.horizontal-layout {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
  margin: 2rem 0;
  padding: 1.5rem;
  background: var(--bg-light);
  border-radius: 0.5rem;
}

.horizontal-item {
  padding: 1rem;
}
</style>
