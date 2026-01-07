<template>
  <div class="blog-view">
    <div v-if="loading" class="loading">Loading blog...</div>
    
    <div v-else-if="error" class="error">{{ error }}</div>
    
    <article v-else-if="blog" class="blog-article">
      <header class="blog-header">
        <h1>{{ blog.title }}</h1>
        <p class="blog-date">{{ formatDate(blog.created_at) }}</p>
      </header>
      
      <div v-if="blog.thumbnail_url" class="blog-hero">
        <img :src="blog.thumbnail_url" :alt="blog.title" />
      </div>
      
      <div class="blog-content">
        <BlogContentRenderer :content="blog.content" />
      </div>
    </article>
    
    <div class="action-links">
      <router-link to="/" class="back-link">← Back to all blogs</router-link>
      <button @click="editBlog" class="edit-btn">Edit Blog</button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { supabase } from '../lib/supabase'
import BlogContentRenderer from '../components/BlogContentRenderer.vue'

const route = useRoute()
const router = useRouter()
const blog = ref(null)
const loading = ref(true)
const error = ref(null)

const fetchBlog = async () => {
  try {
    loading.value = true
    const { data, error: fetchError } = await supabase
      .from('blogs')
      .select('*')
      .eq('id', route.params.id)
      .single()
    
    if (fetchError) throw fetchError
    blog.value = data
  } catch (err) {
    error.value = err.message
    console.error('Error fetching blog:', err)
  } finally {
    loading.value = false
  }
}

const editBlog = () => {
  router.push(`/admin/edit/${route.params.id}`)
}

const formatDate = (date) => {
  return new Date(date).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

onMounted(() => {
  fetchBlog()
})
</script>

<style scoped>
.blog-view {
  max-width: 800px;
  margin: 0 auto;
}

.loading, .error {
  text-align: center;
  padding: 3rem;
  font-size: 1.125rem;
}

.error {
  color: #DC2626;
}

.blog-article {
  background: var(--white);
  padding: 3rem;
  border-radius: 0.5rem;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  margin-bottom: 2rem;
}

.blog-header h1 {
  font-size: 2.5rem;
  color: var(--text-dark);
  margin-bottom: 1rem;
  line-height: 1.2;
}

.blog-date {
  color: var(--text-light);
  font-size: 1rem;
  margin-bottom: 2rem;
}

.blog-hero {
  width: 100%;
  height: 400px;
  overflow: hidden;
  border-radius: 0.5rem;
  margin-bottom: 2rem;
  background: var(--bg-light);
}

.blog-hero img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center;
}

.blog-content {
  font-size: 1.125rem;
  line-height: 1.8;
  color: var(--text-dark);
}

.action-links {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  gap: 1rem;
}

.back-link {
  color: var(--primary-color);
  text-decoration: none;
  font-weight: 500;
}

.back-link:hover {
  text-decoration: underline;
}

.edit-btn {
  padding: 0.75rem 1.5rem;
  background: var(--primary-color);
  color: var(--white);
  border: none;
  border-radius: 0.375rem;
  font-size: 1rem;
  font-weight: 500;
  cursor: pointer;
  transition: background 0.2s;
}

.edit-btn:hover {
  background: var(--secondary-color);
}

/* Mobile Responsive Styles */
@media (max-width: 768px) {
  .blog-article {
    padding: 2rem 1.5rem;
  }

  .blog-header h1 {
    font-size: 2rem;
  }

  .blog-content {
    font-size: 1rem;
  }

  .action-links {
    flex-direction: column;
    align-items: stretch;
  }

  .back-link {
    text-align: center;
    margin-bottom: 0.5rem;
  }

  .edit-btn {
    width: 100%;
  }
}

@media (max-width: 480px) {
  .blog-article {
    padding: 1.5rem 1rem;
  }

  .blog-header h1 {
    font-size: 1.75rem;
  }

  .blog-date {
    font-size: 0.875rem;
  }

  .blog-hero {
    max-height: 250px;
  }

  .blog-content {
    font-size: 0.9375rem;
    line-height: 1.7;
  }
}
</style>
