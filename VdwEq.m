function [] = VdwEq()
    %defines constants and global variables
    global solver R a b;
    R = 8.314;
    a = 0;b = 0;
    
    %initializes figure
    solver.fig = figure;
    
    %creates the text box and edit box so user can insert the critical
    %temperature needed
    solver.critTempEditBox = uicontrol(solver.fig,'Style','edit','units','normalized','position',[.23 .9 .2 .05]);
    solver.critTempTextBox = uicontrol(solver.fig,'Style','text','units','normalized','position',[.02 .895 .2 .05],'String','Critical Temperature(K):');
    
    %creates the text box and edit box so user can insert the critical
    %pressure needed
    solver.critPressureEditBox = uicontrol(solver.fig,'Style','edit','units','normalized','position',[.7 .9 .2 .05]);
    solver.critPressureTextBox = uicontrol(solver.fig,'Style','text','units','normalized','position',[.4975 .895 .2 .05],'String','Critical Pressure(Pa):');
    
    %displays the Van der waal equation
    solver.EqDisplay = uicontrol(solver.fig,'Style','text','units','normalized','position',[.2 .2 .5 .2],'String','The Vanderwaal Equation is: P[V-b]V^2=RTV^2-a(V-b)');
   
    %titles the pressure solver portion
    solver.pressureTitle = uicontrol(solver.fig,'Style','text','units','normalized','position',[.02 .8 .2 .05],'String','Solving for Pressure:');
    
    %creates the text box and edit box so user can insert the specific
    %volume needed
    solver.volumeEditBox = uicontrol(solver.fig,'Style','edit','units','normalized','position',[.175 .75 .2 .05]);
    solver.volumeText = uicontrol(solver.fig,'Style','text','units','normalized','position',[.02 .73 .15 .075],'String','Specific Volume (m^3/mol)');
     
    %creates the text box and edit box so user can insert the temeperature
    %needed
    solver.temperatureEditBox = uicontrol(solver.fig,'Style','edit','units','normalized','position',[.175 .65 .2 .05]);
    solver.temperatureText = uicontrol(solver.fig,'Style','text','units','normalized','position',[.04 .62 .11 .075],'String','Temp (K)');

    %creates the button that triggers the CalculatePressure function so
    %that the calculations can be run
    solver.pressureCalculateButton = uicontrol(solver.fig,'Style','pushbutton','units','normalized','position',[.1 .55 .1 .05],'String','Calculate');
    solver.pressureCalculateButton.Callback=@CalculatePressure;
    
    %displays and titles the final pressure given from the
    %CalculatePressure function
    solver.finalPressureDisplay = uicontrol(solver.fig,'Style','text','units','normalized','position',[.01 .475 .2 .05],'String','Final Pressure(Pa):');
    solver.pressureValue = uicontrol(solver.fig,'Style','text','units','normalized','position',[.2 .475 .15 .05]);
    
    %titles the temperature solving portion of the program
    solver.temperatureTitle = uicontrol(solver.fig,'Style','text','units','normalized','position',[.545 .8 .3 .05],'String','Solving for Temperature:');    
    solver.volume2EditBox = uicontrol(solver.fig,'Style','edit','units','normalized','position',[.7 .75 .2 .05]);
    solver.volume2Text = uicontrol(solver.fig,'Style','text','units','normalized','position',[.545 .73 .15 .075],'String','Specific Volume (m^3/mol)');    
   
    %creates the text box and edit box so user can enter the pressure
    %needed
    solver.pressureEditBox = uicontrol(solver.fig,'Style','edit','units','normalized','position',[.7 .65 .2 .05]);
    solver.pressureText = uicontrol(solver.fig,'Style','text','units','normalized','position',[.56 .62 .11 .075],'String','Pressure (Pa)');
    
    %displays and titles the final temperature given by the
    %CalculateTemperature function
    solver.finalTemperatureDisplay = uicontrol(solver.fig,'Style','text','units','normalized','position',[.55 .475 .2 .05],'String','Final Temperature(K):');
    solver.temperatureValue = uicontrol(solver.fig,'Style','text','units','normalized','position',[.74 .475 .15 .05]);
  
    %creates the button that triggers the CalculateTemperature function
    solver.temperatureCalculateButton = uicontrol(solver.fig,'Style','pushbutton','units','normalized','position',[.6 .55 .1 .05],'String','Calculate');
    solver.temperatureCalculateButton.Callback=@CalculateTemperature;
   
    %takes in all inputed values from the pressure portion and solves the
    %Van der waal equation
    function CalculatePressure(src,event)
    %gets the input values from the critical temperature and critical
    %pressure edit boxes
        solver.critTemp = get(solver.critTempEditBox,'String');
        solver.critPressure = get(solver.critPressureEditBox,'String');
    %if statements that check for any invalid inputs
        if isempty(str2num(solver.critPressureEditBox.String)) | str2num(solver.critPressureEditBox.String) < 0
            msgbox('Please insert a valid critical pressure!');
        elseif isempty(str2num(solver.critTempEditBox.String)) | str2num(solver.critTempEditBox.String) < 0
            msgbox('Please insert a valid critical temperature!');
        elseif isempty(str2num(solver.temperatureEditBox.String)) | str2num(solver.temperatureEditBox.String) < 0;
            msgbox('Enter a valid Temperature');
        elseif isempty(str2num(solver.volumeEditBox.String)) | str2num(solver.volumeEditBox.String) < 0;
            msgbox('Enter a valid Specific Volume');
        else
     %turns critTemp and critPressure from strings to integers
            solver.critTemp = str2num(solver.critTemp);
            solver.critPressure = str2num(solver.critPressure);
            
     %solves the Van der Waal equation      
            a = (27*R^2*solver.critTemp^2)/(64*solver.critPressure);
            b = (R*solver.critTemp)/(8*solver.critPressure);
            
            specVol = get(solver.volumeEditBox,'String');
            specVol = str2num(specVol);
            
            temperature = get(solver.temperatureEditBox,'String');
            temperature = str2num(temperature);
            
            pressure = ((R*temperature)/(specVol-b))-(a/(specVol)^2);
            set(solver.pressureValue,'String',num2str(pressure));
        end
    end
    
    function CalculateTemperature(src,event)
    %gets the input values from the critical temperature and critical
    %pressure edit boxes
        solver.critTemp = get(solver.critTempEditBox,'String');
        solver.critPressure = get(solver.critPressureEditBox,'String');
        if isempty(str2num(solver.critPressureEditBox.String)) | str2num(solver.critPressureEditBox.String) < 0
            msgbox('Please insert a valid critical pressure!');
        elseif isempty(str2num(solver.critTempEditBox.String)) | str2num(solver.critTempEditBox.String) < 0
            msgbox('Please insert a valid critical temperature!');
        elseif isempty(str2num(solver.pressureEditBox.String)) | str2num(solver.pressureEditBox.String) < 0;
            msgbox('Enter a valid Temperature');
        elseif isempty(str2num(solver.volume2EditBox.String)) | str2num(solver.volume2EditBox.String) < 0;
            msgbox('Enter a valid Specific Volume');
        else
    %turns critTemp and critPressure from strings to integers
            solver.critTemp = str2num(solver.critTemp);
            solver.critPressure = str2num(solver.critPressure);
            
            a = (27*R^2*solver.critTemp^2)/(64*solver.critPressure);
            b = (R*solver.critTemp)/(8*solver.critPressure);

            specVol = get(solver.volume2EditBox,'String');
            specVol = str2num(specVol);
            
            inputPressure = get(solver.pressureEditBox,'String');
            inputPressure = str2num(inputPressure);
            
            finalTemperature = (specVol - b)*(inputPressure + (a/specVol^2))/R;
            set(solver.temperatureValue,'String',num2str(finalTemperature));
        end
    end
end
