<template>
  <div class="admin-page">
    <h1>{{ isEditMode ? 'Edit Blog' : 'Blog Admin' }}</h1>
    <p class="subtitle">{{ isEditMode ? 'Update your blog post' : 'Create and manage blog posts' }}</p>
    
    <div v-if="loading" class="loading">Loading blog...</div>
    
    <div v-else class="admin-container">
      <BlogEditor @save="handleSave" :saving="saving" :initialData="blogData" />
    </div>
    
    <div v-if="saveMessage" class="message" :class="{ error: saveError }">
      {{ saveMessage }}
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { supabase } from '../lib/supabase'
import BlogEditor from '../components/BlogEditor.vue'

const router = useRouter()
const route = useRoute()
const saving = ref(false)
const loading = ref(false)
const saveMessage = ref('')
const saveError = ref(false)
const blogData = ref(null)

const isEditMode = computed(() => !!route.params.id)

const fetchBlog = async () => {
  try {
    loading.value = true
    const { data, error } = await supabase
      .from('blogs')
      .select('*')
      .eq('id', route.params.id)
      .single()
    
    if (error) throw error
    blogData.value = data
  } catch (err) {
    saveError.value = true
    saveMessage.value = `Error loading blog: ${err.message}`
    console.error('Error fetching blog:', err)
  } finally {
    loading.value = false
  }
}

const handleSave = async (blogData) => {
  try {
    saving.value = true
    saveMessage.value = ''
    saveError.value = false
    
    let data, error
    
    if (isEditMode.value) {
      // Update existing blog
      const result = await supabase
        .from('blogs')
        .update(blogData)
        .eq('id', route.params.id)
        .select()
      
      data = result.data
      error = result.error
      saveMessage.value = 'Blog updated successfully!'
    } else {
      // Create new blog
      const result = await supabase
        .from('blogs')
        .insert([blogData])
        .select()
      
      data = result.data
      error = result.error
      saveMessage.value = 'Blog saved successfully!'
    }
    
    if (error) throw error
    
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

onMounted(() => {
  if (isEditMode.value) {
    fetchBlog()
  }
})
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

.loading {
  text-align: center;
  padding: 3rem;
  font-size: 1.125rem;
  color: var(--text-light);
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

/* Mobile Responsive Styles */
@media (max-width: 768px) {
  h1 {
    font-size: 2rem;
  }

  .subtitle {
    font-size: 1rem;
  }

  .admin-container {
    padding: 1.5rem;
  }
}

@media (max-width: 480px) {
  h1 {
    font-size: 1.75rem;
  }

  .subtitle {
    font-size: 0.9375rem;
  }

  .admin-container {
    padding: 1rem;
  }

  .message {
    font-size: 0.875rem;
    padding: 0.75rem;
  }
}
</style>
