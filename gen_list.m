function gen_list
rng(7);
eval('!find data/image -name "*.jpg" > list.txt');
a = importdata('list.txt');
a = a(randperm(length(a)));
p = rand(size(a));
t = p < 0.9;
tr = fopen('list_train.txt','w');
te = fopen('list_test.txt','w');
for i = 1:length(a)
    if t(i)
        id = tr;
    else
        id = te;
    end
    s = a{i}(12:end);
    l = strfind(s,'/');
    class = str2double(s(1:l(1)-1));
    fprintf(id,'%s %d\n',a{i},class-1);
end
fclose(tr);
fclose(te);

eval('!find sv_data/image -name "*.jpg" > list.txt');
a = importdata('list.txt');
a = a(randperm(length(a)));
sv = fopen('list_sv.txt', 'w');
load sv_data/sv_make_model_name.mat
load data/misc/make_model_name.mat
for i = 1:length(a)
    s = a{i}(15:end);
    l = strfind(s,'/');
    class = str2double(s(1:l(1)-1));
    cn = sv_make_model_name{class, 1};
    for j = 1:length(make_names)
        if strcmp(make_names(j), cn)
            break
        end
    end
    if strcmp(make_names(j), cn)
        fprintf(sv, '%s %d\n', a{i}, j - 1);
    else
        fprintf(1, '%s\n', cn);
    end
end
fclose(sv);