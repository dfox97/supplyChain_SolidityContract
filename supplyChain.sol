pragma solidity >=0.4.25 <0.6.0;


contract supplyChain{
    
    
    address public initiatingParty;
    address public previousParty;
    address public CounterParty;
    
    
    address public Owner;
    address public Observer;
    
    //we create different state types 
    enum stateTypes{
        Created,
        Intransit, 
        Completed}
        
    stateTypes public State;
    
    constructor(address SupplyChainOwner, address SupplyChainObserver)public{
        
        initiatingParty=msg.sender;
        CounterParty=initiatingParty;//person who calls the contract msg.sender address is then the current party 
        Owner=SupplyChainOwner; //address is set to owner
        Observer=SupplyChainObserver; //observer is the owner
        
        
        State=stateTypes.Created; //SETS THE STATE TO CREATED
        
        
        
        
    }
    
    function changeResponsibiltiy(address newCounterParty)public{
        
        //FIX THIS LATER FOR SECURITY!!!<-------------------
        // if (CounterParty!=msg.sender || State==stateTypes.Completed ){
        //     revert(); //revert transaction if not completed
        // }
        
        //simple supply chain setting the state to intransit THIS CAN BE EXPANDED IN TIME TO TRACK AN ITEM 
        if (State==stateTypes.Created){
            State=stateTypes.Intransit;//swap state to Intransit
        }
        
        previousParty = CounterParty;
        CounterParty = newCounterParty;
        
    }
    
    
    function complete()public{
        if (Owner != msg.sender || State == stateTypes.Completed)
        {
            revert();
        }

        previousParty = CounterParty;
        CounterParty = address(0);
        State=stateTypes.Completed;
    }
        
    
    
    
    
    
}
