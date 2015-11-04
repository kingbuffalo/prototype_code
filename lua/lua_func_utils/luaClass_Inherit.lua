local classDef_meta = {__index={m1=1,m2=2}}

function classDef_meta.__index:func1()
	print(self.m1,self.m2)
end

local function createClassObj()
	local obj = {}
	setmetatable(obj,classDef_meta)
	return obj
end

local subClass_mt = {__index={m3=-1}}
function subClass_mt.__index:func2()
	print(self.m1,self.m2,self.m3)
end

local function inheritsClass(subClassDef_mt,baseClassDef_mt)
	setmetatable(subClassDef_mt.__index,{__index=baseClassDef_mt.__index})
end

local function createSubClassObj()
	local obj = {}
	inheritsClass(subClass_mt,classDef_meta)
	setmetatable(obj,subClass_mt)
	return obj
end

local obj = createSubClassObj()
obj:func1()
obj.m1 = 100
obj:func2()
local obj2 = createSubClassObj()
obj2:func2()
--------------------
--out put:
--1	2
--100	2	-1
--1	2	-1