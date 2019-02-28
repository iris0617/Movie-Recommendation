% The decision attributes takes valeues -1,0,1 
clear all
file = '/home/dextrose/azam200n/P 13/results.dat';

users = dlmread('/home/dextrose/azam200n/P 13/movielen/users.dat');
for i=401:800
    if users(i,3) <=30
        users(i,3) = 0;
    elseif  users(i,3) > 30 && users(i,3) < 50
        users(i,3) = 1;
    else 
        users(i,3) = 2;
    end 
end 

        

users = users(401:800,2:4);

data1 = dlmread('/home/dextrose/azam200n/P 13/movielen/additional_data/rating_top_ten_movies_400_5.dat');

data = [users, data1(:,10)];


folds = 10;
[rows, col] = size(data);
no_objects = rows;
x = 1:no_objects;%randperm(no_objects);
cv = floor(rows/folds);


for i=1:folds


    [test, train] = cross_validation(data,i,x,cv);
    
%  train = data(1:320,:);
%  test = data(321:end,:);
%  
 
 
 
 
%adjust the data

    decision_attribute = train(:,end);
    no_classes = length(unique(decision_attribute));
    train = train(:,1:end-1);

    eqv = equivalance_classes(train);
    [no_objects, col] = size(train);
    
    objects_in_categories = objects_in_classes(decision_attribute,no_classes,no_objects);
   [results_train(i,:),alpha,beta,P_C_X,class_prior] = game_implementation(no_objects,no_classes,objects_in_categories,eqv,file);
    
    [accuracy1,generality1] = Accuracy_cal(alpha,beta,eqv,test,train,P_C_X, class_prior,no_classes);
   
    [accuracy,generality] = Accuracy_cal([1.0 1.0 1.0],[0.0 0.0 0.0],eqv,test,train,P_C_X, class_prior,no_classes);
    
    results_test(i,:) = [accuracy1, accuracy, generality1, generality]
end

mean(results_train)
mean(results_test)
    
