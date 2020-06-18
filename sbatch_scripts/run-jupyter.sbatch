#!/bin/bash

#SBATCH --job-name=jupyter.notebook
#SBATCH --partition=datasci
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=16GB
#SBATCH --time=48:00:00

module purge

# Load anaconda
module load python/3.8

port=$(shuf -i 6000-9999 -n 1)

/usr/bin/ssh -N -f -R $port:localhost:$port lochness.njit.edu

cat<<EOF

Jupyter server is running on: $(hostname)
Job starts at: $(date)

Step 1 :

If you are working on campus, please open an iTerm window, run command

ssh -L $port:localhost:$port $USER@lochness.njit.edu

If you are working off campus, you should already have ssh tunneling setup through HPC bastion host, 
that you can directly login to prince with command

ssh $USER@lochness

Please open an iTerm window, run command

ssh -L $port:localhost:$port $USER@lochness

Step 2:

Keep the iTerm windows in the previouse step open. Now open browser, find the line with

The Jupyter Notebook is running at: $(hostname)

the URL is something: http://localhost:${port}/?token=XXXXXXXX (see your token below)

you should be able to connect to jupyter notebook running remotly on prince compute node with above url

EOF

jupyter notebook --no-browser --port $port --notebook-dir=$(pwd)




