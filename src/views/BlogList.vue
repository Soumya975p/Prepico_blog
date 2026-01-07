<template>
  <div class="blog-list">
    <h1>Latest Posts</h1>
    <p class="subtitle">Tips, guides, and insights to help you ace your career journey</p>
    
    <div class="search-container">
      <input 
        v-model="searchQuery" 
        type="text" 
        placeholder="Search blogs by title..." 
        class="search-input"
      />
    </div>
    
    <div v-if="loading" class="loading">Loading blogs...</div>
    
    <div v-else-if="error" class="error">{{ error }}</div>
    
    <div v-else-if="blogs.length === 0" class="empty">
      No blogs yet. <router-link to="/admin">Create your first blog</router-link>
    </div>
    
    <div v-else-if="filteredBlogs.length === 0" class="empty">
      No blogs found matching "{{ searchQuery }}". <a @click="searchQuery = ''" style="cursor: pointer; text-decoration: underline;">Clear search</a>
    </div>
    
    <div v-else class="blogs-grid">
      <div v-for="blog in filteredBlogs" :key="blog.id" class="blog-card">
        <div v-if="blog.thumbnail_url" class="blog-thumbnail" @click="goToBlog(blog.id)">
          <img :src="blog.thumbnail_url" :alt="blog.title" />
        </div>
        <div class="blog-content">
          <div @click="goToBlog(blog.id)" style="cursor: pointer;">
            <h2>{{ blog.title }}</h2>
            <p class="blog-date">{{ formatDate(blog.created_at) }}</p>
          </div>
          <div class="blog-actions">
            <button @click.stop="editBlog(blog.id)" class="edit-btn">Edit</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { supabase } from '../lib/supabase'

const router = useRouter()
const blogs = ref([])
const loading = ref(true)
const error = ref(null)
const searchQuery = ref('')

const filteredBlogs = computed(() => {
  if (!searchQuery.value) {
    return blogs.value
  }
  const query = searchQuery.value.toLowerCase()
  return blogs.value.filter(blog => 
    blog.title.toLowerCase().includes(query)
  )
})

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

const editBlog = (id) => {
  router.push(`/admin/edit/${id}`)
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
  color: #012987;
}

.subtitle {
  font-size: 1.125rem;
  color: var(--text-light);
  margin-bottom: 2rem;
}

.search-container {
  margin-bottom: 3rem;
  max-width: 600px;
}

.search-input {
  width: 100%;
  padding: 0.875rem 1rem;
  font-size: 1rem;
  border: 2px solid var(--border-color);
  border-radius: 0.5rem;
  transition: border-color 0.2s, box-shadow 0.2s;
}

.search-input:focus {
  border-color: var(--primary-color);
  box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
  outline: none;
}

.loading, .error, .empty {
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
  transition: transform 0.2s, box-shadow 0.2s;
  display: flex;
  flex-direction: column;
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
  cursor: pointer;
}

.blog-thumbnail img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center;
}

.blog-content {
  padding: 1.5rem;
  display: flex;
  flex-direction: column;
  flex: 1;
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

.blog-actions {
  margin-top: auto;
  padding-top: 1rem;
  border-top: none;
  display: flex;
  justify-content: flex-start;
  align-items: center;
}

.edit-btn {
  padding: 0.5rem 1.25rem;
  background: #012987;
  color: var(--white);
  border: none;
  border-radius: 0.375rem;
  font-size: 0.875rem;
  font-weight: 500;
  font-family: 'Poppins', sans-serif;
  cursor: pointer;
  transition: all 0.2s;
  text-align: center;
}

.edit-btn:hover {
  background: #001a5c;
}

/* Mobile Responsive Styles */
@media (max-width: 768px) {
  h1 {
    font-size: 2rem;
  }

  .subtitle {
    font-size: 1rem;
  }

  .search-container {
    margin-bottom: 2rem;
  }

  .blogs-grid {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }

  .blog-card {
    max-width: 500px;
    margin: 0 auto;
  }

  .blog-content {
    padding: 1rem;
  }

  .blog-content h2 {
    font-size: 1.25rem;
  }
}

@media (max-width: 480px) {
  h1 {
    font-size: 1.75rem;
  }

  .subtitle {
    font-size: 0.9375rem;
  }

  .search-input {
    font-size: 0.9375rem;
    padding: 0.75rem;
  }

  .blog-thumbnail {
    height: 160px;
  }

  .blog-content {
    padding: 0.875rem;
  }

  .blog-content h2 {
    font-size: 1.125rem;
  }
}
</style>
