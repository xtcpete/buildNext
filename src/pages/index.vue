<template>
  <v-app>
    <Header />
    <MainContent :style="{ height: mainContentHeight, marginTop: headerHeight }" />
    <Footer />
  </v-app>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import Header from '../components/Header.vue';
import MainContent from '../components/MainContent.vue';
import Footer from '../components/Footer.vue';

const mainContentHeight = ref('80vh');
const headerHeight = ref('0px');

const calculateHeight = () => {
  const headerElementHeight = document.querySelector('header')?.offsetHeight || 0;
  const footerHeight = document.querySelector('footer')?.offsetHeight || 0;
  headerHeight.value = `${headerElementHeight}px`;
  mainContentHeight.value = `calc(100vh - ${headerElementHeight + footerHeight}px)`;
};

onMounted(() => {
  calculateHeight();
  window.addEventListener('resize', calculateHeight);
});

onUnmounted(() => {
  window.removeEventListener('resize', calculateHeight);
});
</script>

<style>
/* Add global styles here */
</style>
