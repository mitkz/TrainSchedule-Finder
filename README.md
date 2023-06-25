# TrainSchedule-Finder
A GARMIN watch widget to know the departure times of the nearest train station.

This program does not get data from the internet, it uses the data, which defined as Array in source/TrainScheduleFinderView.mc.

Data structure is the 2 dimention list such as [[hhmm(str), traintype(int)],...].  
By default, you can set two train type 0 and 1. 0 is for the train that stops at all stations and displayed with black color. 1 is for the train that stops at the main stations and displayed with green color.  

Example:  
[[0845,0],[0851,1],...,[2359,0]]

Please get time schedule from your favorite train company and convert it to the above format.

FAQ  
Q: Why don't you get data from the internet?  
A: Watch and phone are frequently disconected. I think it isn't reasonable to get data from the internet everytime. (Train schedule is not changed frequently.) 

Q: Why do you hardcode the train schedule?  
A: There aren't good way to get data from file in the watch. Writing data in strings.xml might be work, but I think it is not reasonable to read and parse everytime. 