<template>
  <v-app>
    <!-- Header -->
    <v-app-bar app color="white" elevation="1" height="80">
      <v-container fluid class="d-flex align-center">
        <!-- Back arrow with navigation -->
        <v-btn 
          icon
          @click="goBack" 
          class="mr-4"
        >
          <v-icon>mdi-arrow-left</v-icon>
        </v-btn>
        
        <v-text-field
          v-model="searchQuery"
          placeholder="Search in Professionals"
          prepend-inner-icon="mdi-magnify"
          variant="outlined"
          density="compact"
          hide-details
          class="search-field mr-6"
          style="max-width: 300px;"
        ></v-text-field>
        
        <v-spacer></v-spacer>
        
        <v-btn variant="text" class="mx-2" @click="navigateToCategory('设计公司及独立设计师')">设计公司及独立设计师</v-btn>
        <v-btn variant="text" class="mx-2" @click="navigateToCategory('材料设备供应商')">材料设备供应商</v-btn>
        <v-btn variant="text" class="mx-2" @click="navigateToCategory('施工单位供应商')">施工单位供应商</v-btn>
        <v-btn variant="text" class="mx-2" @click="navigateToCategory('专家人才库')">专家人才库</v-btn>
        <v-btn variant="text" class="mx-2" @click="navigateToCategory('需求大厅')">需求大厅</v-btn>
        
        <v-btn variant="text" prepend-icon="mdi-account" class="ml-4">
          登陆
        </v-btn>
      </v-container>
    </v-app-bar>

    <!-- Main Content -->
    <v-main>
      <v-container fluid class="pa-6">
        <!-- Breadcrumb and Title -->
        <div class="d-flex align-center mb-4">
          <h1 class="text-h4 font-weight-bold">{{ pageTitle }}</h1>
          <v-divider vertical class="mx-4" style="height: 24px;"></v-divider>
          <span class="text-body-1 text-grey">{{ totalResults }}个结果</span>
        </div>
        
        <!-- Filters Row -->
        <v-row class="mb-6">
          <v-col cols="auto">
            <v-menu>
              <template v-slot:activator="{ props }">
                <v-btn 
                  variant="outlined" 
                  v-bind="props"
                  prepend-icon="mdi-chevron-down"
                  class="filter-btn"
                >
                  设计服务类型
                </v-btn>
              </template>
              <v-list density="compact">
                <v-list-item 
                  v-for="(service, index) in serviceTypes" 
                  :key="index"
                  @click="selectServiceType(service)"
                >
                  <v-list-item-title>{{ service }}</v-list-item-title>
                </v-list-item>
              </v-list>
            </v-menu>
          </v-col>
          
          <v-col cols="auto">
            <v-menu>
              <template v-slot:activator="{ props }">
                <v-btn 
                  variant="outlined" 
                  v-bind="props"
                  prepend-icon="mdi-chevron-down"
                  class="filter-btn"
                >
                  项目类型
                </v-btn>
              </template>
              <v-list density="compact">
                <v-list-item 
                  v-for="(project, index) in projectTypes" 
                  :key="index"
                  @click="selectProjectType(project)"
                >
                  <v-list-item-title>{{ project }}</v-list-item-title>
                </v-list-item>
              </v-list>
            </v-menu>
          </v-col>
          
          <v-col cols="auto">
            <v-menu>
              <template v-slot:activator="{ props }">
                <v-btn 
                  variant="outlined" 
                  v-bind="props"
                  prepend-icon="mdi-chevron-down"
                  class="filter-btn"
                >
                  服务地点
                </v-btn>
              </template>
              <v-list density="compact">
                <v-list-item 
                  v-for="(location, index) in locations" 
                  :key="index"
                  @click="selectLocation(location)"
                >
                  <v-list-item-title>{{ location }}</v-list-item-title>
                </v-list-item>
              </v-list>
            </v-menu>
          </v-col>
          
          <v-col cols="auto">
            <v-menu>
              <template v-slot:activator="{ props }">
                <v-btn 
                  variant="outlined" 
                  v-bind="props"
                  prepend-icon="mdi-chevron-down"
                  class="filter-btn"
                >
                  服务选项
                </v-btn>
              </template>
              <v-list density="compact">
                <v-list-item 
                  v-for="(option, index) in serviceOptions" 
                  :key="index"
                  @click="selectServiceOption(option)"
                >
                  <v-list-item-title>{{ option }}</v-list-item-title>
                </v-list-item>
              </v-list>
            </v-menu>
          </v-col>
          
          <v-col cols="auto">
            <v-menu>
              <template v-slot:activator="{ props }">
                <v-btn 
                  variant="outlined" 
                  v-bind="props"
                  prepend-icon="mdi-chevron-down"
                  class="filter-btn"
                >
                  收费范围
                </v-btn>
              </template>
              <v-list density="compact">
                <v-list-item 
                  v-for="(range, index) in priceRanges" 
                  :key="index"
                  @click="selectPriceRange(range)"
                >
                  <v-list-item-title>{{ range }}</v-list-item-title>
                </v-list-item>
              </v-list>
            </v-menu>
          </v-col>
          
          <v-col cols="auto">
            <v-btn 
              color="primary" 
              variant="outlined"
              prepend-icon="mdi-plus"
              class="filter-btn"
            >
              More Filters
            </v-btn>
          </v-col>
        </v-row>

        <!-- Companies List -->
        <v-row>
          <v-col cols="12">
            <div v-for="(company, index) in companies" :key="index" class="mb-6">
              <v-card 
                elevation="1" 
                class="company-card pa-6" 
                @click="navigateToCompany(company)"
                style="cursor: pointer;"
              >
                <v-row>
                  <!-- Company Images -->
                  <v-col cols="12" md="5" class="pr-6">
                    <v-row no-gutters>
                      <v-col cols="8" class="pr-1">
                        <v-img 
                          :src="company.mainImage" 
                          height="180"
                          cover
                          class="rounded company-main-image"
                        ></v-img>
                      </v-col>
                      <v-col cols="4" class="pl-1">
                        <v-row no-gutters class="flex-column" style="height: 180px;">
                          <v-col class="mb-1" style="height: calc(50% - 2px);">
                            <v-img 
                              :src="company.subImages[0]" 
                              height="100%"
                              cover
                              class="rounded"
                            ></v-img>
                          </v-col>
                          <v-col style="height: calc(50% - 2px);">
                            <v-img 
                              :src="company.subImages[1]" 
                              height="100%"
                              cover
                              class="rounded"
                            ></v-img>
                          </v-col>
                        </v-row>
                      </v-col>
                    </v-row>
                  </v-col>
                  
                  <!-- Company Info -->
                  <v-col cols="12" md="7">
                    <div class="d-flex align-start">
                      <!-- Company Avatar -->
                      <v-avatar size="60" class="mr-4 mt-1">
                        <v-img :src="company.avatar" alt="Company Logo"></v-img>
                      </v-avatar>
                      
                      <!-- Company Details -->
                      <div class="flex-grow-1">
                        <div class="d-flex align-center mb-2">
                          <h2 class="text-h5 font-weight-bold mr-3">{{ company.name }}</h2>
                          <v-chip size="small" color="blue" variant="outlined">{{ company.type }}</v-chip>
                        </div>
                        
                        <div class="d-flex align-center mb-3">
                          <span class="text-body-2 text-grey mr-4">{{ company.location }}</span>
                          <span class="text-body-2 text-grey">{{ company.projectCount }} 项目</span>
                        </div>
                        
                        <!-- Service Tags -->
                        <div class="mb-3">
                          <v-row no-gutters class="align-center">
                            <v-col cols="auto" class="text-body-2 font-weight-medium mr-2">
                              设计服务类型:
                            </v-col>
                            <v-col>
                              <span class="text-body-2 text-primary">{{ company.serviceTypes.join(', ') }}</span>
                            </v-col>
                          </v-row>
                        </div>
                        
                        <div class="mb-3">
                          <v-row no-gutters class="align-center">
                            <v-col cols="auto" class="text-body-2 font-weight-medium mr-2">
                              项目类型:
                            </v-col>
                            <v-col>
                              <span class="text-body-2">{{ company.projectTypes.join(', ') }}</span>
                            </v-col>
                          </v-row>
                        </div>
                        
                        <div class="mb-4">
                          <v-row no-gutters class="align-center">
                            <v-col cols="auto" class="text-body-2 font-weight-medium mr-2">
                              服务语言:
                            </v-col>
                            <v-col>
                              <span class="text-body-2">{{ company.languages.join(', ') }}</span>
                            </v-col>
                          </v-row>
                        </div>
                      </div>
                    </div>
                  </v-col>
                </v-row>
              </v-card>
            </div>
          </v-col>
        </v-row>
      </v-container>
    </v-main>

    <!-- Footer -->
    <Footer />
  </v-app>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import Footer from '@/components/Footer.vue';

