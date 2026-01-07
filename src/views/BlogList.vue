<template>
  <div class="blog-list">
    <h1>Latest Posts</h1>
    <p class="subtitle">Tips, guides, and insights to help you ace your career journey</p>
    
    <div v-if="loading" class="loading">Loading blogs...</div>
    
    <div v-else-if="error" class="error">{{ error }}</div>
    
    <div v-else-if="blogs.length === 0" class="empty">
      No blogs yet. <router-link to="/admin">Create your first blog</router-link>
    </div>
    
    <div v-else class="blogs-grid">
      <div v-for="blog in blogs" :key="blog.id" class="blog-card" @click="goToBlog(blog.id)">
        <div v-if="blog.thumbnail_url" class="blog-thumbnail">
          <img :src="blog.thumbnail_url" :alt="blog.title" />
        </div>
        <div class="blog-content">
          <h2>{{ blog.title }}</h2>
          <p class="blog-date">{{ formatDate(blog.created_at) }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { supabase } from '../lib/supabase'

const router = useRouter()
const blogs = ref([])
const loading = ref(true)
const error = ref(null)

const fetchBlogs = async () => {
  try {
    loading.value = true
    const { data, error: fetchError } = await supabase
      .from('blogs')
      .select('*')
      .order('created_at', { ascending: false })
    
    if (fetchError) throw fetchError
    blogs.value = data || []
  } catch (err) {
    error.value = err.message
    console.error('Error fetching blogs:', err)
  } finally {
    loading.value = false
  }
}

const goToBlog = (id) => {
  router.push(`/blog/${id}`)
}

const formatDate = (date) => {
  return new Date(date).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

onMounted(() => {
  fetchBlogs()
})
</script>

<style scoped>
.blog-list {
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
  margin-bottom: 3rem;
}

.loading, .error, .empty {
  text-align: center;
  padding: 3rem;
  font-size: 1.125rem;
  color: var(--text-light);
}

.error {
  color: #DC2626;
}

.empty a {
  color: var(--primary-color);
  text-decoration: underline;
}

.blogs-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 2rem;
}

.blog-card {
  background: var(--white);
  border-radius: 0.5rem;
  overflow: hidden;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
}

.blog-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.blog-thumbnail {
  width: 100%;
  height: 200px;
  overflow: hidden;
  background: var(--bg-light);
}

.blog-thumbnail img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.blog-content {
  padding: 1.5rem;
}

.blog-content h2 {
  font-size: 1.5rem;
  color: var(--text-dark);
  margin-bottom: 0.5rem;
}

.blog-date {
  color: var(--text-light);
  font-size: 0.875rem;
}
</style>
