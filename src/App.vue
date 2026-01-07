<template>
  <div id="app">
    <nav class="navbar">
      <div class="container">
        <router-link to="/" class="logo">
          <img src="/logo.jpg" alt="PREPICO" />
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
  --primary-color: #012987;
  --secondary-color: #7C3AED;
  --text-dark: #1F2937;
  --text-light: #6B7280;
  --bg-light: #F9FAFB;
  --border-color: #FDFDFF;
  --white: #FFFFFF;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Poppins', 'Segoe UI', system-ui, -apple-system, sans-serif;
  color: var(--text-dark);
  background-color: var(--bg-light);
  line-height: 1.5;
  font-weight: 400;
  font-size: 16px;
}

#app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.navbar {
  background: var(--white);
  border-bottom: 1px solid #E5E7EB;
  padding: 0.75rem 0;
  position: sticky;
  top: 0;
  z-index: 100;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

.navbar .container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  max-width: 1750px;
  margin: 0 auto;
  padding: 0.5rem 3rem;
}

.logo {
  text-decoration: none;
  color: var(--primary-color);
  display: flex;
  align-items: center;
}

.logo img {
  height: 45px;
  width: auto;
  display: block;
}

.nav-links {
  display: flex;
  align-items: center;
  gap: 2.5rem;
}

.nav-links a {
  text-decoration: none;
  color: #012987;
  font-weight: 500;
  font-size: 1rem;
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
  padding: 0.625rem 1.5rem;
  background: #012987;
  color: var(--white) !important;
  border-radius: 2rem;
  font-weight: 600;
}

.admin-link:hover {
  background: #001a5c;
  transform: translateY(-1px);
  box-shadow: 0 2px 8px rgba(1, 41, 135, 0.3);
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

/* Mobile Responsive Styles */
@media (max-width: 768px) {
  .navbar .container {
    padding: 0 1rem;
  }

  .logo img {
    height: 28px;
  }

  .nav-links {
    gap: 1rem;
  }

  .nav-links a {
    font-size: 0.875rem;
  }

  .admin-link {
    padding: 0.375rem 0.75rem;
    font-size: 0.875rem;
  }

  main {
    padding: 1rem;
  }

  .container {
    padding: 0 1rem;
  }

  .footer {
    padding: 1.5rem 0;
  }

  .footer p {
    font-size: 0.875rem;
  }
}

@media (max-width: 480px) {
  .navbar .container {
    flex-wrap: wrap;
    gap: 0.5rem;
  }

  .logo img {
    height: 24px;
  }

  .nav-links {
    gap: 0.75rem;
  }

  main {
    padding: 0.75rem;
  }
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
