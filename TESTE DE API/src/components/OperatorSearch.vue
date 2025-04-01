<script setup lang="ts">
import { ref } from 'vue'
import axios from 'axios'

const searchQuery = ref('')
const searchResults = ref([])
const loading = ref(false)
const error = ref('')

const searchOperators = async () => {
  if (!searchQuery.value.trim()) return
  
  loading.value = true
  error.value = ''
  
  try {
    const response = await axios.get(`http://localhost:8000/search?q=${encodeURIComponent(searchQuery.value)}`)
    searchResults.value = response.data.results
  } catch (e) {
    error.value = 'Erro ao pesquisar operadores. Tente novamente.'
    console.error(e)
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="search-container">
    
    <div class="search-box">
      <input 
        v-model="searchQuery"
        @keyup.enter="searchOperators"
        placeholder="Search operators..."
        type="text"
      />
      <button @click="searchOperators" :disabled="loading">
        {{ loading ? 'Searching...' : 'Search' }}
      </button>
    </div>

    <div v-if="error" class="error">
      {{ error }}
    </div>

    <div v-if="searchResults.length > 0" class="results">
      <div v-for="(result, index) in searchResults" :key="index" class="result-item">
        <pre>{{ JSON.stringify(result, null, 2) }}</pre>
      </div>
    </div>
    
    <div v-else-if="!loading && searchQuery" class="no-results">
      Nenhum resultado encontrado
    </div>
  </div>
</template>

<style scoped>
.search-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.search-box {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
}

input {
  flex: 1;
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

button {
  padding: 8px 16px;
  background-color: #4CAF50;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

button:disabled {
  background-color: #cccccc;
  cursor: not-allowed;
}

.error {
  color: red;
  margin-bottom: 10px;
}

.results {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.result-item {
  background-color: #f5f5f5;
  padding: 10px;
  border-radius: 4px;
  overflow-x: auto;
}

.no-results {
  text-align: center;
  color: #666;
}
</style>