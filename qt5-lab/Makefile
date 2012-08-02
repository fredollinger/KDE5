export QTDIR=/opt/qt5
all:
	mkdir -p build
	cd build && cmake .. && make 2>err
	
err:
	vim build/err
clean:
	cd build && make clean

