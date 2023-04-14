clear all
load("TABLE_ATTRIBUTES.mat"); %Load table with attributes

%Normalize table
ARTICLES = TABLE_ATTRIBUTES.TITLE; %Get articles names
ARTICLES_NUMBERS = 1:length(ARTICLES); %Get number of articles
ATTRIBUTES = TABLE_ATTRIBUTES.Properties.VariableNames(2:end);

for i = 1:length(ARTICLES_NUMBERS)
    for j = 2:length(ATTRIBUTES)
        TABLE_ATTRIBUTES(i,j) = array2table(table2array(TABLE_ATTRIBUTES(i,j))./sum(table2array(TABLE_ATTRIBUTES(i,2:length(ATTRIBUTES)))) );
    end
end

VALORES_ATTRIBUTOS = TABLE_ATTRIBUTES(2:end,2:end); 

toplot = transpose(str2double(table2array(TABLE_ATTRIBUTES))); %Transpose table to plot

%% 
fig1 = figure(1);clf;
fig1.Color = [1 1 1];
b2 = bar3(toplot(1:length(ATTRIBUTES),:));
bb2 = get(b2(3),'parent');
set(bb2,'yticklabel',ATTRIBUTES);

