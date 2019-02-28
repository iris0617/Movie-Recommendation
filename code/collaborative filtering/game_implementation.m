% This function will calculate the rough set regions
function [results, threshold_alpha,threshold_beta, P_C_X, class_prior] = game_implementation(no_objects,no_classes,objects_in_categories,eqv,file)

[rows,col] = size(eqv);

U = no_objects;


for i=1:rows
    P_X(i) = length(unique(setdiff(eqv(i,:),0))) / U;
end 



for i=1:no_classes
    for j=1: rows
        P_C_X(i,j) = length(intersect(setdiff(objects_in_categories(i,:),0), eqv(j, :))) / length(unique(setdiff(eqv(j,:),0)));
    end 
end 

for i=1:no_classes
    class_prior(i) = (length(unique(objects_in_categories(i,:)))-1) / U;
end 





% fid = fopen('Regions.txt','w');
% fid1 = fopen('Entropies.txt','w');
C = 3;
fid = fopen(file, 'w');


fprintf(fid, 'alpha\t\t beta\t\t Pos Reg \t\t Bnd Reg  \t\t Neg Reg \t\t Accuracy \t\t generality \n');

for a=1:no_classes
    fprintf(fid, '\n C%d \n',a); 
    alpha = 1.0;
    beta = 0.0;
    [Pr_pos, Pr_neg, Pr_bnd, accuracy, generality] = accuracy_calculations(alpha, beta, P_C_X, P_X, a);
    Pawlak_accuracy(a) = accuracy;
    Pawlak_generality(a) = generality;
    printing_function(fid, alpha, beta, Pr_pos, Pr_bnd, Pr_neg, accuracy,generality);        
    
    double_alpha = 0.90;
    single_alpha = 0.95;
    double_beta = 0.10;
    single_beta = 0.05;
  
    aaa = 1;
    alpha_intial = 1;
    beta_initial = 0;
    while (1) 
    
           
        if (aaa ~=1)
            alpha_initial = alpha;
            beta_initial = beta;
        end
 
        aaa = aaa+1;
    
          
        
        [Pr_pos, Pr_neg, Pr_bnd, accuracy_game(1,1), generality_game(1,1)] = accuracy_calculations(double_alpha, beta, P_C_X, P_X, a);
        alpha_values(1,1) = double_alpha;
        beta_values(1,1) = beta;
        
        
        [Pr_pos, Pr_neg, Pr_bnd, accuracy_game(1,2), generality_game(1,2)] = accuracy_calculations(double_alpha, single_beta, P_C_X, P_X, a);
        alpha_values(1,2) = double_alpha;
        beta_values(1,2) = single_beta;
        
        
        [Pr_pos, Pr_neg, Pr_bnd, accuracy_game(1,3), generality_game(1,3)] = accuracy_calculations(single_alpha, single_beta,P_C_X, P_X, a);
        alpha_values(1,3) = single_alpha;
        beta_values(1,3) = single_beta;
        
        
        [Pr_pos, Pr_neg, Pr_bnd, accuracy_game(2,1), generality_game(2,1)] = accuracy_calculations(double_alpha, single_beta,P_C_X, P_X, a);
        alpha_values(2,1) = double_alpha;
        beta_values(2,1) = single_beta;        
        
     
        [Pr_pos, Pr_neg, Pr_bnd, accuracy_game(2,2), generality_game(2,2)] = accuracy_calculations(double_alpha, double_beta,P_C_X, P_X, a);
        alpha_values(2,2) = double_alpha;
        beta_values(2,2) = double_beta;        
        
        
        [Pr_pos, Pr_neg, Pr_bnd, accuracy_game(2,3), generality_game(2,3)] = accuracy_calculations(single_alpha, double_beta, P_C_X, P_X,a);
        alpha_values(2,3) = single_alpha;
        beta_values(2,3) = double_beta;        
        
       
        [Pr_pos, Pr_neg, Pr_bnd, accuracy_game(3,1), generality_game(3,1)] = accuracy_calculations(single_alpha, single_beta,P_C_X, P_X, a);
        alpha_values(3,1) = single_alpha;
        beta_values(3,1) = single_beta;        
        
        
        [Pr_pos, Pr_neg, Pr_bnd, accuracy_game(3,2), generality_game(3,2)] = accuracy_calculations(single_alpha, double_beta, P_C_X, P_X,a);
        alpha_values(3,2) = single_alpha;
        beta_values(3,2) = double_beta;        
        
        
        [Pr_pos, Pr_neg, Pr_bnd, accuracy_game(3,3), generality_game(3,3)] = accuracy_calculations(alpha, double_beta, P_C_X, P_X,a);
        alpha_values(3,3) = alpha;
        beta_values(3,3) = double_beta;        
        
        
        [Pr_pos, Pr_neg, Pr_bnd, previous_accuracy, previous_generality] = accuracy_calculations(alpha, beta, P_C_X, P_X, a);
        
        single_alpha_dec = alpha - single_alpha;
        double_alpha_dec = alpha - double_alpha;
        single_beta_dec = beta - single_beta;
        double_beta_dec = beta - double_beta;
        
        
        [alpha, beta, new_generality,equilibruim_index_row, equilibruim_index_col] = game(accuracy_game,generality_game, alpha_values, beta_values);    
       
        
                
        generality_diff = new_generality - previous_generality;
        if generality_diff == 0
            alpha = single_alpha;
            beta = single_beta;
        end
                
                
        [double_alpha, single_alpha, double_beta, single_beta] = update_thresholds(alpha,beta, single_alpha_dec, double_alpha_dec, single_beta_dec, double_beta_dec, C, generality_diff);  
        
         [Pr_pos, Pr_neg, Pr_bnd, accuracy, generality] = accuracy_calculations(alpha, beta, P_C_X, P_X, a);
         
         

              
         if ((class_prior(a) < Pr_pos) || (Pr_bnd == 0) || alpha <=0.5 || beta >=0.5)
            GTRS_accuracy(a) = accuracy;
            GTRS_generality(a) = generality;
             break;
            
         else
            printing_function(fid, alpha, beta, Pr_pos, Pr_bnd, Pr_neg, accuracy, generality);
         end
         
   
    end  
    threshold_alpha(a) = alpha_initial;
    threshold_beta(a)  = beta_initial;

end
Pawlak_acc = (Pawlak_accuracy(1) + Pawlak_accuracy(3))/2;
Pawlak_gen = (Pawlak_generality(1) + Pawlak_generality(3))/2;
GTRS_acc = (GTRS_accuracy(1) + GTRS_accuracy(3))/2;
GTRS_gen = (GTRS_generality(1) + GTRS_generality(3))/2;
results = [GTRS_acc Pawlak_acc GTRS_gen Pawlak_gen];
  fclose(fid);
end 