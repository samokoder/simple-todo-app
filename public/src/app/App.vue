<template>
  <section class="section">
    <div class="container">
      <div class="column is-half is-offset-one-quarter">
        <nav class="panel">
          <p class="panel-heading">My TODO List</p>

          <new-todo
            class="panel-block"
            v-on:create="createTodo"
            v-bind:disabled="isCreatePending"
          ></new-todo>

          <div
            class="panel-tabs"
            v-if="!isEmptyTodoList"
          >
            <a
              href="#"
              v-bind:class="{ 'is-active': !hideDoneItems }"
              v-on:click.prevent="hideDoneItems = false"
            >All</a>
            <a
              href="#"
              v-bind:class="{ 'is-active': hideDoneItems }"
              v-on:click.prevent="hideDoneItems = true"
            >Active</a>
          </div>

          <div
            class="panel-block"
            v-if="isEmptyTodoList && !isLoadPending"
          >
            <h3 class="is-size-4 has-text-centered control">
              Your TODO list is empty
            </h3>
          </div>

          <div class="panel-block" v-if="isLoadPending">
            <p class="control py-5">
              <b-loading v-bind:active="true" v-bind:is-full-page="false"></b-loading>
            </p>
          </div>

          <todo-item
            class="panel-block"
            v-for="todo in filteredTodoList"
            v-bind:key="todo.id"
            v-bind:todo="todo"
            v-on:edit="updateTodo"
            v-on:delete="deleteTodo"
          ></todo-item>

          <div class="panel-block">
            <section>
              <p>
                active: {{ activeItemsQty }}, total: {{ totalItemsQty }}
              </p>
              <p class="is-size-7 has-text-grey-dark">
                <em>Hint</em> double-click on active todo to edit
              </p>
            </section>

          </div>
        </nav>
      </div>
    </div>
  </section>
</template>

<script>
import { todo as todoApi } from './api';
import NewTodo from './components/NewTodo.vue';
import TodoItem from './components/TodoItem.vue';

export default {
  components: {
    NewTodo,
    TodoItem
  },

  data() {
    return {
      isCreatePending: false,
      isLoadPending: false,
      isEditPending: false,

      hideDoneItems: false,

      todoList: [],
    };
  },

  computed: {
    totalItemsQty() {
      return this.todoList.length;
    },

    activeItemsQty () {
      return this.todoList.filter(x => !x.done).length;
    },

    isEmptyTodoList() {
      return this.todoList.length <= 0;
    },

    filteredTodoList() {
      let list = this.todoList;

      if (this.hideDoneItems) {
        list = this.todoList.filter(x => !x.done);
      }

      return list
        .slice()
        .sort((a, b) => {
          if (a.done && !b.done) return 1;
          if (!a.done && b.done) return -1;

          if (a.created_at < b.created_at) return 1;
          if (a.created_at > b.created_at) return -1;

          return 0;
        });
    },
  },

  mounted() {
    this.fetchTodoList();
  },

  methods: {
    fetchTodoList() {
      this.isLoadPending = true;

      todoApi.get()
        .then((resp) => {
          this.todoList = resp.data;
        })
        .catch((err) => console.warn('Failed to fetch list', err))
        .then(() => {
          this.isLoadPending = false;
        });
    },

    createTodo(data) {
      this.isCreatePending = true;

      todoApi.create(data)
        .then((resp) => {
          this.todoList.push(resp.data);
        })
        .catch((err) => console.warn('Failed to create item', err))
        .then(() => {
          this.isCreatePending = false;
        });
    },

    updateTodo(todo) {
      this.isEditPending = true;

      const { id, ...data } = todo;

      todoApi.update(id, data)
        .then((resp) => {
          const idx = this.todoList.findIndex(x => x.id === id);
          if (idx < 0) return; // -1 means `not found`

          this.todoList.splice(idx, 1, resp.data);
        })
        .catch((err) => console.warn('Failed to item', err))
        .then(() => {
          this.isEditPending = false;
        });
    },

    deleteTodo(todo) {
      this.isEditPending = true;

      todoApi.delete(todo.id)
        .then(() => {
          this.todoList = this.todoList.filter(x => x.id !== todo.id);
        })
        .catch((err) => console.warn('Failed to delete todo', err))
        .then(() => {
          this.isEditPending = false;
        });
    }
  }
};
</script>
