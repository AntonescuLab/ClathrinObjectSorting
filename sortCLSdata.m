function [ punctaData ] = sortCLSdata(data,thresholdPrimary)

% For a given data structure composed of SINGLE FRAMES of a MULTIPLE CHANNELS,
% returns mean intensity value and the mean density for each Detected
% particle in structure. Requires runDetection() analysis to be run prior
% to using this function. 

% The 'Threshold' refers to an intensity threshold value. This value is used in
% conjunction with the corresponding control condition, such as to
% eliminate structures below an arbitrary level in intensity for the
% finduciary (primary) channel


 

avgCCPInt = [];
medianCCPInt = [];
Density = [];
IntensityLowerQuantile = [];
quantile_value = 0.5;
thresholdSecondary1 = -5000;
thresholdSecondary2 = -5000;
 CCPcount_overPrimaryTH = [];


  final_primChan_overSecondaryTH = [];
  final_secChan_overSecondaryTH = [];
  final_tertChan_overSecondaryTH = [];
         
  final_primChan_overSecondaryTH_oS1oS2 = [];
  final_secChan_overSecondaryTH_oS1oS2 = [];
  final_tertChan_overSecondaryTH_oS1oS2 = [];
            
        
  final_primChan_overSecondaryTH_oS1uS2 = [];
  final_secChan_overSecondaryTH_oS1uS2 = [];
  final_tertChan_overSecondaryTH_oS1uS2 = [];

  
   running_final_primChan = [];
   running_final_secChan = [];
   running_final_tertChan = [];
   
   running_final_primChan_overSecondaryTH = [];
   running_final_primChan_underSecondaryTH = [];
   running_final_primChan_overSecondaryTH_oS1oS2 = [];
   running_final_primChan_overSecondaryTH_oS1uS2 = [];
   
   final_primChan_underSecondaryTH = [];
   final_secChan_underSecondaryTH = [];
   final_tertChan_underSecondaryTH = [];     

running_Dens = 0;
running_Dens_overSecondaryTH = 0;
running_Dens_underSecondaryTH = 0;
running_Dens_overSecondary1_overSecondary2 = 0;
running_Dens_overSecondary1_underSecondary2 = 0;
running_Dens_underSecondary1_overSecondary2 = 0;
running_Dens_underSecondary1_underSecondary2 = 0;


