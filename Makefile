# taken from https://raw.githubusercontent.com/astrapi/opsi-packages/master/mozilla-firefox/Makefile
WGET_COMMON_OPTIONS		= -q -N

PACKAGE_NAME			= mozilla.firefox.op
PACKAGE_VERSION			= 1
VERSION				= 40.0
LOCALE				?= en-US

DOWNLOAD_DIR			= ./tmp
DOWNLOAD_URL			= http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/$(VERSION)/win32/$(LOCALE)/Firefox%20Setup%20$(VERSION).exe

TARGET				= $(PACKAGE_NAME)_$(VERSION)-$(PACKAGE_VERSION).opsi

all: download build install clean

download:
	mkdir -p $(DOWNLOAD_DIR)
	wget $(WGET_COMMON_OPTIONS) -P $(DOWNLOAD_DIR) $(DOWNLOAD_URL)
	mkdir -p CLIENT_DATA/files
	cp '$(DOWNLOAD_DIR)/Firefox Setup $(VERSION).exe' CLIENT_DATA/files/setup.exe
	rm -rf $(DOWNLOAD_DIR)

build:
	sed -e's/@VERSION@/$(VERSION)/g' -e's/@PACKAGE_VERSION@/$(PACKAGE_VERSION)/g' OPSI/control.in > OPSI/control
	opsi-makeproductfile

install:
	opsi-package-manager -i $(TARGET)

clean:
	rm -f $(TARGET)
	rm -rf CLIENT_DATA/files
	rm -f OPSI/control

