<template>
  <v-app>
    <!-- Header -->
    <v-app-bar app color="white" elevation="1" height="80">
      <v-container fluid class="d-flex align-center">
        <!-- Back arrow -->
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
        <!-- Breadcrumb -->
        <div class="d-flex align-center mb-6">
          <span class="text-body-2 text-grey">BuildNext</span>
          <v-icon size="small" class="mx-2 text-grey">mdi-chevron-right</v-icon>
          <span class="text-body-2 text-grey">{{ breadcrumbCategory }}</span>
          <v-icon size="small" class="mx-2 text-grey">mdi-chevron-right</v-icon>
          <span class="text-body-2 font-weight-medium">{{ companyData.name }}</span>
        </div>

        <v-row>
          <!-- Left Column - Company Info -->
          <v-col cols="12" md="5">
            <!-- Company Avatar and Basic Info -->
            <div class="d-flex mb-6">
              <v-avatar size="120" class="mr-6">
                <v-img :src="companyData.avatar" alt="Company Logo"></v-img>
              </v-avatar>
              <div class="flex-grow-1">
                <h1 class="text-h4 font-weight-bold mb-2">{{ companyData.name }}</h1>
                <p class="text-h6 text-grey-darken-1 mb-4">{{ companyData.subtitle }}</p>
                
                <!-- Action Buttons -->
                <div class="d-flex flex-column gap-3">
                  <v-btn color="primary" block class="text-none" size="large">
                    立即联系
                  </v-btn>
                  <div class="d-flex gap-2">
                    <v-btn variant="outlined" color="grey" class="text-none flex-grow-1">
                      收藏
                    </v-btn>
                    <v-btn variant="outlined" color="grey" class="text-none flex-grow-1">
                      分享
                    </v-btn>
                  </div>
                </div>
              </div>
            </div>

            <!-- Company Description -->
            <v-card class="pa-4 mb-6" elevation="1">
              <p class="text-body-1 mb-0">{{ companyData.description }}</p>
            </v-card>

            <!-- Company Details -->
            <v-card class="pa-4" elevation="1">
              <div class="company-detail-item mb-3">
                <v-icon class="mr-3" size="20">mdi-account-group</v-icon>
                <span class="text-body-2"><strong>公司规模:</strong> {{ companyData.companySize }}</span>
              </div>
              
              <div class="company-detail-item mb-3">
                <v-icon class="mr-3" size="20">mdi-pencil-ruler</v-icon>
                <span class="text-body-2"><strong>设计服务类型:</strong> 
                  <span class="text-primary">{{ companyData.serviceTypes?.join(', ') || '暂无信息' }}</span>
                </span>
              </div>
              
              <div class="company-detail-item mb-3">
                <v-icon class="mr-3" size="20">mdi-folder-multiple</v-icon>
                <span class="text-body-2"><strong>项目类型:</strong> {{ companyData.projectTypes?.join(', ') || '暂无信息' }}</span>
              </div>
              
              <div class="company-detail-item mb-3">
                <v-icon class="mr-3" size="20">mdi-map-marker</v-icon>
                <span class="text-body-2"><strong>服务地点:</strong> {{ companyData.serviceLocations?.join(', ') || '暂无信息' }}</span>
              </div>
              
              <div class="company-detail-item">
                <v-icon class="mr-3" size="20">mdi-translate</v-icon>
                <span class="text-body-2"><strong>服务语言:</strong> {{ companyData.languages?.join(', ') || '暂无信息' }}</span>
              </div>
            </v-card>
          </v-col>

          <!-- Right Column - Project Image -->
          <v-col cols="12" md="7">
            <v-card elevation="2" class="project-showcase">
              <v-img 
                :src="companyData.showcaseImage" 
                height="500"
                cover
                class="project-main-image"
              >
                <div class="image-overlay">
                  <div class="overlay-content">
                    <h3 class="text-h5 text-white font-weight-bold mb-2">{{ companyData.showcaseTitle }}</h3>
                    <p class="text-body-1 text-white opacity-90">{{ companyData.showcaseDescription }}</p>
                  </div>
                </div>
              </v-img>
            </v-card>
          </v-col>
        </v-row>

        <!-- Tabs Section -->
        <v-row class="mt-4 mb-4">
          <v-col cols="12">
            <v-tabs v-model="activeTab" class="company-tabs">
              <v-tab value="projects">项目案例</v-tab>
              <v-tab value="team">团队简介</v-tab>
            </v-tabs>

            <v-tabs-window v-model="activeTab" class="mt-2 mb-2">
              <!-- Projects Tab -->
              <v-tabs-window-item value="projects" class="py-2">
                <v-row class="py-2">
                  <v-col 
                    v-for="(project, index) in companyData.projects" 
                    :key="index"
                    cols="12" 
                    md="4"
                    class="py-3"
                  >
                    <v-card elevation="2" class="project-card">
                      <v-img 
                        :src="project.image" 
                        height="200"
                        cover
                      ></v-img>
                      <v-card-text>
                        <h4 class="text-h6 font-weight-bold mb-2">{{ project.title }}</h4>
                        <p class="text-body-2 text-grey-darken-1">{{ project.description }}</p>
                      </v-card-text>
                    </v-card>
                  </v-col>
                </v-row>
              </v-tabs-window-item>

              <!-- Team Tab -->
              <v-tabs-window-item value="team" class="py-2">
                <v-row class="py-2">
                  <v-col cols="12" md="8" class="py-3">
                    <v-card class="pa-6" elevation="1">
                      <h3 class="text-h5 font-weight-bold mb-4">团队介绍</h3>
                      <p class="text-body-1 mb-4">{{ companyData.teamDescription }}</p>
                      
                      <div class="d-flex flex-wrap gap-2">
                        <v-chip 
                          v-for="(expertise, index) in companyData.teamExpertise" 
                          :key="index"
                          variant="outlined"
                          color="primary"
                        >
                          {{ expertise }}
                        </v-chip>
                      </div>
                    </v-card>
                  </v-col>
                  <v-col cols="12" md="4" class="py-2">
                    <v-card class="pa-4" elevation="1">
                      <h4 class="text-h6 font-weight-bold mb-3">联系信息</h4>
                      <div class="contact-info">
                        <div class="mb-2">
                          <v-icon size="small" class="mr-2">mdi-email</v-icon>
                          <span class="text-body-2">{{ companyData.email }}</span>
                        </div>
                        <div class="mb-2">
                          <v-icon size="small" class="mr-2">mdi-phone</v-icon>
                          <span class="text-body-2">{{ companyData.phone }}</span>
                        </div>
                        <div>
                          <v-icon size="small" class="mr-2">mdi-web</v-icon>
                          <span class="text-body-2">{{ companyData.website }}</span>
                        </div>
                      </div>
                    </v-card>
                  </v-col>
                </v-row>
              </v-tabs-window-item>
            </v-tabs-window>
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
import { getAssetPath } from '@/utils/assets.js';

