function message = test(nbrUser,nbrData) 
    Tw=25; Ts=10; alpha=0.97; R = [300 3700]; M = 20; C = 13; L = 22;
    hamming = @(N)(0.54-0.46*cos(2*pi*(0:N-1).'/(N-1)));
    %-------------------get voice---------------------
    sig = audiorecorder(44100,16,1); 
    recordblocking(sig,1);      
    test = getaudiodata(sig); 
    
    [tMFCCs, ~, ~] = mfcc( test, 44100, Tw, Ts, alpha, hamming, R, M, C, L );
    
    X_train = cell(nbrData, 1);
    dist2 = zeros(1,nbrData);
    dist1 = zeros(1,nbrData);
    for i = 1:nbrData
        X_train{i} = load_train_data('list_train.txt', i);
        [MFCCspeakers,~,~] = mfcc( X_train{i}, 44100, Tw, Ts, alpha, hamming, R, M, C, L );
        dist1(i) = dtw(tMFCCs,MFCCspeakers);
        dist1
        if( dist1(i)<0.3*1.0e+4)
            dist2(i) = dist1(i);
          else
            dist2(i)=1.0e+7;
        end
    end

    dis = zeros(1,nbrUser);
    i = 1;
    for j = 1:nbrData
         dis(i) = dis(i) + dist2(j);
         if mod(j,6)==0
             dis(i) = dis(i)/(6*1.0e+7);
             i=i+1;
         end             
    end
 
    dis1=sort(dis); 
    spe={'ismail','ahmed','bilal','nisrine','ikram'}; 
    sort(dis)
   
    message = "";
    for i=1:nbrUser
        if dis1(1)<0.5
            if  dis1(1) == dis(i)
                disp(spe(i));
            end
        else
              disp('not found');
        end 
    end
end
    