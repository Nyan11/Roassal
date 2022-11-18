#sudo apt update
#sudo apt install graphviz

#curl -L https://get.pharo.org/100+vm | bash
curl -L https://get.pharo.org/64/alpha+vm | bash

yovi="/tmp/io.txt"
echo ${GITHUB_BASE_REF} > $yovi
echo ${GITHUB_REPOSITORY} >> $yovi

cat $yovi
./pharo --headless Pharo.image ./scripts/runTest.st

FILE=/tmp/result.txt
if [ ! -f "$FILE" ]; then
    echo "ERROR: $FILE does not exists!"
    exit 1
fi

if ! grep -q END "$FILE"; then
    echo "Did not end properly"
    exit 1
fi	


cat $FILE
#RES = `grep ERROR $FILE`
#if [ -n "$RES" ]; then
if grep -q ERROR "$FILE"; then
		echo "SOME ERRORS!"
		exit 1
else
		echo "ALL TEST PASSED"
		exit 0
fi
