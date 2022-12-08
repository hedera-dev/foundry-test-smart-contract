// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

struct Todo {
  uint id;
  string description;
  bool completed;
}

contract TodoList {
    // need to keep count of todos as we insert into map
    uint256 public numberOfTodos = 0;

  mapping(uint => Todo) public todos;

  function createTodo(string memory description) public {
    numberOfTodos++;
    todos[numberOfTodos] = Todo(numberOfTodos, description, false);
  }

  function getTodoById(uint256 id) public view returns (Todo memory) {
    return todos[id];
  }

  function toggleCompleted(uint _id) public {
    Todo memory _todo = todos[_id];
    _todo.completed = !_todo.completed;
    todos[_id] = _todo;
  }
}

