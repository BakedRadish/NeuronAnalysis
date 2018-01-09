viewpoints = 75;

tic

Neurontxt = ImportTxt(strcat(fullfile(AP{1},AF{1}{53}(1:end-4)),'.txt'));
Struct.x = Neurontxt(:,1);
Struct.y = Neurontxt(:,2);
Struct.z = Neurontxt(:,3);
[pt, plistt, latlonlistt] = ProfileArea(Struct,viewpoints,5);

toc


tic

scaling = 3;
Apath = strcat(path,'/Apical');
[AP, AF] = openNeuronOBJS(Apath);
Neuron = struct();
i = 1;
j = 53;
[Vertices{i,j}, ~, Faces{i,j}, ~] = ReadOBJtest(strcat(AP{i},'\',AF{i}{j}));
Neuron.name = AF{i}{j}(1:end-4);
Neuron.path = AP{i};
Neuron.vertices = vertcat(Vertices{i,j}{:,:});
Neuron.faces = vertcat(Faces{i,j}{:,:});
xrange = max(Neuron.vertices(:,1)) - min(Neuron.vertices(:,1));
yrange = max(Neuron.vertices(:,2)) - min(Neuron.vertices(:,2));
zrange = max(Neuron.vertices(:,3)) - min(Neuron.vertices(:,3));
TempVox = VOXELISE(round(xrange*scaling), round(yrange*scaling), round(zrange*scaling), Neuron);
TempInd = find(TempVox);
Temp = struct();
[Temp.x, Temp.y, Temp.z] = ind2sub(size(TempVox),TempInd);
[p, plist, latlonlist] = ProfileArea(Temp,viewpoints,5);

toc