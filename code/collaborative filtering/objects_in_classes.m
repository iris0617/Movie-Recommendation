%Calculates the objects in each category. Remember to remove the object
%zero from each category after running this function. The statement
%unique(objects_in_categories(i,;)) may be used to return the unique
%objects in category i.

function objects_in_categories = objects_in_classes(decision_attribute, no_classes,no_objects)

objects_in_categories = zeros(no_classes,no_objects);
unique_classes = unique(decision_attribute);

for i=1:no_objects
    
    [tf,loc] = ismember(decision_attribute(i), unique_classes);
    objects_in_categories(loc,i) = i;
end

end