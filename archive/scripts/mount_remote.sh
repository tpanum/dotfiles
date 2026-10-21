set -e

localdir=$1
localtmpdir=$(mktemp -d -t ssh-mount-XXXXXXXXXXXX)
remotedir=$2

function finish {
    mount -l $localtmpdir
    rm $localtmpdir
}
trap finish EXIT

sshfs "${localtmpdir}" "${remotedir}"

localdirSlash="${localdir}"
[[ "${localdirSlash}" != */ ]] && localdirSlash="${localdir}/"

# echo "Syncing... [tmp: $localtmpdir]"
# rsync -azPq --filter="- ${localdirSlash}.gitignore" $localdirSlash $remotedir

echo "Waiting for changes..."

inotifywait -r -m -e close_write --format '%w%f' $localdir | while read MODFILE
do
  if [[ $MODFILE == *"flycheck_"* ]]; then
    continue
  fi

  if [[ $MODFILE == *".mypy_cache"* ]]; then
    continue
  fi

  if [[ $MODFILE == *".git/"* ]]; then
      continue
  fi

  if [[ $MODFILE == *"__pycache__"* ]]; then
      continue
  fi

  basefile=${MODFILE#$localdir}
  outfile="${localtmpdir}${basefile}"
  dir=$(dirname "${outfile}")
  mkdir -p $dir
  cp $MODFILE $outfile
  echo "$(date +%H:%M:%S) Updated: ${basefile} => ${outfile}"
done
