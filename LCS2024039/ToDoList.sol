// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ToDoList {

    struct Task {
        uint id;
        string name;
        bool isCompleted;
    }

    uint private TaskCount;
    uint private FullTaskCount;

    mapping(uint=>Task) private tasks;

    function CreateTask(string memory _name) public {
        FullTaskCount++;
        TaskCount++;
        tasks[FullTaskCount]=Task(FullTaskCount,_name,false);
        emit TaskCreated(FullTaskCount, _name);
    }

    event TaskCreated(uint id, string _name);

    function CompleteTask(uint _id) public {

        require(_id>0&&_id<=FullTaskCount, "Invalid Task ID entered");

        Task storage task = tasks[_id];

        require(!task.isCompleted, "Task Already Completed");

        task.isCompleted=true;
        emit TaskCompleted(_id);
    }

    event TaskCompleted(uint id);

    function getTask(uint _id) public view returns(uint, string memory, bool){

        require(_id>0&&_id<=FullTaskCount, "Invalid Task ID entered");

        Task storage task = tasks[_id];
        require(task.id!=0,"Task has been Deleted");
        return (task.id, task.name, task.isCompleted);
    }

    function getTaskCount() public view returns(uint) {
        return TaskCount;
    }

    function deleteTask(uint _id) public {

        require(_id>0&&_id<=FullTaskCount, "Invalid Task ID entered");

        delete tasks[_id];
        TaskCount--;
        emit TaskDeleted(_id);
    }

    event TaskDeleted(uint id);
}