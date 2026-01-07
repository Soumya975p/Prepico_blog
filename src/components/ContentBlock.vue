<template>
  <div class="content-block">
    <div class="block-header">
      <span class="block-type">{{ block.type }}</span>
      <div class="block-controls">
        <button @click="$emit('move-up', index)" type="button" class="control-btn">↑</button>
        <button @click="$emit('move-down', index)" type="button" class="control-btn">↓</button>
        <button @click="$emit('delete', index)" type="button" class="control-btn delete-btn">×</button>
      </div>
    </div>
    
    <div class="block-content">
      <textarea
        v-if="block.type === 'paragraph' || block.type === 'heading'"
        v-model="blockData.content"
        @input="emitUpdate"
        :placeholder="getPlaceholder()"
        :rows="block.type === 'paragraph' ? 4 : 2"
      />
      
      <div v-else-if="block.type === 'list'">
        <div v-for="(item, idx) in blockData.items" :key="idx" class="list-item">
          <input v-model="blockData.items[idx]" @input="emitUpdate" type="text" placeholder="List item" />
          <button @click="removeListItem(idx)" type="button" class="control-btn delete-btn">×</button>
        </div>
        <button @click="addListItem" type="button" class="add-item-btn">+ Add Item</button>
      </div>
      
      <input
        v-else-if="['image', 'video', 'audio'].includes(block.type)"
        v-model="blockData.url"
        @input="emitUpdate"
        type="text"
        :placeholder="`Enter ${block.type} URL`"
      />
      
      <div v-else-if="block.type === 'horizontal'" class="horizontal-container">
        <p class="info-text">Horizontal layout - nest content blocks side by side</p>
        <div class="horizontal-children">
          <div v-for="(child, childIdx) in blockData.children" :key="child.id" class="horizontal-child">
            <ContentBlock
              :block="child"
              :index="childIdx"
              @update="updateChild"
              @delete="deleteChild"
              @move-up="moveChildUp"
              @move-down="moveChildDown"
            />
          </div>
        </div>
        <div class="add-child-buttons">
          <button @click="addChild('paragraph')" type="button">+ Paragraph</button>
          <button @click="addChild('image')" type="button">+ Image</button>
          <button @click="addChild('list')" type="button">+ List</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive, watch } from 'vue'

const props = defineProps({
  block: Object,
  index: Number
})

const emit = defineEmits(['update', 'delete', 'move-up', 'move-down'])

const blockData = reactive({
  ...props.block,
  items: props.block.items || [''],
  url: props.block.url || '',
  children: props.block.children || []
})

let childIdCounter = 0

const emitUpdate = () => {
  emit('update', props.index, { ...blockData })
}

const getPlaceholder = () => {
  if (props.block.type === 'heading') return 'Enter heading text'
  if (props.block.type === 'paragraph') return 'Enter paragraph text'
  return ''
}

const addListItem = () => {
  blockData.items.push('')
  emitUpdate()
}

const removeListItem = (idx) => {
  blockData.items.splice(idx, 1)
  if (blockData.items.length === 0) blockData.items.push('')
  emitUpdate()
}

const addChild = (type) => {
  const newChild = {
    id: childIdCounter++,
    type,
    content: '',
    items: type === 'list' ? [''] : undefined,
    url: ['image', 'video', 'audio'].includes(type) ? '' : undefined
  }
  blockData.children.push(newChild)
  emitUpdate()
}

const updateChild = (childIdx, updatedChild) => {
  blockData.children[childIdx] = updatedChild
  emitUpdate()
}

const deleteChild = (childIdx) => {
  blockData.children.splice(childIdx, 1)
  emitUpdate()
}

const moveChildUp = (childIdx) => {
  if (childIdx > 0) {
    const temp = blockData.children[childIdx]
    blockData.children[childIdx] = blockData.children[childIdx - 1]
    blockData.children[childIdx - 1] = temp
    emitUpdate()
  }
}

const moveChildDown = (childIdx) => {
  if (childIdx < blockData.children.length - 1) {
    const temp = blockData.children[childIdx]
    blockData.children[childIdx] = blockData.children[childIdx + 1]
    blockData.children[childIdx + 1] = temp
    emitUpdate()
  }
}

watch(() => props.block, (newBlock) => {
  Object.assign(blockData, newBlock)
}, { deep: true })
</script>

<style scoped>
.content-block {
  background: var(--bg-light);
  border: 1px solid var(--border-color);
  border-radius: 0.375rem;
  padding: 1rem;
  margin-bottom: 1rem;
}

.block-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 0.75rem;
}

.block-type {
  font-weight: 600;
  color: var(--primary-color);
  text-transform: capitalize;
  font-size: 0.875rem;
}

.block-controls {
  display: flex;
  gap: 0.5rem;
}

.control-btn {
  padding: 0.25rem 0.5rem;
  background: var(--white);
  border: 1px solid var(--border-color);
  font-size: 1rem;
  cursor: pointer;
  border-radius: 0.25rem;
}

.control-btn:hover {
  background: var(--border-color);
}

.delete-btn {
  color: #DC2626;
}

.delete-btn:hover {
  background: #FEE2E2;
  border-color: #DC2626;
}

.block-content textarea,
.block-content input {
  width: 100%;
}

.list-item {
  display: flex;
  gap: 0.5rem;
  margin-bottom: 0.5rem;
  align-items: center;
}

.list-item input {
  flex: 1;
}

.add-item-btn {
  padding: 0.5rem 1rem;
  background: var(--white);
  color: var(--text-dark);
  border: 1px solid var(--border-color);
  font-size: 0.875rem;
  margin-top: 0.5rem;
}

.horizontal-container {
  padding: 0.5rem;
  background: var(--white);
  border-radius: 0.25rem;
}

.info-text {
  font-size: 0.875rem;
  color: var(--text-light);
  margin-bottom: 1rem;
}

.horizontal-children {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1rem;
  margin-bottom: 1rem;
}

.horizontal-child {
  border: 1px dashed var(--border-color);
  padding: 0.5rem;
  border-radius: 0.25rem;
}

.add-child-buttons {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.add-child-buttons button {
  padding: 0.375rem 0.75rem;
  background: var(--bg-light);
  color: var(--text-dark);
  border: 1px solid var(--border-color);
  font-size: 0.75rem;
}
</style>
