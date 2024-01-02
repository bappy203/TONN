
function remaining_time_estimator(currenttime,curriteration,totiteration,varargin)

 

 

% curriteration=fevalcounter;

% totiteration=totalfeval;

%             currenttime=toc;

 

percent_complete=curriteration/(totiteration)*100;

 

% currenttime=toc;

 

ETR=currenttime/curriteration*(totiteration)-currenttime;

 

ETRday=floor(ETR/(24*3600));

ETRhr=floor(mod(ETR,24*3600)/3600);

ETRmin=floor(mod(ETR,3600)/60);

ETRsec=mod(ETR,60);

 

currenttimeday=floor(currenttime/(24*3600));

currenttimehr=floor(mod(currenttime,24*3600)/3600);

currenttimemin=floor(mod(currenttime,3600)/60);

currenttimesec=mod(currenttime,60);

 

disp('---------- Remaining time estimate------------')

disp(['Elapsed time: ' num2str(currenttimeday) ' D ' num2str(currenttimehr) ' H ' num2str(currenttimemin) ' M ' num2str(currenttimesec) ' S'])

disp(['Avg time per itr: ' num2str(currenttime/curriteration)])

disp(['Remaining time: ' num2str(ETRday) ' D ' num2str(ETRhr) ' H ' num2str(ETRmin) ' M ' num2str(ETRsec) ' S'])

disp(['Percent complete : ' num2str(percent_complete) ' % '])

disp('----------------------------------------------')

 

 

 