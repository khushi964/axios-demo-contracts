// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TodoList{

    struct Task{
        uint id;
        string name;
        bool isCompleted;
    }
    uint private taskCount=0;
    mapping(uint=>Task) private tasks;
   
    function createTask(string memory _name) public{
        taskCount++;
        tasks[taskCount]=Task(taskCount,_name,false);
        emit TaskCreated(taskCount, _name);
    }
    event TaskCreated(uint id, string name);
    
    function completeTask(uint _id) public {
        require(_id>0&&_id<=taskCount, "Invalid task id entered");
        Task storage task = tasks[_id];
              require(!task.isCompleted, "Task already completed");

        task.isCompleted=true;
    }
    event TaskCompleted(uint id);

    function getTask(uint _id) public view returns(uint, string memory, bool){
        require(_id>0&&_id<=taskCount, "Invalid task id entered");

        Task storage task = tasks[_id];
        return(task.id,task.name,task.isCompleted);
    }

    function getTaskCount() public view returns(uint){
        return taskCount;
    }

    function deleteTask(uint _id) public {
        require(_id>0&&_id<=taskCount, "Invalid task id entered");
        for(uint i= _id+1; i<=taskCount;i++){
            Task storage task = tasks[i];
            Task storage task1 = tasks[i-1];
            task1.name=task.name;
            task1.isCompleted=task.isCompleted;
        }
        taskCount--;
        emit TaskDeleted(_id , tasks[_id].name);
    }
    event TaskDeleted(uint id, string name);
    
}
