<template>
  <v-container fluid :style="{ height: '100vh' }">
    <v-row class="fill-height" style="margin: 16px 0;">
      <v-col cols="8" md="8" class="d-flex align-center fill-height">
        <v-col class="d-flex align-center fill-height">
          <v-carousel cycle class="fill-height" :interval="5000" :show-arrows="false" :style="{ height: '500px', borderRadius: '16px', overflow: 'hidden' }">
            <v-carousel-item v-for="(image, index) in images" :key="index">
              <v-img :src="image" alt="Main Image" cover :style="{ height: '100%', width: '100%' }"></v-img>
            </v-carousel-item>
          </v-carousel>
        </v-col>
      </v-col>
      <v-col cols="4" md="4" class="d-flex align-center fill-height">
        <v-row class="fill-height">
          <v-col cols="12" class="d-flex align-center" :style="{ height: `${100 / buttons.length}%` }" v-for="(button, index) in buttons" :key="index">
            <v-card 
              block 
              color="orange" 
              dark 
              :style="{ height: '100%', width: '100%', borderRadius: '24px', fontSize: `1.2rem`, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }"
              @click="navigateToDetail(button)"
              class="cursor-pointer"
            >
              <v-row>
                <v-col cols="10">
                  <span class="ml-4">{{ button }}</span>
                </v-col>
                <v-col cols="2">
                  <v-icon>mdi-chevron-right</v-icon>   
                </v-col>
              </v-row>
            </v-card>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
import { useRouter } from 'vue-router';

const router = useRouter();

const images = [
  '/gallary1.jpg',
  '/gallary2.jpg',
  '/gallary3.jpg',
  '/gallary4.jpg',
  '/gallary5.jpg',
];

const buttons = [
  '设计公司及独立设计师',
  '材料设备供应商',
  '施工单位供应商',
  '专家人才库',
  '需求大厅',
];

const navigateToDetail = (buttonText) => {
  console.log('Navigating to category page with:', buttonText);
  try {
    router.push({
      path: '/category',
      query: { type: buttonText }
    });
  } catch (error) {
    console.error('Navigation error:', error);
  }
};
</script>

<style scoped>
/* Add hover effect to orange cards */
.v-card {
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.v-card:hover {
  transform: scale(1.05);
  box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
  cursor: pointer;
}

.cursor-pointer {
  cursor: pointer;
}
</style>
