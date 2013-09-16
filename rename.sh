find . | grep '^./Beautify/SC' | while read f
do
  echo $f
  git mv $f $(echo $f | sed 's/SC/BY/')
done