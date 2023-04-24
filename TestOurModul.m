function message = TestOurModul(step,nbrData) 
    Tw=25; Ts=10; alpha=0.97; R = [300 3700]; M = 20; C = 13; L = 22;
    hamming = @(N)(0.54-0.46*cos(2*pi*(0:N-1).'/(N-1)));
    
    %----------------------------get voice---------------------------------
    sig = audiorecorder(44100,16,1); 
    recordblocking(sig,1);      
    test = getaudiodata(sig); 
    %----------------------------------------------------------------------
    %----------------------------get audio fetures-------------------------
    [TestMFCCs, ~, ~] = mfcc( test, 44100, Tw, Ts, alpha, hamming, R, M, C, L );

    plot(TestMFCCs);
    axis([2 14 -20 60]);
    
    %-----------------------getting fetures of database--------------------
    X_train = cell(nbrData, 1);
    dist = zeros(1,nbrData);
    for i = 1:nbrData
        X_train{i} = load_train_data('list_train.txt', i);
        [MFCCspeakers,~,~] = mfcc(X_train{i}, 44100, Tw, Ts, alpha, hamming, R, M, C, L );
        dist(i) = dtw(TestMFCCs,MFCCspeakers);
        if( dist(i) < 0.24*1.0e+4)
            dist(i) = dist(i);
          else
            dist(i)=1.0e+7;
        end
    end
    %------------------------------moyenne---------------------------------
    dis = zeros(1,nbrData/step);
    i = 1;
    s = 0;
    for j = 1 : nbrData
         s = s + dist(j);
         if mod(j,step)==0
             dis(i) = s /((nbrData/step)*1.0e+7);
             i=i+1;s=0;
         end             
    end
    %----------------------------------------------------------------------
    dis1 = sort(dis);
    file = fopen('Users.txt');
    read = textscan(file, '%s');
    fclose(file);
    names = string(read{1});
    sort(dis)
   
    message = "-----------";
    for i = 1 : nbrData/step 
        if dis1(1) < 0.002
            if  dis1(1) == dis(i)
                message = "ahah I got ya, you are "+names(i);
            end
        else
              message = "please speak up, i cannot hear you";
        end 
    end
end