const router = useRouter();
const route = useRoute();

const searchQuery = ref('');
const activeTab = ref('projects');
const breadcrumbCategory = ref('');
const companyData = ref({});

// Company data based on the company name
const companiesData = {
  'ABC 建筑研究院': {
    name: 'ABC 建筑研究院',
    subtitle: '总包建筑设计公司 | 中国广州 | 1-500人',
    avatar: getAssetPath(getAssetPath("/logo.png")),
    description: '该公司总部位于中国广州，已有36余年经验，专业承接高端办公建筑设计，深化制造工厂，已在全国乃至全球拥有者达3500余个项目。该公司总部位于中国广州，已有36余年经验，专业承接高端办公建筑设计，深化制造工厂，已在全国乃至全球拥有者达3500余个项目。',
    companySize: '1-500人',
    serviceTypes: ['总包设计', '建筑设计', '规划设计'],
    projectTypes: ['商业建筑', '办公建筑', '住宅建筑', '工业建筑'],
    serviceLocations: ['广州', '深圳', '上海', '北京'],
    languages: ['中文', '英语', '意大利语'],
    showcaseImage: getAssetPath(getAssetPath("/gallary1.jpg")),
    showcaseTitle: '现代城市综合体项目',
    showcaseDescription: '大型城市开发项目，包含商业、办公、住宅等多功能综合体设计',
    projects: [
      {
        title: '商业综合体A',
        description: '现代化商业建筑设计',
        image: getAssetPath(getAssetPath("/gallary1.jpg"))
      },
      {
        title: '办公大楼B',
        description: '高端办公空间设计',
        image: getAssetPath(getAssetPath("/gallary2.jpg"))
      },
      {
        title: '住宅项目C',
        description: '绿色生态住宅设计',
        image: getAssetPath(getAssetPath("/gallary3.jpg"))
      }
    ],
    teamDescription: '我们拥有一支经验丰富的专业设计团队，团队成员来自国内外知名设计院校，具备丰富的项目经验和创新能力。团队专注于现代建筑设计，致力于为客户提供高品质的设计服务。',
    teamExpertise: ['建筑设计', '规划设计', '景观设计', '室内设计', '可持续设计', 'BIM技术'],
    email: 'contact@abc-arch.com',
    phone: '+86 020 1234 5678',
    website: 'www.abc-architecture.com'
  }
};

const loadContent = () => {
  const category = route.query.category;
  const tag = route.query.tag;
  const company = route.query.company;
  
  console.log('Loading company content for:', { category, tag, company });
  
  breadcrumbCategory.value = category || '';
  
  if (company && companiesData[company]) {
    companyData.value = companiesData[company];
  } else {
    // Default company data
    companyData.value = {
      name: company || '公司名称',
      subtitle: '建筑设计公司',
      avatar: getAssetPath(getAssetPath("/logo.png")),
      description: '这里是公司详细介绍。',
      companySize: '未知',
      serviceTypes: ['暂无信息'],
      projectTypes: ['暂无信息'],
      serviceLocations: ['暂无信息'],
      languages: ['暂无信息'],
      showcaseImage: getAssetPath(getAssetPath("/gallary1.jpg")),
      showcaseTitle: '项目展示',
      showcaseDescription: '项目描述',
      projects: [],
      teamDescription: '团队介绍',
      teamExpertise: ['暂无信息'],
      email: 'contact@company.com',
      phone: '+86 xxx xxxx xxxx',
      website: 'www.company.com'
    };
  }
};

const goBack = () => {
  const category = route.query.category;
  const tag = route.query.tag;
  
  if (category && tag) {
    router.push({
      path: '/tag',
      query: { 
        category: category,
        tag: tag 
      }
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

onMounted(() => {
  loadContent();
});

watch(() => [route.query.category, route.query.tag, route.query.company], () => {
  loadContent();
});
</script>

<style scoped>
.search-field {
  border-radius: 8px;
}

.project-showcase {
  border-radius: 12px;
  overflow: hidden;
}

.project-main-image {
  position: relative;
}

.image-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(transparent, rgba(0, 0, 0, 0.8));
  padding: 30px;
}

.overlay-content {
  color: white;
}

.company-detail-item {
  display: flex;
  align-items: center;
}

.company-tabs {
  border-bottom: 1px solid rgba(0, 0, 0, 0.12);
}

.project-card {
  border-radius: 12px;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.project-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}

.contact-info {
  line-height: 1.8;
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

.gap-2 {
  gap: 8px;
}

.gap-3 {
  gap: 12px;
}
</style>

