<template>
  <div class="flex h-screen">
    <sidebar
      :route="currentRoute"
      @toggle-account-modal="toggleAccountModal"
      @open-notification-panel="openNotificationPanel"
      @open-key-shortcut-modal="toggleKeyShortcutModal"
      @close-key-shortcut-modal="closeKeyShortcutModal"
    />
    <section class="p-4 w-full">
      <div class="border-light p-4">
        <div>
          <h1>Monitoring</h1>
          <div class="bg-light">
            <div
              v-for="(inbox, index) in inboxes"
              :key="index"
              class="border-b-light-3 p-4 mb-28px"
            >
              <label
                for="accordion-item-1"
                class="accordion-item-label text-xl"
              >
                {{ inbox.name }}
              </label>

              <div class="block max-h-600px overflow-y-scroll border-light">
                <table class="border-b-light-3 p-2">
                  <thead>
                    <tr>
                      <td
                        class="border-b-light-2 py-1 px-2 border-b-none font-medium"
                      >
                        IP
                      </td>
                      <td
                        class="border-b-light-2 py-1 px-2 border-b-none font-medium"
                      >
                        Previous Page
                      </td>
                      <td
                        class="border-b-light-2 py-1 px-2 border-b-none font-medium"
                      >
                        Current Page
                      </td>
                      <td
                        class="border-b-light-2 py-1 px-2 border-b-none font-medium"
                      >
                        Country
                      </td>
                      <td
                        class="border-b-light-2 py-1 px-2 border-b-none font-medium"
                      >
                        Time
                      </td>
                    </tr>
                  </thead>
                  <tbody>
                    <tr
                      v-for="(active_user,
                      active_user_index) in inbox.users_activity"
                      :key="active_user_index"
                    >
                      <td class="border-b-light-2 py-1 px-2 border-b-none">
                        {{ active_user.ip_address }}
                      </td>
                      <td class="border-b-light-2 py-1 px-2 border-b-none">
                        {{ active_user.page_url }}
                      </td>
                      <td class="border-b-light-2 py-1 px-2 border-b-none">
                        {{ active_user.page_url }}
                      </td>
                      <td class="border-b-light-2 py-1 px-2 border-b-none">
                        {{ active_user.country }}
                      </td>
                      <td class="border-b-light-2 py-1 px-2 border-b-none">
                        {{ active_user.created_at }}
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>
<script>
import './assets/monitoring.style.css';
import Sidebar from 'dashboard/components/layout/Sidebar';
import MonitoringApiClient from '../../../api/monitoring';

export default {
  components: {
    Sidebar,
  },
  data() {
    return {
      isOnDesktop: true,
      showShortcutModal: false,
      showNotificationPanel: false,
      showAddCategoryModal: false,
      lastActivePortalSlug: '',
      showAccountModal: false,
      inboxes: [],
    };
  },
  computed: {
    isSidebarOpen() {
      const {
        show_help_center_secondary_sidebar: showSecondarySidebar,
      } = this.uiSettings;
      return showSecondarySidebar;
    },
    showHelpCenterSidebar() {
      return this.portals.length === 0 ? false : this.isSidebarOpen;
    },
    selectedPortal() {
      const slug = this.$route.params.portalSlug || this.lastActivePortalSlug;
      if (slug) return this.$store.getters['portals/portalBySlug'](slug);

      return this.$store.getters['portals/allPortals'][0];
    },
    selectedLocaleInPortal() {
      return this.$route.params.locale || this.defaultPortalLocale;
    },
    selectedPortalName() {
      return this.selectedPortal ? this.selectedPortal.name : '';
    },
    selectedPortalSlug() {
      return this.selectedPortal ? this.selectedPortal?.slug : '';
    },
    defaultPortalLocale() {
      return this.selectedPortal
        ? this.selectedPortal?.meta?.default_locale
        : '';
    },
    currentRoute() {
      return '  ';
    },
    headerTitle() {
      return this.selectedPortal ? this.selectedPortal.name : '';
    },
  },

  mounted() {
    this.fetchWebInboxes();
  },

  methods: {
    toggleKeyShortcutModal() {
      this.showShortcutModal = true;
    },
    closeKeyShortcutModal() {
      this.showShortcutModal = false;
    },
    openNotificationPanel() {
      this.showNotificationPanel = true;
    },
    toggleAccountModal() {
      this.showAccountModal = !this.showAccountModal;
    },
    fetchWebInboxes() {
      MonitoringApiClient.getAllSites().then(inbox_res => {
        let inboxes = inbox_res.data;
        inboxes.forEach(inbox => {
          MonitoringApiClient.getActiveUsers(inbox.id).then(res => {
            inbox.users_activity = res.data;
            this.inboxes.push(inbox);
          });
        });
      });
    },
  },
};
</script>
