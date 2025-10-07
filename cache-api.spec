Name: cache-api
Version: 1.0.0
Release: 1%{?dist}
Summary: Cache Proxy API Service
License: MIT
URL: https://company.com
Source0: cache-api.py
Source1: config-api.yaml
Source2: cache-api.service

BuildArch: noarch

%global __os_install_post %{nil}
%global __python_bytecompile %{nil}

%description
Cache Proxy API service with Redis caching layer

%prep
%setup -q -c -T

%build
# Nothing to build

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/opt/cache-api
mkdir -p %{buildroot}/etc/cache-api
mkdir -p %{buildroot}/usr/lib/systemd/system

cp %{SOURCE0} %{buildroot}/opt/cache-api/cache-api.py
cp %{SOURCE1} %{buildroot}/etc/cache-api/config.yaml
cp %{SOURCE2} %{buildroot}/usr/lib/systemd/system/cache-api.service

%files
/opt/cache-api/cache-api.py
/etc/cache-api/config.yaml
/usr/lib/systemd/system/cache-api.service

%post
systemctl daemon-reload

%preun
systemctl stop cache-api || true

%postun
systemctl daemon-reload
