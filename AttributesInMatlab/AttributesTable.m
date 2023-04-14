
clear all; close all;clc; % Clear all variables, close all figures and clear the command window
% Creador: Jorge Suárez Porras
% FECHA: 27-Feb-2023
% EN: Instituto de investigación Tecnológica - C/Francisco Ricci 3, 28015,
% Madrid
% DESCRIPTION OF THE CODE:
% THIS CODE IS USED TO FIND THE NUMBER OF OCCURRENCES OF CERTAIN WORDS IN A
% PDF FILE AND CREATE A TABLE WITH THE RESULTS.


tic % Start the timer to measure the time of execution of the code


%%
% THIS IS THE PATH WHERE THE PDF FILES ARE LOCATED
PATH = 'C:\Users\jsuarezp\Universidad Pontificia Comillas\Dinámica de Compensadores Síncronos en red - Documentos\General\Papers\docs';

%% 
% These are the attributes to look for.
TABLE_ATTRIBUTES_Heading = ["SYNCON","STATCOM","MPSM","DFIG","SMALL SIGNAL","LABORATORY","CONTINGENCY","REGULATOR"]; % This is the heading of the table

Attribute_Keywords = struct(); % This is the structure that will contain the keywords of each attribute

%% These are the kewwords of each attribute

Attribute_Keywords.Attribute1 = {'SC', 'Synchronous Condenser', 'Synchronous Compensator', 'SynCon'};
Attribute_Keywords.Attribute2 = {'STATCOMs', 'Synchoronous Static Compensator'};
Attribute_Keywords.Attribute3 = {'Multipole Synchronous Machine','TYPE 4'};
Attribute_Keywords.Attribute4 = {'DFIG', 'TYPE 3',' Doubly Fed Induction Generator', 'Doubly Fed Induction Machine'};
Attribute_Keywords.Attribute5 = {'Small signal', 'small-signal'};
Attribute_Keywords.Attribute6 = {'Laboratory','experimental','setup'};
Attribute_Keywords.Attribute7 = {'Contingency','fault','faults'};
Attribute_Keywords.Attribute8 = {'Regulator','Regulation'};
Atti
%%
listing = dir(PATH);

TABLE_ATTRIBUTES = table();
%%
NumberOfAttributes = length(fieldnames(Attribute_Keywords));
Attribute_Found = zeros(1,NumberOfAttributes);


for i = 1:size(listing,1)
    try
        filename = strcat(PATH,'\',listing(i).name);
        textfromfile = extractFileText(filename);

        STRUCT_NEW_ROW = struct();

        STRUCT_NEW_ROW.TITLE = string(listing(i).name);

        for j = 1:NumberOfAttributes
            NumberOfCoincidences = 0;
            NumberOfWordsInAttribute_j = length(Attribute_Keywords.("Attribute"+j));
            for k = 1:NumberOfWordsInAttribute_j
                words = Attribute_Keywords.("Attribute"+j);
                NumberOfCoincidences = NumberOfCoincidences + length(strfind(lower(textfromfile),lower(words(k))));
            end
            STRUCT_NEW_ROW.("Attribute"+j) = NumberOfCoincidences;
            
        end
        if (isempty(TABLE_ATTRIBUTES))
            TABLE_ATTRIBUTES = struct2table(STRUCT_NEW_ROW);
            TABLE_ATTRIBUTES.Properties.VariableNames = ["TITLE",TABLE_ATTRIBUTES_Heading];
        else
            NewTable = struct2table(STRUCT_NEW_ROW);
            NewTable.Properties.VariableNames = ["TITLE",TABLE_ATTRIBUTES_Heading];
            TABLE_ATTRIBUTES = [TABLE_ATTRIBUTES;NewTable];
        end
        
    catch
        fprintf("\n\nNO PDF FOUND FOR THAT REFERENCE IN THE FOLDER\n\n");
    end
end

writetable(TABLE_ATTRIBUTES,"EXCEL_TABLE_ATTRIBUTES.xlsx")
toc

save TABLE_ATTRIBUTES TABLE_ATTRIBUTES

AnalizarAtributos; % This is the name of the script that will be executed