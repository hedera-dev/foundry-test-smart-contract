// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "contracts/TodoList.sol";

contract TodoListTest is Test {
    TodoList public todoList;
    uint256 numberOfTodos;
  
    // Arrange everything you need to run your tests
    function setUp() public {
        todoList = new TodoList();
    }

    function test_CreateTodo() public {
        // arrange
        todoList.createTodo("Feed my dog");

        // act
        numberOfTodos = todoList.numberOfTodos();

        // assert
        assertEq(numberOfTodos, 1);
    }

    function test_GetTodoById() public {
        // arrange
        todoList.createTodo("Pack my bags");

        // act
        Todo memory todo = todoList.getTodoById(1);

        // assert
        assertEq(todo.description, "Pack my bags");
    }

    function test_ToggleCompleted() public {
        // arrange
        todoList.createTodo("Update my calendar");

        // act
        todoList.toggleCompleted(1);

        // assert
        Todo memory todo = todoList.getTodoById(1);
        assertEq(todo.completed, true);
    }
}
