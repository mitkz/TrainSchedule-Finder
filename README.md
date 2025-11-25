# TrainSchedule-Finder
A GARMIN watch widget to know the departure times of the nearest train station.

This program does not get data from the internet, it uses the data, which defined as Array in source/TrainScheduleData.mc.

Data structure is the 2 dimension list such as [[hhmm(int), traintype(int)],...].  
By default, you can set two train type 0 and 1. 0 is for the train that stops at all stations and displayed with black color. 1 is for the train that stops at the main stations and displayed with green color.  

Example:  
[[0845,0],[0851,1],...,[2359,0]]

Please get time schedule from your favorite train company and convert it to the above format.
Edit the `weekday_table` and `holiday_table` variables in `source/TrainScheduleData.mc` to set your train schedule.

FAQ  
Q: Why don't you get data from the internet?  
A: Watch and phone are frequently disconected. I think it isn't reasonable to get data from the internet everytime. (Train schedule is not changed frequently.) 

Q: Why do you use a separate file for the train schedule?  
A: It makes it easier to customize the train schedule without modifying the main application code. Users can simply edit `source/TrainScheduleData.mc` to set their own schedule. 