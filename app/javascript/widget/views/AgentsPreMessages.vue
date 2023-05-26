<template>
  <unread-message-list :messages="messages" @close="closeFullView" />
</template>

<script>
import { mapGetters } from 'vuex';
import { IFrameHelper } from 'widget/helpers/utils';
import UnreadMessageList from '../components/UnreadMessageList.vue';

export default {
  name: 'Campaigns',
  components: {
    UnreadMessageList,
  },
  computed: {
    ...mapGetters({ campaign: 'campaign/getActiveCampaign' }),
    messages() {
      return [
        {
          content: 'Test Campaign',
          sender: null,
          campaignId: 1,
        },
      ];
    },
  },
  methods: {
    closeFullView() {
      if (IFrameHelper.isIFrame()) {
        IFrameHelper.sendMessage({
          event: 'setCampaignReadOn',
        });
        IFrameHelper.sendMessage({ event: 'toggleBubble' });
        bus.$emit('snooze-campaigns');
      }
    },
  },
};
</script>
