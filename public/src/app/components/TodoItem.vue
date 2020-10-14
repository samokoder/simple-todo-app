<template>
  <div>
    <div class="control">
      <b-field grouped>
        <p
          class="control is-expanded my-2"
          v-bind:class="{ 'todo-done': todo.done }"
          v-on:dblclick="editItem"
        >
          {{ todo.title }}
        </p>

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
import Confirm from './Confirm.vue';

export default {
  name: 'TodoItem',

  props: {
    todo: {
      type: Object,
      required: true
    }
  },

  methods: {
    editItem() {
      // prevent editing finished item
      if (this.todo.done) return;

      console.log('edit');
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
</style>