const router = useRouter();
const route = useRoute();

const pageTitle = ref('');
const searchQuery = ref('');
const totalResults = ref(0);

// Filter options
const serviceTypes = ref(['总体设计', '建筑设计', '规划设计', '景观设计']);
const projectTypes = ref(['住宅', '商业', '办公', '工业', '公共建筑']);
const locations = ref(['北京', '上海', '广州', '深圳', '杭州']);
const serviceOptions = ref(['现场服务', '远程服务', '咨询服务']);
const priceRanges = ref(['1-10万', '10-50万', '50-100万', '100万以上']);

const companies = ref([]);

// Tag content data
const tagData = {
  '总体设计': {
    title: '设计公司及独立设计师',
    companies: [
      {
        name: 'ABC 建筑研究院',
        subtitle: '总包建筑设计公司',
        type: '总包设计',
        location: '中国, 美洲, 非洲......112',
        projectCount: '235个',
        mainImage: '/gallary1.jpg',
        subImages: ['/gallary2.jpg', '/gallary3.jpg'],
        avatar: '/logo.png',
        serviceTypes: ['总包设计'],
        projectTypes: ['超高层办公楼', '博物馆', '体育馆'],
        languages: ['中文', '英语', '意大利语']
      },
      {
        name: 'ABC 建筑研究院',
        subtitle: '总包建筑设计公司',
        type: '总包设计',
        location: '中国, 美洲, 非洲......112',
        projectCount: '235个',
        mainImage: '/gallary2.jpg',
        subImages: ['/gallary3.jpg', '/gallary4.jpg'],
        avatar: '/logo.png',
        serviceTypes: ['总包设计'],
        projectTypes: ['超高层办公楼', '博物馆', '体育馆'],
        languages: ['中文', '英语', '意大利语']
      },
      {
        name: 'ABC 建筑研究院',
        subtitle: '总包建筑设计公司',
        type: '总包设计',
        location: '中国, 美洲, 非洲......112',
        projectCount: '235个',
        mainImage: '/gallary3.jpg',
        subImages: ['/gallary4.jpg', '/gallary5.jpg'],
        avatar: '/logo.png',
        serviceTypes: ['总包设计'],
        projectTypes: ['超高层办公楼', '博物馆', '体育馆'],
        languages: ['中文', '英语', '意大利语']
      }
    ]
  },
  '建筑方案设计': {
    title: '设计公司及独立设计师',
    companies: [
      {
        name: 'XYZ 建筑工作室',
        subtitle: '方案设计专家',
        type: '方案设计',
        location: '中国, 北京, 上海......85',
        projectCount: '156个',
        mainImage: '/gallary4.jpg',
        subImages: ['/gallary5.jpg', '/gallary1.jpg'],
        avatar: '/logo.png',
        serviceTypes: ['方案设计'],
        projectTypes: ['住宅小区', '商业综合体', '文化建筑'],
        languages: ['中文', '英语']
      }
    ]
  }
};

