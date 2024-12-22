// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TodoList{

    struct Task{
        uint id;
        string name;
        bool isCompleted;
    }
    uint public taskCount=0;
    mapping(uint=>Task) public tasks;

    function createTask(string memory _name) public {
        taskCount++;
        tasks[taskCount]=Task(taskCount,_name,false);
        emit TaskCreated(taskCount,_name);

    }
    event TaskCreated(uint id, string name);

    function completeTask(uint _id) public {
        require(_id>0&&_id<=taskCount, "Invalid task ID entered");

        Task storage task = tasks[_id];
        require(!task.isCompleted,"Task already completed!");
        task.isCompleted=true;
    }
    event TaskCompleted(uint id);

    function getTask(uint _id) public view returns(uint, string memory, bool){
        require(_id>0&&_id<=taskCount, "Invalid task ID entered");

        Task storage task = tasks[_id];
        return (task.id, task.name, task.isCompleted);

    }
    function getTaskCount() public view returns(uint){
        return taskCount;
    }
    function delTask(uint _id) public {
        require(_id>0&&_id<=taskCount, "Invalid task ID entered");
        
        delete tasks[_id];
        taskCount--;
    }
}
