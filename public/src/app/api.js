// ./app/api.js

import axios from 'axios';

const client = axios.create({
  baseURL: '/api'
});

const resource = (path) => {
  const prepareUrl = (id) => {
    if (id) return `${path}/${id}`;

    return path;
  };

  return {
    get: (id) => client.get(prepareUrl(id)),
    create: (data) => client.post(prepareUrl(), data),
    update: (id, data) => client.put(prepareUrl(id), data),
    delete: (id) => client.delete(prepareUrl(id))
  };
};

export const todo = resource('todo');

export default {
  todo
};
