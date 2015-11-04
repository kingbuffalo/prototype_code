local classDef_meta = {__index={m1=1,m2=2}}

function classDef_meta.__index:func1()
	self.m1=100
	print(self.m1,self.m2)
end

local function createClassObj()
	local obj = {}
	setmetatable(obj,classDef_meta)
	return obj
end

local obj1 = createClassObj()
obj1:func1()
obj1.m2= 3
obj1:func1()

local obj2 = createClassObj()
obj2:func1()

--------------------
--out put:
--100	2
--100	3
--100	2
