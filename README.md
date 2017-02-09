Got me some problems....

1) Extract Time series from the csv. Add in max detuning and do whatever it is we're supposed to do  with the sampling period

2) How do we store and use this Time series for easy and reliable analysis? Is a struct a good idea? with each event 
   being an instance, and with it associated its loopid , sample rate, time etc? Or instead a cell array, 1st element loop id,
   2nd time, third the combined profile values?
   
3) Once we've got the data in a good format (or before), we should work out the connections between loops as some sort of 
   directed graph. This way we know which loops follow on from each other and such. We could account for disappearnaces and 
   and such using sources/sinks??? Just to make it clearer...
   
4) The important bit! gotta make some features.... DTW seems promising, but it is pairwise... that makes it a bit more 
   difficult to use things like KNN to cluster data? maybe we need other metrics like area under curve, number of peaks, 
   length of signal, max signal, etc etc This needs to be an area of research? How do people measure similarity between time 
   series?
   
5) The next step is trying to find the vehicle being tracked... If we have lots of features, we can just choose the
   nearest neighbour? This is pretty difficult with dtw though. That might require a separate process (like weighting the 
   other features by their dtw distance) or just be the only one.  But we do have some information
   thanks to the directed graph... We know where it can turn up and we also know it has to turn up afterwards, which will
   probably cut out a fair bit of noise.
   
   
 6) A problem. If we identify a car that looks similar, how do we know it is the same one? We dont - unsupervised learning...
    Therefore how can we quantify and qualify our results? I.e how can we say that we're 80% confident this car is the same 
    one as before? Are there any methods around that do this sort of thing? for a single car this is binary  classification
    surely? Either the other data is the same car or its not. 
 
