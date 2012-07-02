wget -O hope.tar.gz https://github.com/xiejian/hope.xiej/tarball/master
tar -zxvf hope.tar.gz
rm -rf hope.xiej/
mv xiejian-hope.xiej*/ hope.xiej/
cp -r hope.xiej ..

for f in ../hope.xiej/web/static/js/*.js
do
	java -jar yuicompressor-2.4.7.jar -o $f $f
done
for f in ../hope.xiej/web/static/css/*.css
do
	java -jar yuicompressor-2.4.7.jar -o $f $f
done

sudo /etc/init.d/apache2 restart


