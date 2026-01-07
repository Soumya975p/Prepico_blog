<template>
  <div id="app">
    <nav class="navbar">
      <div class="container">
        <router-link to="/" class="logo">
          <h1>PREPICO BLOG</h1>
        </router-link>
        <div class="nav-links">
          <router-link to="/">All Blogs</router-link>
          <router-link to="/admin" class="admin-link">Admin</router-link>
        </div>
      </div>
    </nav>
    <main>
      <router-view />
    </main>
    <footer class="footer">
      <div class="container">
        <p>&copy; 2026 Prepico.AI - Career Platform</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
</script>

<style>
:root {
  --primary-color: #4F46E5;
  --secondary-color: #7C3AED;
  --text-dark: #1F2937;
  --text-light: #6B7280;
  --bg-light: #F9FAFB;
  --border-color: #E5E7EB;
  --white: #FFFFFF;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
  color: var(--text-dark);
  background-color: var(--bg-light);
  line-height: 1.6;
}

#app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.navbar {
  background: var(--white);
  border-bottom: 1px solid var(--border-color);
  padding: 1rem 0;
  position: sticky;
  top: 0;
  z-index: 100;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.navbar .container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
}

.logo {
  text-decoration: none;
  color: var(--primary-color);
  display: flex;
  align-items: center;
}

.logo h1 {
  font-size: 1.5rem;
  font-weight: 700;
  margin: 0;
  line-height: 1;
}

.nav-links {
  display: flex;
  align-items: center;
  gap: 2rem;
}

.nav-links a {
  text-decoration: none;
  color: var(--text-dark);
  font-weight: 500;
  transition: color 0.2s;
  display: flex;
  align-items: center;
}

.nav-links a:hover {
  color: var(--primary-color);
}

.nav-links a.router-link-active {
  color: var(--primary-color);
}

.admin-link {
  padding: 0.5rem 1rem;
  background: var(--primary-color);
  color: var(--white) !important;
  border-radius: 0.375rem;
}

.admin-link:hover {
  background: var(--secondary-color);
}

main {
  flex: 1;
  max-width: 1200px;
  width: 100%;
  margin: 0 auto;
  padding: 2rem;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
}

.footer {
  background: var(--white);
  border-top: 1px solid var(--border-color);
  padding: 2rem 0;
  margin-top: auto;
}

.footer p {
  text-align: center;
  color: var(--text-light);
}

button {
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

button:hover {
  background: var(--secondary-color);
}

button:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

input, textarea {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid var(--border-color);
  border-radius: 0.375rem;
  font-size: 1rem;
  font-family: inherit;
}

input:focus, textarea:focus {
  outline: none;
  border-color: var(--primary-color);
  box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
}
</style>
