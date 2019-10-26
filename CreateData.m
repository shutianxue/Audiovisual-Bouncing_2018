function Data = CreateData(subjectID,block,nconditions,conditions)

%Get screen specifications

Data.SubjectID   = subjectID;
Data.block       = block;
Data.Nthresholds = nconditions;
Data.Conditions  = conditions;
Data.stimuli_record = [];

Data.ThresholdName = { ''; ''; ''; ''};
Data.InitialTest = [];
Data.Threshold = -1*ones(4,1); %Create all and hold empty if missing
Data.ThresholdConfidenceInterval = repmat([-1 -1],4,1); %Create all and hold empty if missing

Data.Data.Running.Condition = [];
Data.Data.Running.StimVals = [];
Data.Data.Running.Responses = [];
Data.Data.Running.RTs = [];
Data.Data.Running.Sequences = [];

Data.Data.PerCondition.StimVals = [];
Data.Data.PerCondition.StimValsDeg = [];
Data.Data.PerCondition.Responses = [];
Data.Data.PerCondition.RTs = [];
Data.Data.PerCondition.Sequences = [];

for f = 1:4 %Create all and hold empty if missing
    Data.Data.PerCondition.StimVals{f} = [];
    Data.Data.PerCondition.StimValsDeg{f} = [];
    Data.Data.PerCondition.Responses{f} = [];
    Data.Practice.PerCondition.StimVals{f} = [];
    Data.Data.PerCondition.RTs{f} = [];
    
end