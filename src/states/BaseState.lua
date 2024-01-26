--creating a base class which has all empty method, which are all required by statemachine class.
--other states will inherit from this class, so they can have all methods required by statemacine even if we don't define them in their own class.

BaseState = Class{}

function BaseState:init() end
function BaseState:enter(enterParas) end
function BaseState:exit() end
function BaseState:update(dt) end
function BaseState:render() end