function out=GASPROP3(T,property,gas,Prop,PropData)
%#ok<*OR2>
%#ok<*AND2>
%#ok<*UNRCH>
%#ok<*NODEF>

col=find(strcmp(Prop,property));
if strcmp(gas,'air')
    out=interp1(PropData(1:35,1),PropData(1:35,col),T); 
elseif strcmp(gas,'he')
    out=interp1(PropData(36:316,1),PropData(36:316,col),T); 
elseif strcmp(gas,'ar')
    out=interp1(PropData(317:347,1),PropData(317:347,col),T); 
elseif strcmp(gas,'co2')
    out=interp1(PropData(348:383,1),PropData(348:383,col),T); 
elseif strcmp(gas,'h2o')
    out=interp1(PropData(384:403,1),PropData(384:403,col),T); 
end