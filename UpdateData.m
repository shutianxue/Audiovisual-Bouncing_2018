function Data = UpdateData(Data, used_delta, correctness, anstime, condition, sequence)

s = condition;

Data.Data.PerCondition.StimVals{s} = [Data.Data.PerCondition.StimVals{s}; used_delta];
Data.Data.PerCondition.Responses{s} = [Data.Data.PerCondition.Responses{s}; correctness];
Data.Data.PerCondition.RTs{s} = [Data.Data.PerCondition.RTs{s}; anstime];
Data.Data.PerCondition.Sequences{s} = [Data.Data.PerCondition.Sequences{s}; sequence];

Data.Data.Running.Condition = [Data.Data.Running.Condition; s];
Data.Data.Running.StimVals = [Data.Data.Running.StimVals; used_delta];
Data.Data.Running.Responses = [Data.Data.Running.Responses; correctness];
Data.Data.Running.RTs = [Data.Data.Running.RTs; anstime];
Data.Data.Running.Sequences{s} = [Data.Data.PerCondition.Sequences; sequence];
