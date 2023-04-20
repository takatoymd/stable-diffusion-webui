CLI_ARGS=$1
CWD=`pwd`
python3 -u $CWD/launch.py --xformers --listen --port 7860 #--enable-insecure-extension-access