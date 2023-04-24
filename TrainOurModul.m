function TrainOurModul(name,nbr) 
    WriteInfile(name,nbr,0);
    name = name+"_"+nbr+".wav";
    fileName = cellstr(name);
    sig = audiorecorder(44100,16,1); 
    recordblocking(sig,1);      
    data = getaudiodata(sig);       
    audiowrite(fileName{1},data,44100);    
end

%fopen('list_train.txt','w'); to clear the audio