for i=1:length(data) % data is the whole data structure, each i is a single set of images
    
    %resetting carrier variables at the beginning of each loop
        %iteration
        
        Dens = 0;
        Dens_overSecondaryTH = 0;
        Dens_underSecondaryTH = 0;
        Dens_overSecondary1_overSecondary2 = 0;
        Dens_overSecondary1_underSecondary2 = 0;
        Dens_underSecondary1_overSecondary2 = 0;
        Dens_underSecondary1_underSecondary2 = 0;
        
        primaryChannel = [];
        secondaryChannel = [];
        TertirayChannel = [];
        
        
        primChan_overSecondaryTH = [];
        secChan_overSecondaryTH = [];
        tertChan_overSecondaryTH = [];
        
        primChan_underSecondaryTH = []; 
        secChan_underSecondaryTH = []; 
        tertChan_underSecondaryTH = []; 
        
        
        primChan_overSecondaryTH_oS1oS2 = [];
        secChan_overSecondaryTH_oS1oS2 = [];
        tertChan_overSecondaryTH_oS1oS2 = [];

        
        primChan_overSecondaryTH_oS1uS2 = []; 
        secChan_overSecondaryTH_oS1uS2= []; 
        tertChan_overSecondaryTH_oS1uS2 = [];

       
        primChan_underSecondaryTH = []; 
        secChan_underSecondaryTH = []; 
        tertChan_underSecondaryTH = []; 
                    
        
        primChan_underSecondaryTH_uS1oS2 = [];  
        secChan_underSecondaryTH_uS1oS2 = [];
        tertChan_underSecondaryTH_uS1oS2 = [];

       
       primChan_underSecondaryTH_uS1uS2 = [];
       secChan_underSecondaryTH_uS1uS2 = [];
       tertChan_underSecondaryTH_uS1uS2 = [];

       
      
       %start of loading variables for each loop

    loadfile = load([data(i).source 'Detection' filesep 'detection_v2.mat']);
    
	primaryChannel = [];
    secondaryChannel = [];
    TertirayChannel = [];
    
    long = loadfile.frameInfo.x_init;
	
        
        
		for j=1:length(long); % long is the number of detections in an image, each j is a structure (e.g. CCP)
	
            intensities = loadfile.frameInfo.A;

            x = intensities(1,j);
            y = intensities(2,j);
            z = intensities(3,j);
           
            
            if x > thresholdPrimary
                Dens = Dens +1;
                running_Dens = running_Dens+1;
                
                primaryChannel(Dens) = x;
                secondaryChannel(Dens) = y;
                TertirayChannel(Dens) = z;
                
                 running_final_primChan(running_Dens) = x;
                 running_final_secChan(running_Dens) = y;
                 running_final_tertChan(running_Dens) = z;
   
               
                
                if y > thresholdSecondary1
                
                    Dens_overSecondaryTH = Dens_overSecondaryTH + 1;
                    running_Dens_overSecondaryTH = running_Dens_overSecondaryTH + 1;
                    
                    primChan_overSecondaryTH(Dens_overSecondaryTH) = x; 
                    secChan_overSecondaryTH(Dens_overSecondaryTH) = y; 
                    tertChan_overSecondaryTH(Dens_overSecondaryTH) = z; 
                
           
                    
                      running_final_primChan_overSecondaryTH(running_Dens_overSecondaryTH) = x;


                               
                     if z > thresholdSecondary2
                         
                         Dens_overSecondary1_overSecondary2 = Dens_overSecondary1_overSecondary2 +1;
                         running_Dens_overSecondary1_overSecondary2 = running_Dens_overSecondary1_overSecondary2 +1;
                         
                         primChan_overSecondaryTH_oS1oS2(Dens_overSecondary1_overSecondary2) = x; 
                         secChan_overSecondaryTH_oS1oS2(Dens_overSecondary1_overSecondary2) = y; 
                         tertChan_overSecondaryTH_oS1oS2(Dens_overSecondary1_overSecondary2) = z; 

                        
                         running_final_primChan_overSecondaryTH_oS1oS2(running_Dens_overSecondary1_overSecondary2) = x;
 


                     else 
                     
                         Dens_overSecondary1_underSecondary2 = Dens_overSecondary1_underSecondary2 +1;
                        running_Dens_overSecondary1_underSecondary2 = running_Dens_overSecondary1_underSecondary2 +1;
                         
                         primChan_overSecondaryTH_oS1uS2(Dens_overSecondary1_underSecondary2) = x; 
                         secChan_overSecondaryTH_oS1uS2(Dens_overSecondary1_underSecondary2) = y; 
                         tertChan_overSecondaryTH_oS1uS2(Dens_overSecondary1_underSecondary2) = z; 

                        

                            running_final_primChan_overSecondaryTH_oS1uS2(running_Dens_overSecondary1_underSecondary2) = x;

                         
                     end;     
                     
                else
                    
                    Dens_underSecondaryTH = Dens_underSecondaryTH + 1;
                    running_Dens_underSecondaryTH = running_Dens_underSecondaryTH + 1;
                    
                    primChan_underSecondaryTH(Dens_underSecondaryTH) = x; 
                    secChan_underSecondaryTH(Dens_underSecondaryTH) = y; 
                    tertChan_underSecondaryTH(Dens_underSecondaryTH) = z; 
                    
                    
                    running_final_primChan_underSecondaryTH(running_Dens_underSecondaryTH) = x;
                     
                      if z > thresholdSecondary2
                         
                         Dens_underSecondary1_overSecondary2 = Dens_underSecondary1_overSecondary2 +1;

                         running_Dens_underSecondary1_overSecondary2 = running_Dens_underSecondary1_overSecondary2 +1;
                         
                         primChan_underSecondaryTH_uS1oS2(Dens_underSecondary1_overSecondary2) = x; 
                         secChan_underSecondaryTH_uS1oS2(Dens_underSecondary1_overSecondary2) = y; 
                         tertChan_underSecondaryTH_uS1oS2(Dens_underSecondary1_overSecondary2) = z; 

                      
                     
                   
                         
                     else 
                     
                         Dens_underSecondary1_underSecondary2 = Dens_underSecondary1_underSecondary2 +1;
                        running_Dens_underSecondary1_underSecondary2 = running_Dens_underSecondary1_underSecondary2 +1;
                        
                         primChan_underSecondaryTH_uS1uS2(Dens_underSecondary1_underSecondary2) = x; 
                         secChan_underSecondaryTH_uS1uS2(Dens_underSecondary1_underSecondary2) = y; 
                         tertChan_underSecondaryTH_uS1uS2(Dens_underSecondary1_underSecondary2) = z; 

                        

                         
                     end;     
                     
                     
                     
                     
                end;
                
                    
                % primaryChannel(j)
            end % if
    
                       
               
		end  %for length(long), this is the end of analysis of a single image set (cell)
   	
        
        avgCCPInt(i)  = mean(primaryChannel);
        medianCCPint(i) = quantile(primaryChannel,.5);

        
        
        avgSecondaryInt(i) = mean(secondaryChannel);
        avgSecondary2Int(i) = mean(TertirayChannel);
        IntensityLowerQuantile(i)= quantile(primaryChannel,quantile_value);
        CCPcount(i) = length(long);
        CCPcount_overPrimaryTH(i) = Dens;
        
        x_coord = data(i).imagesize(1);
        y_coord = data(i).imagesize(2);
        area = x_coord * y_coord;
                
        Density(i) = Dens/area;
        
        
        avg_primChan_overSecondaryTH(i) = mean(primChan_overSecondaryTH);
        avg_secChan_overSecondaryTH(i) = mean(secChan_overSecondaryTH);
        avg_tertChan_overSecondaryTH(i) = mean(tertChan_overSecondaryTH);
       
        
        
        
        avg_primChan_overSecondaryTH_oS1oS2(i) = mean(primChan_overSecondaryTH_oS1oS2);
        avg_secChan_overSecondaryTH_oS1oS2(i) = mean(secChan_overSecondaryTH_oS1oS2); 
        avg_tertChan_overSecondaryTH_oS1oS2(i) = mean(tertChan_overSecondaryTH_oS1oS2);

        
        
        CCPcount_EGFpos_Secondary2pos(i) = Dens_overSecondary1_overSecondary2;
        
        
        avg_primChan_overSecondaryTH_oS1uS2(i) = mean(primChan_overSecondaryTH_oS1uS2);
        avg_secChan_overSecondaryTH_oS1uS2(i) = mean(secChan_overSecondaryTH_oS1uS2); 
        avg_tertChan_overSecondaryTH_oS1uS2(i) = mean(tertChan_overSecondaryTH_oS1uS2);

       
        
        CCPcount_EGFpos_Secondary2neg(i) = Dens_overSecondary1_underSecondary2;
        
        CCPcount_EGFpos(i) = Dens_overSecondaryTH;
      
        avg_primChan_underSecondaryTH(i) = mean(primChan_underSecondaryTH);
        avg_secChan_underSecondaryTH(i) = mean(secChan_underSecondaryTH);
        avg_tertChan_underSecondaryTH(i) = mean(tertChan_underSecondaryTH);
        
        
        
        
        CCPcount_EGFneg(i) = Dens_underSecondaryTH;
        CCPcount_EGFneg_Secondary2pos(i) = Dens_underSecondary1_overSecondary2;
        CCPcount_EGFneg_Secondary2neg(i) = Dens_underSecondary1_underSecondary2;
       
        
       
        
        for a_a = 1:Dens_overSecondaryTH
            
           

             
        final_primChan_overSecondaryTH(i,a_a) = primChan_overSecondaryTH(a_a);
        final_secChan_overSecondaryTH(i,a_a) = secChan_overSecondaryTH(a_a);
        final_tertChan_overSecondaryTH(i,a_a) = tertChan_overSecondaryTH(a_a);
       
        
      
        end % for a_a
        
            
        for b_b = 1:Dens_underSecondaryTH
            
            
            final_primChan_underSecondaryTH(i,b_b) = primChan_underSecondaryTH(b_b);
            final_secChan_underSecondaryTH(i,b_b) = secChan_underSecondaryTH(b_b);
            final_tertChan_underSecondaryTH(i,b_b) = tertChan_underSecondaryTH(b_b);
        
        end % for b_b
       
        for c_c = 1:Dens_overSecondary1_overSecondary2
            
        
        final_primChan_overSecondaryTH_oS1oS2(i,c_c) = primChan_overSecondaryTH_oS1oS2(c_c);
        final_secChan_overSecondaryTH_oS1oS2(i,c_c) = secChan_overSecondaryTH_oS1oS2(c_c); 
        final_tertChan_overSecondaryTH_oS1oS2(i,c_c) = tertChan_overSecondaryTH_oS1oS2(c_c);
            
        
        
        end % for c_c
        
        
        for d_d = 1:Dens_overSecondary1_underSecondary2
            
            
            final_primChan_overSecondaryTH_oS1uS2(i,d_d) = primChan_overSecondaryTH_oS1uS2(d_d);
            final_secChan_overSecondaryTH_oS1uS2(i,d_d) = secChan_overSecondaryTH_oS1uS2(d_d); 
            final_tertChan_overSecondaryTH_oS1uS2(i,d_d) = tertChan_overSecondaryTH_oS1uS2(d_d);

        
        end % for d_d
        
         for e_e = 1:Dens_underSecondary1_overSecondary2
            
        
         end % for e_e 
        
        
        for f_f = 1:Dens_underSecondary1_underSecondary2
            
        
        end % for f_f   
        
        
        
end % for length(data)




punctaData.Density = Density;
punctaData.CCPcount = CCPcount;
punctaData.PrimaryChannel_AvgPunctaIntensity = avgCCPInt;
punctaData.PrimaryChannel_IndividualStructureIntensities = running_final_primChan;

punctaData.SecondaryChannel_AvgPunctaIntensity = avgSecondaryInt;
punctaData.SecodaryChannel_IndividualStructureIntensities = running_final_secChan;

punctaData.TertiaryChannel_AvgPunctaIntensity = avgSecondary2Int;
punctaData.SecodaryChannel_IndividualStructureIntensities = running_final_tertChan;

                 

end % function
