pragma solidity ^0.4.18;

contract show_case_abstract_1{
    struct Event{
        address[] attendees;
        uint id;
        uint roomState;
    }
    
    Event[] events;
    
    function createEvent() public;
    
    function getAttendeeAddress() public view returns(address){
        return events[0].attendees[0];
    }
}

contract Wrong is show_case_abstract_1{
    function createEvent() public{
        address[] atd;
        atd.push(msg.sender);
        Event memory e = Event(atd, 0, 0);
        events.push(e);
    }
}

contract Better is show_case_abstract_1{
    function createEvent() public{
        Event memory e = Event(new address[](0), 1, 0);
        uint index = events.push(e) - 1;
        events[index].attendees.push(msg.sender);
    }    
}

contract show_case_abstract_2{
    struct Student{
        ID studentId;
        string name;
    }
    
    struct ID{
        uint studentNumber;
        address studentAddress;
    }
    
    struct Event{
        Student attendee;
        uint id;
    }
    
    Event[] events;
    function createEvent() public;
    
    function getAttendeeAddress() public view returns(address){
        return events[0].attendee.studentId.studentAddress;
    }
}

contract Odd_1 is show_case_abstract_2{
    function createEvent() public{
        ID memory id = ID(153746, msg.sender);
        Student memory student = Student(id, "Lasse Herskind");
        Event memory e = Event(student, 0);
        events.push(e);
    }
}
