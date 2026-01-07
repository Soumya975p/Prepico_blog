<template>
  <div class="admin-page">
    <h1>Blog Admin</h1>
    <p class="subtitle">Create and manage blog posts</p>
    
    <div class="admin-container">
      <BlogEditor @save="handleSave" :saving="saving" />
    </div>
    
    <div v-if="saveMessage" class="message" :class="{ error: saveError }">
      {{ saveMessage }}
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { supabase } from '../lib/supabase'
import BlogEditor from '../components/BlogEditor.vue'

const router = useRouter()
const saving = ref(false)
const saveMessage = ref('')
const saveError = ref(false)

const handleSave = async (blogData) => {
  try {
    saving.value = true
    saveMessage.value = ''
    saveError.value = false
    
    const { data, error } = await supabase
      .from('blogs')
      .insert([blogData])
      .select()
    
    if (error) throw error
    
    saveMessage.value = 'Blog saved successfully!'
    setTimeout(() => {
      router.push(`/blog/${data[0].id}`)
    }, 1500)
  } catch (err) {
    saveError.value = true
    saveMessage.value = `Error: ${err.message}`
    console.error('Error saving blog:', err)
  } finally {
    saving.value = false
  }
}
</script>

<style scoped>
.admin-page {
  max-width: 1200px;
  margin: 0 auto;
}

h1 {
  font-size: 2.5rem;
  color: var(--text-dark);
  margin-bottom: 0.5rem;
}

.subtitle {
  font-size: 1.125rem;
  color: var(--text-light);
  margin-bottom: 2rem;
}

.admin-container {
  background: var(--white);
  padding: 2rem;
  border-radius: 0.5rem;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.message {
  margin-top: 2rem;
  padding: 1rem;
  border-radius: 0.375rem;
  text-align: center;
  background: #D1FAE5;
  color: #065F46;
}

.message.error {
  background: #FEE2E2;
  color: #991B1B;
}
</style>
