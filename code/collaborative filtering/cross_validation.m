function [test, train] = cross_validation(data,i,x,cv)

   if i==1
        test = data(x(1:cv),:);
        train = data(x(cv+1:end),:);
        return ;
    end
    
    if i==10
        test = data(x(end-cv:end),:);
        train = data(x(1:end-cv-1),:);
        return ;
    end
        
    test =  data(x( ( (i-1)*cv)+1:(i*cv)),:);
    train = data(x( 1:((i-1)*cv)),:);
    train = [train; data(x((i*cv)+1 : end), :)];
   end 
