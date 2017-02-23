%% Make a Heat Map
load 'loopData56'

%Start for A (units are in ms...)

loopData56 = loopData;

originTime = datenum('2017-02-06 17:00:00.00');
daySecs = 60*60*24;

Avec = [];
Atime = [];
for i=1:length(loopData56(1).A)
    startTime = daySecs*(datenum(loopData56(2).A{i}) - originTime);
    eventTimes =  startTime + 0.001*[0:1:length(loopData56(3).A{i})-1];
    Atime = [Atime,eventTimes];
    Avec  = [Avec,loopData56(3).A{i}];
end

Bvec = [];
Btime = [];
for i=1:length(loopData56(1).B)
    startTime = daySecs*(datenum(loopData56(2).B{i}) - originTime);
    eventTimes =  startTime + 0.001*[0:1:length(loopData56(3).B{i})-1];
    Btime = [Btime,eventTimes];
    Bvec  = [Bvec,loopData56(3).B{i}];
end

plot(Atime,Avec,Btime,Bvec);