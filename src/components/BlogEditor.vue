<template>
  <div class="blog-editor">
    <div class="form-group">
      <label>Blog Title</label>
      <input v-model="title" type="text" placeholder="Enter blog title" />
    </div>
    
    <div class="form-group">
      <label>Thumbnail URL</label>
      <input v-model="thumbnailUrl" type="text" placeholder="Enter thumbnail image URL" />
    </div>
    
    <div class="form-group">
      <label>Blog Content</label>
      <p class="helper-text">Add content blocks below. Drag to reorder.</p>
    </div>
    
    <div class="content-blocks">
      <ContentBlock
        v-for="(block, index) in contentBlocks"
        :key="block.id"
        :block="block"
        :index="index"
        @update="updateBlock"
        @delete="deleteBlock"
        @move-up="moveBlockUp"
        @move-down="moveBlockDown"
      />
    </div>
    
    <div class="add-block-buttons">
      <button @click="addBlock('paragraph')" type="button">+ Paragraph</button>
      <button @click="addBlock('heading')" type="button">+ Heading</button>
      <button @click="addBlock('list')" type="button">+ Bullet List</button>
      <button @click="addBlock('image')" type="button">+ Image</button>
      <button @click="addBlock('video')" type="button">+ Video</button>
      <button @click="addBlock('audio')" type="button">+ Audio</button>
      <button @click="addBlock('horizontal')" type="button">+ Horizontal Layout</button>
    </div>
    
    <div class="form-actions">
      <button @click="handleSave" class="save-btn" :disabled="saving || !title">
        {{ saving ? 'Saving...' : 'Save Blog' }}
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import ContentBlock from './ContentBlock.vue'

const props = defineProps({
  saving: Boolean
})

const emit = defineEmits(['save'])

const title = ref('')
const thumbnailUrl = ref('')
const contentBlocks = ref([])
let blockIdCounter = 0

const addBlock = (type) => {
  const newBlock = {
    id: blockIdCounter++,
    type,
    content: '',
    children: type === 'horizontal' ? [] : undefined
  }
  contentBlocks.value.push(newBlock)
}

const updateBlock = (index, updatedBlock) => {
  contentBlocks.value[index] = updatedBlock
}

const deleteBlock = (index) => {
  contentBlocks.value.splice(index, 1)
}

const moveBlockUp = (index) => {
  if (index > 0) {
    const temp = contentBlocks.value[index]
    contentBlocks.value[index] = contentBlocks.value[index - 1]
    contentBlocks.value[index - 1] = temp
  }
}

const moveBlockDown = (index) => {
  if (index < contentBlocks.value.length - 1) {
    const temp = contentBlocks.value[index]
    contentBlocks.value[index] = contentBlocks.value[index + 1]
    contentBlocks.value[index + 1] = temp
  }
}

const handleSave = () => {
  if (!title.value) {
    alert('Please enter a blog title')
    return
  }
  
  const blogData = {
    title: title.value,
    thumbnail_url: thumbnailUrl.value || null,
    content: contentBlocks.value,
    created_at: new Date().toISOString()
  }
  
  emit('save', blogData)
}
</script>

<style scoped>
.blog-editor {
  width: 100%;
}

.form-group {
  margin-bottom: 1.5rem;
}

label {
  display: block;
  font-weight: 600;
  margin-bottom: 0.5rem;
  color: var(--text-dark);
}

.helper-text {
  font-size: 0.875rem;
  color: var(--text-light);
  margin-top: 0.25rem;
}

.content-blocks {
  margin-bottom: 2rem;
}

.add-block-buttons {
  display: flex;
  flex-wrap: wrap;
  gap: 0.75rem;
  margin-bottom: 2rem;
}

.add-block-buttons button {
  padding: 0.5rem 1rem;
  background: var(--bg-light);
  color: var(--text-dark);
  border: 1px solid var(--border-color);
  font-size: 0.875rem;
}

.add-block-buttons button:hover {
  background: var(--border-color);
}

.form-actions {
  border-top: 1px solid var(--border-color);
  padding-top: 2rem;
  display: flex;
  justify-content: flex-end;
}

.save-btn {
  padding: 0.75rem 2rem;
  font-size: 1.125rem;
}
</style>