const loadContent = () => {
  const category = route.query.category;
  const tag = route.query.tag;
  
  console.log('Loading tag content for:', { category, tag });
  
  if (tag && tagData[tag]) {
    const data = tagData[tag];
    pageTitle.value = tag;
    companies.value = data.companies;
    totalResults.value = data.companies.length * 1000; // Mock large number
  } else {
    pageTitle.value = tag || '标签详情';
    companies.value = [];
    totalResults.value = 0;
  }
};

const goBack = () => {
  const category = route.query.category;
  if (category) {
    router.push({
      path: '/category',
      query: { type: category }
    });
  } else {
    router.push('/');
  }
};

const navigateToCategory = (categoryName) => {
  router.push({
    path: '/category',
    query: { type: categoryName }
  });
};

const navigateToCompany = (company) => {
  console.log('Navigating to company:', company.name);
  router.push({
    path: '/company',
    query: { 
      category: route.query.category,
      tag: route.query.tag,
      company: company.name
    }
  });
};

// Filter methods
const selectServiceType = (service) => {
  console.log('Selected service type:', service);
};

const selectProjectType = (project) => {
  console.log('Selected project type:', project);
};

const selectLocation = (location) => {
  console.log('Selected location:', location);
};

const selectServiceOption = (option) => {
  console.log('Selected service option:', option);
};

const selectPriceRange = (range) => {
  console.log('Selected price range:', range);
};

onMounted(() => {
  loadContent();
});

watch(() => [route.query.category, route.query.tag], () => {
  loadContent();
});
</script>

<style scoped>
.search-field {
  border-radius: 8px;
}

.filter-btn {
  text-transform: none;
  border-radius: 8px;
  margin-right: 12px;
  margin-bottom: 8px;
}

.company-card {
  border-radius: 12px;
  transition: box-shadow 0.3s ease;
}

.company-card:hover {
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.company-main-image {
  border-radius: 8px;
}

.rounded {
  border-radius: 6px;
}

.v-btn {
  text-transform: none;
  font-weight: 500;
}

.v-app-bar {
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
}

.text-primary {
  color: #1976d2 !important;
}
</style>
