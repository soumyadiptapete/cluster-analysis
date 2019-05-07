
from ovito import * 
from ovito.io import import_file
from ovito.modifiers import ClusterAnalysisModifier
from ovito.modifiers import SelectParticleTypeModifier
import numpy as np
import os

CO=np.array([1.35])
fileID=[0,1,2]
ts_count=1
for i in range(len(fileID)):
    
    os.chdir("..")
    filename_in='traj_W_stage_slice'+str(fileID[i])+'.lammpstrj'
    
   
    node = import_file(filename_in,multiple_frames = True)
    frame=node.source.num_frames
    frame_count=frame
    frame=frame-frame_count
    
    PT = SelectParticleTypeModifier(property = "Particle Type")
    PT.types ={4}
    node.modifiers.append(PT)
    node.modifiers.append(ClusterAnalysisModifier(cutoff = CO[0], sort_by_size = True,only_selected=True))
    
 
    output_dir='./cluster_W'
    os.chdir(output_dir)
    for j in range(frame_count):
        
        
        node.compute(frame)
        name1='atom_count.txt'
        num_atoms=node.output.attributes['SelectParticleType.num_selected']
        oa=np.array([num_atoms,0])
        np.savetxt(name1,oa)
        
        
        node.compute(frame)  
        cluster_sizes = np.bincount(node.output.particle_properties['Cluster'].array)
        cluster_count=node.output.attributes['ClusterAnalysis.cluster_count']
        name2='Frame_'+str(ts_count)+ '_cutoff_'+ str(CO[0])+ '.txt'
        name3='Frame_'+str(ts_count)+ '_cutoff_'+ str(CO[0])+ 'Clustercount.txt'
        cc=np.array([cluster_count,0])
        np.savetxt(name3,cc)
        np.savetxt(name2,cluster_sizes)
                 
        frame=frame+1
        ts_count=ts_count+1
