import os
import re
import itertools

def clean_legacy_csv(fname):
    
    header = []
    csv = []
    with open(fname,'r',encoding= 'utf-16') as file:
        txt_data = file.read().strip()
        print('Scan' in txt_data)
        """
        #print(txt_data)
        start = re.findall(r'Time',txt_data)
        #print(list(start))
        delim = re.finditer('\n',txt_data)
        delim1,delim2 = itertools.tee(delim,2)
        
        line_data = []
        line_data.append(txt_data[0:next(delim2).start()])
        
        for d1,d2 in zip(delim1,delim2):
            line = txt_data[d1.end()+1:d2.start()]
            line_data.append(line)
        
        raw_dat = ''.join(line_data)
        """
        
                

clean_legacy_csv('legacy_code/Helium Loop 2_20_2018 11_39_43.csv')