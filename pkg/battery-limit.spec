#INCOMPLETE
Summary: a simple script to limit battery charge
Name: battery-limit
Version: 0.2
Release: 1%{?dist}
License: GPL
URL: https://github.com/adamthiede/battery-limit
Source: https://github.com/adamthiede/battery-limit/archive/refs/tags/%{version}.tar.gz

BuildRequires: systemd

Requires: systemd bash

#%global debug_package %{nil}

%description
Limit the battery charge of a battery-powered Linux device with systemd.

%prep
%setup -q

%install
install -Dm755 battery-limit.sh %{buildroot}%{_bindir}/battery-limit.sh
#install -Dm644 LICENSE %{buildroot}%{_datadir}/licenses/battery-limit/LICENSE
install -Dm644 battery-limit.service %{buildroot}%{_prefix}/lib/systemd/system/battery-limit.service

%files
%{_bindir}/battery-limit.sh
%{_prefix}/lib/systemd/system/battery-limit.service
%doc README.md
%license LICENSE

%changelog
* Fri Apr 5 2022 Adam Thiede <me@adamthiede.com>
- Created spec file
