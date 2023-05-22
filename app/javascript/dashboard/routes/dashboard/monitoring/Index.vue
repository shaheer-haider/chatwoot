<template>
  <div class="row app-wrapper">
    <sidebar
      :route="currentRoute"
      @toggle-account-modal="toggleAccountModal"
      @open-notification-panel="openNotificationPanel"
      @open-key-shortcut-modal="toggleKeyShortcutModal"
      @close-key-shortcut-modal="closeKeyShortcutModal"
    />
    <h1>Monitoring</h1>
  </div>
</template>
<script>
import Sidebar from 'dashboard/components/layout/Sidebar';

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
  },
};
</script>
