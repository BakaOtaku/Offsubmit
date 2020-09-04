pragma solidity ^0.5.0;

contract CourseCreator {
    address creator;
    mapping(address=>address) deployedAddress;
    
    constructor() public {
        creator = msg.sender;    
    }
    
    function createCourse(uint256 deadline) public returns(address){
        Course ob= new Course(deadline);
        deployedAddress[msg.sender]=address(ob);
        return address(ob);
    }
    
    function fetchCourseAddress () public view returns(address) {
        return deployedAddress[msg.sender];
    }
    function getCreator() public view returns (address) {
        return creator;
    }
}


contract Course {
    uint deadline;
    
    // mapping (address=>uint256) submissionTime;
    mapping (address=>string) public  fileHash;
    
    constructor (uint256 dl) public {
        deadline = dl;
    }
    
    function submit(string memory file) public {
       if(now<deadline) {
           fileHash[msg.sender]=file;
       }
    }
}