#INCOMPLETE
Summary: a simple script to limit battery charge
Name: battery-limit
Version: 0.1
Release: 1%{?dist}
License: GPL
URL: https://gitlab.com/elagost/battery-limit
Source: https://gitlab.com/elagost/battery-limit/-/archive/%{version}/%{name}-%{version}.tar.gz

BuildRequires: systemd

Requires: systemd

#%global debug_package %{nil}

%description
Limit the battery charge of a battery-powered Linux device with systemd.

%prep
%setup -q

%install
install -Dm755 battery-limit.sh ${_bindir}/battery-limit.sh
install -Dm755 battery-limit.service ${_prefix}/lib/systemd/system/battery-limit.service

%files
%{_bindir}/battery-limit.sh
${_prefix}/lib/systemd/system/battery-limit.service
%doc README.md
%license LICENSE

%changelog
* Fri Apr 5 2022 Adam Thiede <me@adamthiede.com>
- Created spec file
