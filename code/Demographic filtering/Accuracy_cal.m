function [final_accuracy, final_generality] = Accuracy_cal(alpha,beta,eqv,test,train,P_C_X, class_prior,no_classes)

[row,col] = size(test);
decision_attribute = test(:,end);
test = test(:,1:end-1);
Pos = zeros(no_classes,1);
correct = zeros(no_classes,1);
Neg = zeros(no_classes,1);
class_accuracy = zeros(no_classes,1);




for i=1:row
    [row_eqv,col_eqv] = size(eqv);
    
    for j=1:row_eqv
        eqv_classes = setdiff(unique(eqv(j,:)),0);
        eqv_class_value = train(eqv_classes(1),:);
        distances(j)  = realpow(sum((eqv_class_value - test(i,:) ).^2),0.5);
    end
        [min_value,min_index] = min(distances);
%         if min_value(1) ~= 0
%             continue;
% 
%         else
            
            for a=1:no_classes
                if P_C_X(a,min_index(1)) >= alpha(a)
                    Pos(a) = Pos(a)+1;
                
                    if decision_attribute(i) ==a;
                        correct(a) = correct(a)+1;
                    end

                end
        
                if P_C_X(a,min_index(1)) < alpha(a) &&  P_C_X(a,min_index(1)) > beta(a)
            
                end
        
                if P_C_X(a,min_index(1)) <= beta(a)
                    Neg(a) = Neg(a)+1;
                    if decision_attribute(i) ~=a;
                        correct(a) = correct(a)+1;
                    end
                end
       
            
%             end
        end
    end

 

for a=1:no_classes
    class_accuracy(a) = correct(a)/ (Pos(a)+Neg(a)); 
    generality(a) = (Pos(a) + Neg(a))/row;

end 


final_generality = (generality(1)+generality(3))/2;

final_accuracy = (class_accuracy(1)+class_accuracy(3))/2;

end 
