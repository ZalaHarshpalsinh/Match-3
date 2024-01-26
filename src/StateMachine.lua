--file for state machine class

--create class using class library
StateMachine = Class{}

--constructor function
function StateMachine:init(states)
    self.states = states or {}
    self.current_state = self.states['BaseState']()
end

--function to upadare the current state
function StateMachine:update(dt)
    self.current_state:update(dt)
end

--function to render the current state
function StateMachine:render(dt)
    self.current_state:render(dt)
end



--function to transition from one state to another, also pass on necessary parameters to state that we are transitioning to.
function StateMachine:change(stateName,enterParas)
    --check if given state exist
    assert(self.states[stateName])

    --exit current state
    self.current_state:exit()

    --set current state to new state
    self.current_state = self.states[stateName]()

    --call enter method of new state to initialize it with passed params 
    self.current_state:enter(enterParas)
end