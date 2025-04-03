import torch as th
import pandas as pd
import math
df = pd.read_csv(f'./include/code_gen/parameter_radix2_vkfft.csv')
def performance_modeling_kernel(R, r, GlBandwith, ShBandwith, PeakPerf, szDataType=8):
    # Data
    nbData = R
    
    # Byte
    szData = R * szDataType
    
    # Number of transactions, shared memory
    nbShTrans = (math.log(R, 2) // math.log(r, 2)) * 2
    
    # Number of transactions, global memory
    nbGlTrans = 2
    
    # Number of data transactions, shared memory
    nbShDataTrans = szData * nbShTrans
    
    # Number of data transactions, global memory
    nbGlDataTrans = szData * nbGlTrans
        
    # FLOP 5nlogn
    nbFLOP = math.log(R, 2) * R * 5
    
    # Time
    tGlTrans = nbGlDataTrans / GlBandwith
    tShTrans = nbShDataTrans / ShBandwith
    tComp = nbFLOP / PeakPerf
    tTotal = tGlTrans + tShTrans + tComp
    
    # FLOPS
    avgFLOPS = nbFLOP / tTotal
    avgBandwidth = nbGlDataTrans / tTotal
    
    return avgFLOPS, avgBandwidth
    
    

if __name__ == '__main__':
    GlBandwith = 
    
    for index, row in df.iterrows():
        if(int(row['logN1']) > 14):
            break
        print(row)
        R = int(row['logN1'])
        r = int(row['signal_per_thread_1'])
        
        performance_modeling_kernel(R, r)
    