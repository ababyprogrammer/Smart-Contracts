// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Todos {
    struct Todo {
        string text;
        bool completed;
    }
    Todo[] public todos;
    // This is a normal fucntion.
    function creat(string calldata _text) public {
        todos.push(Todo(_text, false));
        todos.push(Todo({text: _text, completed: false}));
        Todo memory todo;
        todo.text = _text;
        todos.push(todo);
    }
    
    // This is a view function.
    function get(uint _index) view public returns (string memory text, bool completed) {
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    // This is a normal function.
    function updateText(uint _index, string calldata _text) public {
        Todo storage todo = todos[_index];
        todo.text = _text;
    }

    // This is normal function.
    function toggleCompleted(uint _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }
}