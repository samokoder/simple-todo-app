<template>
  <div>
    <div class="control" v-if="isEditMode">
      <b-field grouped>
        <p class="control is-expanded">
          <input type="text" class="input" v-model="title" />
        </p>

        <div class="control buttons mb-0">
          <b-button
            type="is-primary"
            v-on:click="updateTodo"
          >OK</b-button>
          <b-button v-on:click="isEditMode = false">Cancel</b-button>
        </div>
      </b-field>
    </div>

    <div class="control" v-else>
      <b-field grouped>
        <p
          class="control is-expanded my-2"
          v-bind:class="{ 'todo-done': todo.done }"
          v-on:dblclick="editItem"
        >
          {{ todo.title }}
        </p>

        <span class="todo-timestamp is-size-6 is-italic">
          {{ createdAt }}
        </span>

        <div class="control buttons mb-0">
          <b-checkbox
            class="mr-0"
            title="mark done"
            v-bind:value="todo.done"
            v-on:input="toggleDone"
          ></b-checkbox>
          <button
            class="delete"
            title="delete"
            v-on:click="deleteItem"
          ></button>
        </div>
      </b-field>
    </div>
  </div>
</template>

<script>
import dayjs from 'dayjs';
import Confirm from './Confirm.vue';

export default {
  name: 'TodoItem',

  props: {
    todo: {
      type: Object,
      required: true
    }
  },

  data() {
    return {
      title: '',
      isEditMode: false,
    };
  },

  computed: {
    createdAt() {
      return dayjs(this.todo.created_at).format('D MMM HH:mm');
    },
  },

  methods: {
    editItem() {
      // prevent editing finished item
      if (this.todo.done) return;

      this.isEditMode = true;
      this.title = this.todo.title;
    },

    updateTodo() {
      this.$emit('edit', { id: this.todo.id, title: this.title });
      this.isEditMode = false;
    },

    toggleDone(value) {
      this.$emit('edit', { id: this.todo.id, done: value });
    },

    confirmDeleteItem() {
      this.$emit('delete', { id: this.todo.id });
    },

    deleteItem() {
      this.$buefy.modal.open({
        parent: this,
        component: Confirm,
        hasModalCard: true,
        trapFocus: true,
        events: {
          confirm: this.confirmDeleteItem
        }
      });
    }
  }
};
</script>

<style>
.todo-done {
  text-decoration: line-through;
  font-style: italic;
}

.todo-timestamp {
  align-self: center;
  white-space: nowrap;
  margin: 0 5px;
}
</style>
