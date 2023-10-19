import re
import pandas as pd
import os
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--task', type=str, default='Cifar10')
parser.add_argument('--lam', type=float, default=0.5)
parser.add_argument('--f0', type=float, default=0.5)
parser.add_argument('--fname', type=str, default='')

args = parser.parse_args()
task = args.task
lam = args.lam
f0 = args.f0
fname = args.fname
# Read log data from a file
# fname = 'Cifar10_ResNet-32_CrossEntropy_42_MLP_2023-10-19-03-53-20-799101.log'
log_path = os.path.join('../Cifar10/logs/', fname)

if task == "Cifar10":
    p = (r"Epoch (\d+).*?Many:(\d+\.\d+),\s*Medium:(\d+\.\d+),\s*Low:(.*),\s*Overall:(\d+\.\d+)")
else:    
    p = (r"Epoch (\d+).*?Many:(\d+\.\d+),\s*Medium:(\d+\.\d+),\s*Low:(\d+\.\d+),\s*Overall:(\d+\.\d+)")

with open(log_path, 'r') as file:
    lines = file.readlines()

rows = []
for line in lines:
    m = re.findall(p, line)
    if len(m)>0:
        rows.append(m[0])

df = pd.DataFrame(data=rows, columns=["Epoch", "Many", "Medium", "Low", "Overall"])
csv_path = os.path.join('../experiments', f'{task}_L{lam}_F{f0}_output.csv')
df.to_csv(csv_path, index=False)
