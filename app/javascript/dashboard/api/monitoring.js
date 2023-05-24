/* global axios */
import CacheEnabledApiClient from './CacheEnabledApiClient';

class MonitoringApiClient extends CacheEnabledApiClient {
  constructor() {
    super('monitoring', { accountScoped: true });
  }

  // eslint-disable-next-line class-methods-use-this
  get cacheModelName() {
    return 'monitoring';
  }

  getAllSites() {
    return axios.get(`${this.url}`);
  }

  getActiveUsers(inboxId) {
    return axios.get(`${this.url}/${inboxId}`);
  }
}

export default new MonitoringApiClient();
