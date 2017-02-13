Got me some problems....

DONE

1) Extract Time series from the csv. Add in max detuning and do whatever it is we're supposed to do  with the sampling period

DONE: big cell array for profile values, 1 str array for loop id and time and 1 num array for sample rate length and max detuning

2) How do we store and use this Time series for easy and reliable analysis? Is a struct a good idea? with each event 
   being an instance, and with it associated its loopid , sample rate, time etc? Or instead a cell array, 1st element loop id,
   2nd time, third the combined profile values?
   
Alex...
3) Once we've got the data in a good format (or before), we should work out the connections between loops as some sort of 
   directed graph. This way we know which loops follow on from each other and such. We could account for disappearances and 
   and such using sources/sinks??? Just to make it clearer...

Also i think splitting up the data by loop id is a good idea...


4) The important bit! gotta make some features.... DTW seems promising, but it is pairwise (and is it symmetric? cause it takes   a   bloody long time)... that makes it a bit more. Looks like lots of difference between sensors either because of speed or just being shitty sensors. might make it hard. LCSS? Longest common subsequence
   difficult to use things like KNN to cluster data? maybe we need other metrics like area under curve, number of peaks, 
   length of signal, max signal, Frequencies (susceptible to leakage though gotta be clever), ARMA, AR, least squares, F test with arima?????  etc etc This needs to be an area of research. How do people measure similarity between time 
   series? DTW accounts for time stretching but not scaling due to speed, i think. 
   
5) The next step is trying to find the vehicle being tracked... If we have lots of features, we can just choose the
   nearest neighbour? This is pretty difficult with dtw though. That might require a separate process (like weighting the 
   other features by their dtw distance) or just be the only one.  But we do have some information
   thanks to the directed graph... We know where it can turn up and we also know it has to turn up afterwards, which will
   probably cut out a fair bit of noise.
   
   
 6) A problem. If we identify a car that looks similar, how do we know it is the same one? We dont - unsupervised learning...
    Therefore how can we quantify and qualify our results? I.e how can we say that we're 80% confident this car is the same 
    one as before? Are there any methods around that do this sort of thing? for a single car this is binary  classification
    surely? Either the other data is the same car or its not. 



THINGS TO DO:

Split up! identify  cars, vans, buses trucks.
Split up! partition data set by loop ID so we can search in right place, convert map into rules to search by.
read paper.
visualise
Look up other metrics. 
Look up ways to assess unsupervised classification performance
Look up ways to speed things up.
 
